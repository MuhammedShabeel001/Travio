import 'package:flutter/material.dart';
import 'package:travio/features/auth/view/pages/home/home_page.dart';
import 'package:travio/features/auth/view/pages/login/login_page.dart';
import 'package:travio/features/auth/view/pages/login/restpassword.dart';
import 'package:travio/features/auth/view/pages/my%20trips/trip_plan_page.dart';
import 'package:travio/features/auth/view/pages/profile/profile_page.dart';
import 'package:travio/features/auth/view/pages/search/search_page.dart';
import 'package:travio/features/auth/view/pages/sign%20up/details_page.dart';
import 'package:travio/features/auth/view/pages/sign%20up/sign_up_page.dart';
import 'package:travio/features/auth/view/pages/splash_page.dart';

Map<String, Widget Function(BuildContext)> routes ={
  "/SplashPage": (context)=> const SplashScreen(),
  // "/LandingPage1": (context)=> ,
  // "/LandingPage2": (context)=> ,
  // "/LandingPage3": (context)=> ,
  "/LoginPage": (context)=> const LogInScreen(),
  "/ForgotPassPage": (context)=> const ResentPassword(),
  "/SignUpPage": (context)=>  SignUpPage(),
  "/DetailsPage": (context)=>  DetailsPage(),
  "/HomePage": (context)=> const HomePage(),
  "/SearchPage": (context)=>  const SearchPage(),
  "/MyTripsPage": (context)=>  const TripPlanPage(),
  "/ProfilePage": (context)=>  const ProfilePage(),
  // "/MyTripsPage": (context)=>  const AIpage(),
};