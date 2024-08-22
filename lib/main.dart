import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/payment_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/core/firebase/firebase_options.dart';
import 'package:travio/controller/provider/location_provider.dart';

import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/Splash/splash_page.dart';
import 'package:travio/view/widgets/global/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(SearchProvider(), TripPackageProvider()),
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
      ],
      child: MaterialApp(
        // color: TTthemeClass().ttButton,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const SplashScreen(),
        // home: const TTnavBar(),
      ),
    );
  }
}
