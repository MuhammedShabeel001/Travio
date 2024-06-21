// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   late SharedPreferences _prefs;
//   User? _user;

//   AuthProvider() {
//     _initPrefs();
//     _auth.authStateChanges().listen((User? user) {
//       _user = user;
//       _saveLoginState(user != null);
//       notifyListeners();
//     });
//   }

//   Future<void> _initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   User? get user => _user;

//   bool get isLoggedIn => _user != null;

//   Future<void> _saveLoginState(bool isLoggedIn) async {
//     await _prefs.setBool('isLoggedIn', isLoggedIn);
//   }

//   Future<bool> checkLoginState() async {
//     bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
//     if (isLoggedIn) {
//       _user = _auth.currentUser;
//       notifyListeners();
//     }
//     return isLoggedIn;
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//         final OAuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//         _user = userCredential.user;
//       }
//     } catch (e) {
//       debugPrint('Sign in with Google failed: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Sign in with Google failed. Please try again.'),
//         ),
//       );
//     }
//   }

//   Future<void> signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           final UserCredential userCredential = await _auth.signInWithCredential(credential);
//           _user = userCredential.user;
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           debugPrint('Phone number verification failed: $e');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Phone number verification failed. Please try again.'),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Navigate to OTP screen with verification ID
//           Navigator.pushNamed(context, '/otp', arguments: verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Handle timeout
//           debugPrint('Phone number verification timed out');
//         },
//       );
//     } catch (e) {
//       debugPrint('Sign in with phone number failed: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Sign in with phone number failed. Please try again.'),
//         ),
//       );
//     }
//   }

//   Future<void> signOut(BuildContext context) async {
//     try {
//       await _auth.signOut();
//       await _googleSignIn.signOut();
//       _user = null;
//       await _prefs.setBool('isLoggedIn', false);
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Sign out failed: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Sign out failed. Please try again.'),
//         ),
//       );
//     }
//   }
// }
