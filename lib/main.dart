import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/booking_provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/payment_provider.dart';
import 'package:travio/controller/provider/review_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/controller/provider/version_provider.dart';
import 'package:travio/core/firebase/firebase_options.dart';
import 'package:travio/controller/provider/location_provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/text_theme.dart';
import 'package:travio/utils/services/preferences_service.dart';
import 'package:travio/view/pages/Splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool showOnBoarding = await PreferencesService().shouldShowOnboarding();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(showOnBoarding: showOnBoarding));
}


class MyApp extends StatelessWidget {
  final bool showOnBoarding;
  const MyApp({super.key, required this.showOnBoarding});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              LocationProvider(SearchProvider(), TripPackageProvider()),
        ),
        ChangeNotifierProvider(
          create: (context) => TripPackageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VersionProvider(),
        ),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SpaceGrotesk',  // Apply the Space Grotesk font
        textTheme: AppTextTheme.textTheme,  // Use the separated text theme
        ),
        home:const SplashScreen(),
      ),
    );
  }
}
