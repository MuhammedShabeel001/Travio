import 'package:flutter/material.dart';
import 'package:travio/view/pages/home/home_page.dart';
import 'package:travio/view/pages/auth/login/login_page.dart';
import 'package:travio/view/pages/auth/login/restpassword.dart';
import 'package:travio/view/pages/my%20trips/trip_plan_page.dart';
import 'package:travio/view/pages/profile/profile_page.dart';
import 'package:travio/view/pages/search/search_page.dart';
import 'package:travio/view/pages/auth/sign%20up/details_page.dart';
import 'package:travio/view/pages/auth/sign%20up/sign_up_page.dart';
import 'package:travio/view/pages/Splash/splash_page.dart';
import 'package:travio/view/widgets/global/navbar.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/SplashPage": (context) => const SplashScreen(),
  "/LoginPage": (context) => const LogInScreen(),
  "/ForgotPassPage": (context) => const ResentPassword(),
  "/SignUpPage": (context) => SignUpPage(),
  "/DetailsPage": (context) => DetailsPage(),
  "/HomePage": (context) => const HomePage(),
  "/SearchPage": (context) => SearchPage(),
  "/MyTripsPage": (context) => const TripPlanPage(),
  "/ProfilePage": (context) => const ProfilePage(),
  "/StartPage": (context) => const TTnavBar(),
};
