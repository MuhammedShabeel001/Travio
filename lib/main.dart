import 'package:flutter/material.dart';
import 'package:travio/pages/profile_page.dart';
import 'package:travio/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: TTthemeClass.ttLightTheme,
      darkTheme: TTthemeClass.ttDarkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: true,
      home: const ProfilePage(),
    );
  }
}
