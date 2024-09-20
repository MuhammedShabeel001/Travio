import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }
}
