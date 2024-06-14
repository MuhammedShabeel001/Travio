import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;

  AuthProvider() {
    _auth.authStateChanges().listen((User? event) {
      user = event;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        user = userCredential.user;
      }
    } catch (e) {
      debugPrint('Sign in with Google failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in with Google failed. Please try again.'),
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from Firebase, which will handle all providers including phone authentication
      await _auth.signOut();
      
      // Sign out from Google
      await _googleSignIn.signOut();
      
      // Set the user to null and notify listeners
      user = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Sign out failed: $e');
      // Show a message to the user if sign-out fails
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Sign out failed. Please try again.'),
      //   ),
      // );
    }
  }
}
