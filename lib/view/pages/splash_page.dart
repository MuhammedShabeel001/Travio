import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:travio/pages/entry_page.dart';
import 'package:travio/view/pages/login/login_page.dart';
import 'package:travio/controller/utils/theme.dart';
import 'package:travio/core/common/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  final String keyValue = 'loggedIn';

  @override
  void initState() {
    super.initState();

    startSplashDelay();
  }

  Future<void> startSplashDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final bool? userLogged = sharedPref.getBool(keyValue);

    if (userLogged == null || userLogged == false) {
      navigateToLogin();
    } else {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        navigateToHome();
      } else {
        navigateToLogin();
      }
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LogInScreen()),
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
