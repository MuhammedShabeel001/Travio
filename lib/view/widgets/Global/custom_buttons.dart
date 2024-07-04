import 'package:flutter/material.dart';
import 'package:travio/controller/utils/theme.dart';

ElevatedButton tActiveBottomButton(String text, bool isActive) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor:
          isActive ? TTthemeClass().ttThird : TTthemeClass().ttThirdOpacity,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 20,
          color: isActive
              ? TTthemeClass().ttLightPrimary
              : TTthemeClass().ttThirdHalf),
    ),
  );
}
