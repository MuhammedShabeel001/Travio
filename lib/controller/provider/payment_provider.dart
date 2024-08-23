import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  bool _isLoading = false;
  String _paymentStatus = '';
  BuildContext? _context; // Store context

  bool get isLoading => _isLoading;
  String get paymentStatus => _paymentStatus;

  PaymentProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void makePayment({
    required String amount,
    required String contact,
    required String email,
    required BuildContext context, // Add BuildContext parameter
  }) {
    _isLoading = true;
    _context = context; // Store the context
    notifyListeners();

    var options = {
      'key': 'rzp_test_5CvknA4rDqeKqA',
      'amount': (double.parse(amount) * 100).toInt(),
      'name': 'Trip Planning App',
      'description': 'Package Payment',
      "timeout": "180",
      "currency": "INR",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': contact,
        'email': email,
      },
    };

    _razorpay.open(options);
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    _isLoading = false;
    _paymentStatus = 'Payment Failed: ${response.message}';
    notifyListeners();

    if (_context != null) {
      showPaymentStatusDialog( 'assets/animations/payment_failed.json', Colors.red, _context!); // Show failure dialog
    }
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _isLoading = false;
    _paymentStatus = 'Payment Successful: ${response.paymentId}';
    notifyListeners();

    if (_context != null) {
      showPaymentStatusDialog( 'assets/animations/payment_success.json', Colors.green, _context!); // Show success dialog
    }
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    _isLoading = false;
    _paymentStatus = 'External Wallet Selected: ${response.walletName}';
    notifyListeners();

    if (_context != null) {
      showPaymentStatusDialog('assets/animations/payment_wallet.json', Colors.orange, _context!); // Show external wallet dialog
    }
  }

  void showPaymentStatusDialog(String animationPath, Color iconColor, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Lottie.asset(
                animationPath,
                // width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 16.0),
              Text(iconColor == Colors.green ? 'Payment Successful' : 'Payment Failed'),
            ],
          ),
          // content: Text(status),
        );
      },
    );

    // Auto close the dialog after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
