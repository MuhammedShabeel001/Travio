import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:travio/view/pages/auth/login/login_page.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/onbording/onbording_screens.dart';
import 'package:travio/view/widgets/global/navbar.dart';

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
      CupertinoPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => const TTnavBar()),
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
            SizedBox(
                height: 160,
                child: SvgPicture.asset('assets/logo/logo (l mode).svg')),
          ],
        ),
      ),
    );
  }
}
