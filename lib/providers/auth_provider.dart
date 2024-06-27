import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travio/pages/sign%20up/details_page.dart';
import 'package:travio/providers/textcontroller_provider.dart';
import 'package:travio/widgets/common/navbar.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String keyValue = 'loggedIn';

  String verificationId = '';

  bool _isChecked = false;
  bool _isLoading = false;

  bool get isChecked => _isChecked;
  bool get isLoading => _isLoading;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pronounController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleCheckBox() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        log('Automatic Verification Completed: ${credential.smsCode}');
        signInWithCredential(credential, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification Failed: ${e.message}');
        _showSnackBar(context, 'Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        _showSnackBar(context, 'Code sent to $phoneNumber');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Verification ID timed out: $verificationId');
        _showSnackBar(context, 'Verification timed out');
      },
    );
  }

  Future<void> signInWithOTP(String smsCode, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await signInWithCredential(credential, context);
    } catch (e) {
      log('Failed to sign in with OTP: $e');
      _showSnackBar(context, 'Failed to sign in with OTP');
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        log('User logged in: ${user.uid}');

        final SharedPreferences sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setBool(keyValue, true);
        _showSnackBar(context, 'User logged in: ${user.uid}');
      } else {
        log('User sign-in failed');
        _showSnackBar(context, 'User sign-in failed');
      }
    } catch (e) {
      log('Failed to sign in: $e');
      _showSnackBar(context, 'Failed to sign in');
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          log('User logged in: ${user.uid}');

          final SharedPreferences sharedPref = await SharedPreferences.getInstance();
          await sharedPref.setBool(keyValue, true);

          _navigateToHome(context);
        } else {
          log('User sign-in failed');
          _showSnackBar(context, 'User sign-in failed');
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');
      _showSnackBar(context, 'Error signing in with Google');
    }
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      _navigateToSignupDetail(context);
      await verifyEmail(context);
      await _setLoginStatus(true);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _showSnackBar(context, "Error: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyEmail(BuildContext context) async {
    await _auth.currentUser?.sendEmailVerification();
    _showSnackBar(context, "Verification email sent");
  }

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyValue, status);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TTnavBar()),
      (route) => false,
    );
  }

  void _navigateToSignupDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  DetailsPage()),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    pronounController.dispose();
    photoController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
