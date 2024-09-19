import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travio/controller/provider/booking_provider.dart';

/// Provider for handling payment operations and booking management.
class PaymentProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  bool isLoading = false;
  String paymentStatus = '';
  bool showResult = false;
  late BuildContext _context;

  PaymentProvider() {
    _initializeRazorpay();
  }

  /// Initializes Razorpay event listeners.
  void _initializeRazorpay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  /// Starts a payment process with Razorpay.
  void makePayment({
    required String amount,
    required String contact,
    required String email,
    required BuildContext context,
  }) {
    isLoading = true;
    _context = context;
    notifyListeners();

    var options = {
      'key': 'rzp_test_5CvknA4rDqeKqA',
      'amount': (double.parse(amount) * 100).toInt(),
      'name': 'Trip Planning App',
      'description': 'Package Payment',
      'timeout': 180,
      'currency': 'INR',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9584847474',
        'email': 'test@razorpay.com',
      },
    };

    _razorpay.open(options);
  }

  /// Handles successful payment response.
  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    isLoading = false;
    paymentStatus = 'Payment Successful: ${response.paymentId}';
    showResult = true;
    notifyListeners();
    _handleSuccessfulPayment(response.paymentId!);
  }

  /// Handles payment error response.
  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    isLoading = false;
    paymentStatus = 'Payment Failed: ${response.message}';
    showResult = true;
    notifyListeners();
  }

  /// Handles external wallet selection.
  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    isLoading = false;
    paymentStatus = 'External Wallet Selected: ${response.walletName}';
    showResult = true;
    notifyListeners();
  }

  /// Processes a successful payment.
  Future<void> _handleSuccessfulPayment(String paymentId) async {
    try {
      final bookingProvider =
          Provider.of<BookingProvider>(_context, listen: false);
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        _updatePaymentStatus('Failed: User not authenticated');
        return;
      }

      final String userId = currentUser.uid;

      await _addPackageToUserCollection(userId, bookingProvider);
      await _incrementBookedCount(bookingProvider.packageId);

      _updatePaymentStatus('Success');
    } catch (e) {
      _updatePaymentStatus('Failed: $e');
    }
  }

  /// Adds the package to the user's collection in Firestore.
  Future<void> _addPackageToUserCollection(
      String userId, BookingProvider bookingProvider) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final existingBooking = await firestore
        .collection('bookedPackages')
        .where('userId', isEqualTo: userId)
        .where('packageId', isEqualTo: bookingProvider.packageId)
        .where('startDate', isEqualTo: bookingProvider.rangeStartDate)
        .get();

    if (existingBooking.docs.isEmpty) {
      await firestore.collection('bookedPackages').add({
        'userId': userId,
        'packageId': bookingProvider.packageId,
        'startDate': bookingProvider.rangeStartDate,
        'endDate': bookingProvider.rangeEndDate,
        'bookingDate': DateTime.now(),
      });
    } else {
      throw Exception('Package already booked on the same date.');
    }
  }

  /// Increments the booked count of a package in Firestore.
  Future<void> _incrementBookedCount(String? packageId) async {
    if (packageId == null) return;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final packageRef = firestore.collection('trip_packages').doc(packageId);

    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(packageRef);
      final currentBookedCount = snapshot.get('booked_count') ?? 0;

      transaction.update(packageRef, {
        'booked_count': currentBookedCount + 1,
      });
    });
  }

  /// Moves expired bookings to the archive.
  Future<void> moveExpiredBookingsToArchive() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DateTime now = DateTime.now();
    log('Current DateTime: $now');

    try {
      final QuerySnapshot expiredBookings = await firestore
          .collection('bookedPackages')
          .where('endDate', isLessThan: now)
          .get();

      log('Expired Bookings: ${expiredBookings.docs.length} found');

      if (expiredBookings.docs.isNotEmpty) {
        for (var booking in expiredBookings.docs) {
          final bookingData = booking.data() as Map<String, dynamic>;

          await firestore.collection('archivedPackages').add(bookingData);
          await firestore.collection('bookedPackages').doc(booking.id).delete();
        }

        _updatePaymentStatus('Expired bookings moved to archive');
      } else {
        _updatePaymentStatus('No expired bookings found');
      }
    } catch (e) {
      _updatePaymentStatus('Failed to move expired bookings: $e');
    }
  }

  /// Updates the payment status and notifies listeners.
  void _updatePaymentStatus(String status) {
    paymentStatus = status;
    showResult = true;
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  /// Resets the payment provider state.
  void reset() {
    paymentStatus = '';
    showResult = false;
    notifyListeners();
  }
}
