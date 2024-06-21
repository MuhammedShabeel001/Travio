import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travio/pages/entry_page.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/navbar.dart';
// import 'package:travio/screens/login_screen.dart'; // Replace with your login screen import
// import 'package:travio/screens/home_screen.dart'; // Replace with your home screen import

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  final String keyValue = 'loggedIn';

  @override
  void initState() {
    super.initState();
    // Start splash delay and check login status
    startSplashDelay();
  }

  Future<void> startSplashDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // Your splash duration

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    final bool? userLogged = _sharedPref.getBool(keyValue);

    // Assuming FirebaseAuth instance is available globally or can be accessed
    // through a provider or service locator.
    if (userLogged == null || userLogged == false) {
      navigateToLogin();
    } else {
      // Check Firebase Auth state to ensure the user is still authenticated
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // User is authenticated, navigate to home screen
        navigateToHome();
      } else {
        // User is not authenticated, navigate to login screen
        navigateToLogin();
      }
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => EntryPage()),
    );
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TTnavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTthemeClass().ttLightPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/lisa image.png',
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
