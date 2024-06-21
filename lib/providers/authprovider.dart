import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String keyValue = 'loggedIn';

  String verificationId = '';

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Handle automatic verification
        print('Automatic Verification Completed: ${credential.smsCode}');
        signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        print('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save verification ID for later use
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
        print('Verification ID timed out: $verificationId');
      },
    );
  }

  Future<void> signInWithOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await signInWithCredential(credential);
    } catch (e) {
      print('Failed to sign in with OTP: $e');
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        print('User logged in: ${user.uid}');
        // Save login status to SharedPreferences
        final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
        await _sharedPref.setBool(keyValue, true);

        // Handle successful sign-in (e.g., navigate to next screen)
      } else {
        print('User sign-in failed');
      }
    } catch (e) {
      print('Failed to sign in: $e');
    }
    notifyListeners();
  }
}
