import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:travio/controller/provider/booking_provider.dart';

class PaymentProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  bool isLoading = false;
  String paymentStatus = '';
  bool showResult = false;
  late BuildContext _context;

  PaymentProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void makePayment({
    required String amount,
    required String contact,
    required String email,
    required BuildContext context,
  }) {
    isLoading = true;
    _context = context; // Store the context for later use
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
        'contact': contact,
        'email': email,
      },
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    isLoading = false;
    paymentStatus = 'Payment Successful: ${response.paymentId}';
    showResult = true;
    notifyListeners();
    _handleSuccessfulPayment(response.paymentId!);
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    isLoading = false;
    paymentStatus = 'Payment Failed: ${response.message}';
    showResult = true;
    notifyListeners();
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    isLoading = false;
    paymentStatus = 'External Wallet Selected: ${response.walletName}';
    showResult = true;
    notifyListeners();
  }

  Future<void> _handleSuccessfulPayment(String paymentId) async {
    try {
      final bookingProvider = Provider.of<BookingProvider>(_context, listen: false);

      // Fetch the current user's ID from FirebaseAuth
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // If the user is not authenticated, handle the error
        paymentStatus = 'Failed: User not authenticated';
        showResult = true;
        isLoading = false;
        notifyListeners();
        return;
      }

      // Use the actual user ID
      final String userId = currentUser.uid;

      // Update the package in Firebase
      await _addPackageToUserCollection(userId, bookingProvider);

      // Update the `bookedCount` field in the package model
      await _incrementBookedCount(bookingProvider.packageId);

      // Schedule package removal after the end date
      await _schedulePackageRemoval(userId, bookingProvider.packageId, bookingProvider.rangeEndDate);

      paymentStatus = 'Success';
      showResult = true;
      isLoading = false;
      notifyListeners();

    } catch (e) {
      paymentStatus = 'Failed: $e';
      showResult = true;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _addPackageToUserCollection(String userId, BookingProvider bookingProvider) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query Firestore to check if the package has been booked by the user on the same date
    final existingBooking = await firestore.collection('bookedPackages')
        .where('userId', isEqualTo: userId)
        .where('packageId', isEqualTo: bookingProvider.packageId)
        .where('startDate', isEqualTo: bookingProvider.rangeStartDate)  // Assuming you have startDate field
        .get();

    // If no existing booking, proceed with adding the package to the user's bookedPackages collection
    if (existingBooking.docs.isEmpty) {
      await firestore.collection('bookedPackages').add({
        'userId': userId,
        'packageId': bookingProvider.packageId,
        'startDate': bookingProvider.rangeStartDate,
        'endDate': bookingProvider.rangeEndDate,
        'bookingDate': DateTime.now(),
      });

      // Update bookedCount for the package
      await _incrementBookedCount(bookingProvider.packageId);
    } else {
      // Handle case where the package is already booked on the same date
      throw Exception('Package already booked on the same date.');
    }
  }

  Future<void> _incrementBookedCount(String? packageId) async {
    if (packageId == null) return;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final packageRef = firestore.collection('trip_packages').doc(packageId);

    firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(packageRef);
      final currentBookedCount = snapshot.get('booked_count') ?? 0;

      transaction.update(packageRef, {
        'booked_count': currentBookedCount + 1,
      });
    });
  }

  Future<void> checkForExpiredBookings() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final now = DateTime.now();

    // Fetch all bookings where endDate is less than or equal to the current time
    final expiredBookings = await firestore.collection('bookedPackages')
        .where('endDate', isLessThanOrEqualTo: now)
        .get();

    for (var booking in expiredBookings.docs) {
      final bookingData = booking.data();
      final String userId = bookingData['userId'];
      final String packageId = bookingData['packageId'];

      // Remove expired package and move to archive
      await _removePackageAfterDate(userId, packageId);
    }
  }

  Future<void> _schedulePackageRemoval(String userId, String? packageId, DateTime? endDate) async {
    // Check for expired bookings at any point in the app lifecycle where it's appropriate.
    if (packageId != null && endDate != null) {
      final now = DateTime.now();
      if (now.isAfter(endDate)) {
        await _removePackageAfterDate(userId, packageId); // If endDate has passed, remove immediately
      } else {
        // Schedule the removal for when the endDate passes
        final difference = endDate.difference(now);
        Future.delayed(difference, () async {
          await _removePackageAfterDate(userId, packageId);
        });
      }
    }
  }

  Future<void> _removePackageAfterDate(String userId, String packageId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final bookedPackageRef = firestore.collection('bookedPackages').doc(packageId);
    final archivedPackageRef = firestore.collection('archivedPackages').doc(packageId);

    final packageData = (await bookedPackageRef.get()).data();

    if (packageData != null) {
      await archivedPackageRef.set(packageData); // Archive the package
      await bookedPackageRef.delete(); // Remove from bookedPackages
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void reset() {
    paymentStatus = '';
    showResult = false;
    notifyListeners();
  }
}
