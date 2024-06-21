import 'package:flutter/foundation.dart';
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

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          print('User logged in: ${user.uid}');
          // Save login status to SharedPreferences
          final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
          await _sharedPref.setBool(keyValue, true);
          // Navigator.pushAndRemoveUntil(context, newRoute, predicate)
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TTnavBar(),), (route) => false,);

          // Handle successful sign-in (e.g., navigate to next screen)
        } else {
          print('User sign-in failed');
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
    notifyListeners();
  }
  
}
