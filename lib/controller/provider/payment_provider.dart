import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  bool _isLoading = false;
  String _paymentStatus = '';

  bool get isLoading => _isLoading;
  String get paymentStatus => _paymentStatus;

  PaymentProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void makePayment(
      {required String amount,
      required String contact,
      required String email}) {
    _isLoading = true;
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
        'contact': '9584847474',
        'email': 'test@razorpay.com',
      },
    };
    _razorpay.open(options);
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    _isLoading = false;
    _paymentStatus = 'Payment Failed: ${response.message}';
    notifyListeners();
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _isLoading = false;
    _paymentStatus = 'Payment Successful: ${response.paymentId}';
    notifyListeners();
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    _isLoading = false;
    _paymentStatus = 'External Wallet Selected: ${response.walletName}';
    notifyListeners();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
