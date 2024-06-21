import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travio/widgets/common/navbar.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String keyValue = 'loggedIn';

  String verificationId = '';

  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckBox() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        log('Automatic Verification Completed: ${credential.smsCode}');
        signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Verification ID timed out: $verificationId');
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
      log('Failed to sign in with OTP: $e');
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        log('User logged in: ${user.uid}');

        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();
        await sharedPref.setBool(keyValue, true);
      } else {
        log('User sign-in failed');
      }
    } catch (e) {
      log('Failed to sign in: $e');
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          log('User logged in: ${user.uid}');

          final SharedPreferences sharedPref =
              await SharedPreferences.getInstance();
          await sharedPref.setBool(keyValue, true);

          Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const TTnavBar(),
            ),
            (route) => false,
          );
        } else {
          log('User sign-in failed');
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');
    }
    notifyListeners();
  }
}
