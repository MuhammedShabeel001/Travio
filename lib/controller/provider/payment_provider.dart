import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    // moveExpiredBookingsToArchive();
  }

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

// Future<void> addNoteToPackage(String packageId, String note) async {
//     try {
//       final FirebaseFirestore firestore = FirebaseFirestore.instance;
//       final packageRef = firestore.collection('archivedPackages').doc(packageId);

//       await firestore.runTransaction((transaction) async {
//         final snapshot = await transaction.get(packageRef);

//         if (!snapshot.exists) {
//           throw Exception('Package does not exist.');
//         }

//         final existingNotes = snapshot.get('notes') as List<dynamic>? ?? [];
//         final updatedNotes = List.from(existingNotes)..add(note);

//         transaction.update(packageRef, {
//           'notes': updatedNotes,
//         });
//       });

//       notifyListeners(); // Notify listeners if needed
//     } catch (e) {
//       print('Failed to add note: $e');
//     }
//   }


  Future<void> _handleSuccessfulPayment(String paymentId) async {
    try {
      final bookingProvider =
          Provider.of<BookingProvider>(_context, listen: false);

      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        paymentStatus = 'Failed: User not authenticated';
        showResult = true;
        isLoading = false;
        notifyListeners();
        return;
      }

      final String userId = currentUser.uid;

      await _addPackageToUserCollection(userId, bookingProvider);

      await _incrementBookedCount(bookingProvider.packageId);

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

      await _incrementBookedCount(bookingProvider.packageId);
    } else {
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

Future<void> moveExpiredBookingsToArchive() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DateTime now = DateTime.now();
  log(now.toString());

  try {
    // log('sdcs');
    // Fetch packages where the end date has passed
    final QuerySnapshot expiredBookings = await firestore
        .collection('bookedPackages')
        .where('endDate', isLessThan: now)
        .get();

    log(expiredBookings.toString());

    if (expiredBookings.docs.isNotEmpty) {
      for (var booking in expiredBookings.docs) {
        // Get booking details
        final bookingData = booking.data() as Map<String, dynamic>;

        // Add the expired booking to the archived collection
        await firestore.collection('archivedPackages').add(bookingData);

        // Remove the expired booking from the bookedPackages collection
        await firestore.collection('bookedPackages').doc(booking.id).delete();
      }

      paymentStatus = 'Expired bookings moved to archive';
      notifyListeners();
    } else {
      paymentStatus = 'No expired bookings found';
      notifyListeners();
    }
  } catch (e) {
    paymentStatus = 'Failed to move expired bookings: $e';
    notifyListeners();
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
