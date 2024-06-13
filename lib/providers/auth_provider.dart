import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthProvider() {
    _auth.authStateChanges().listen((event) {
      user = event;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      if (kIsWeb) {
        await _auth.signInWithPopup(googleProvider);
      } else {
        await _auth.signInWithProvider(googleProvider);
      }
    } catch (e) {
      debugPrint('Sign in with Google failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      user = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Sign out failed: $e');
    }
  }
}
