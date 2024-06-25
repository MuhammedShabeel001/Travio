import 'package:flutter/material.dart';

class TTthemeClass {
  Color ttLightPrimary = const Color.fromRGBO(250, 249, 246, 1);
  Color ttLightFourth = const Color.fromRGBO(11, 18, 21, 1);
  Color ttLightText = const Color.fromRGBO(11, 18, 21, 1);

  Color ttDardPrimary = const Color.fromRGBO(11, 18, 21, 1);
  Color ttDardFourth = const Color.fromRGBO(250, 249, 246, 1);
  Color ttDardText = const Color.fromRGBO(250, 249, 246, 1);

  Color ttSecondary = const Color.fromRGBO(238, 233, 241, 1);
  Color ttThird = const Color.fromRGBO(128, 90, 241, 1);
  Color ttThirdHalf = const Color.fromRGBO(128, 90, 241, 0.5);
  Color ttThirdOpacity = const Color.fromARGB(80, 128, 90, 241);

  Color ttButton = const Color.fromRGBO(128, 90, 241, 1);
  Color ttButtonText = const Color.fromRGBO(250, 249, 246, 1);

  static ThemeData ttLightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _tthemeClass.ttLightPrimary,
      secondary: _tthemeClass.ttSecondary,
      tertiary: _tthemeClass.ttThird,
    ),
  );

  static ThemeData ttDarkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _tthemeClass.ttDardPrimary,
      secondary: _tthemeClass.ttSecondary,
      tertiary: _tthemeClass.ttThird,
    ),
  );
}

TTthemeClass _tthemeClass = TTthemeClass();

// import 'package:flutter/material.dart';

// class Tthems {
//   static final ThemeData tLightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: const Color.fromRGBO(250, 249, 246, 1),
//     snackBarTheme: const SnackBarThemeData(
//       backgroundColor: Color.fromRGBO(128, 90, 241, 1),
//       contentTextStyle: TextStyle(
//         color: Color.fromRGBO(250, 249, 246, 1),
//       ),
//     ),
//     scaffoldBackgroundColor: const Color.fromRGBO(238, 233, 241, 1),
//     textTheme: const TextTheme(
//       bodyMedium: TextStyle(
//         color: Color.fromRGBO(11, 18, 21, 1),
//       ),
//       bodySmall: TextStyle(
//         color: Color.fromRGBO(11, 18, 21, 1),
//       ),
//     ),
//   );

//   static final ThemeData tDarkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: const Color.fromRGBO(11, 18, 21, 1),
//     snackBarTheme: const SnackBarThemeData(
//       backgroundColor: Color.fromRGBO(128, 90, 241, 1),
//       contentTextStyle: TextStyle(
//         color: Color.fromRGBO(250, 249, 246, 1),
//       ),
//     ),
//     scaffoldBackgroundColor: const Color.fromRGBO(238, 233, 241, 1),
//     textTheme: const TextTheme(
//       bodyMedium: TextStyle(
//         color: Color.fromRGBO(250, 249, 246, 1),
//       ),
//       bodySmall: TextStyle(
//         color: Color.fromRGBO(250, 249, 246, 1),
//       ),
//     ),
//   );
// }
