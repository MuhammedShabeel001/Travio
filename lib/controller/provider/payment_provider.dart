import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  bool _isLoading = false;
  String _paymentStatus = '';
  BuildContext? _context; // Store context
  bool _showResult = false;

  bool get isLoading => _isLoading;
  String get paymentStatus => _paymentStatus;
  bool get showResult => _showResult;

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
    _showResult = false;
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
    _showResult = true;
    notifyListeners();
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _isLoading = false;
    _paymentStatus = 'Payment Successful: ${response.paymentId}';
    _showResult = true;
    notifyListeners();
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    _isLoading = false;
    _paymentStatus = 'External Wallet Selected: ${response.walletName}';
    _showResult = true;
    notifyListeners();
  }

  void reset() {
    _paymentStatus = '';
    _showResult = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
