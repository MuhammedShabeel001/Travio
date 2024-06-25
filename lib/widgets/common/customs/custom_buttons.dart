import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travio/utils/theme.dart';

Container tSignIn(String icon) {
  return Container(
    decoration: BoxDecoration(
      color: TTthemeClass().ttLightPrimary, // Custom background color
      borderRadius: BorderRadius.circular(25), // Custom border radius
      border: Border.all(
        color: TTthemeClass().ttSecondary, // Custom border color
        width: 2, // Custom border width
      ),
    ),
    child: IconButton(
      iconSize: 30, // Custom icon size
      icon: SvgPicture.asset(icon), // Icon with custom color
      onPressed: () {
        // Define your onPressed functionality here
      },
    ),
  );
}

ElevatedButton tActiveBottomButton(String text, bool isActive) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: isActive ? TTthemeClass().ttThird : TTthemeClass().ttThirdOpacity,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: isActive ?  TTthemeClass().ttLightPrimary : TTthemeClass().ttThirdHalf 
      ),
    ),
  );
}

// ElevatedButton tDisableBottomButton(String text, bool isActive) {
//   return ElevatedButton(
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//       backgroundColor: TTthemeClass().ttThird,
//       minimumSize: const Size(double.infinity, 50),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//     ),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 20,
//         color: TTthemeClass().ttLightPrimary,
//       ),
//     ),
//   );
// }