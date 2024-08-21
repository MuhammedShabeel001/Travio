import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';

class BookButton extends StatelessWidget {
  const BookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle booking
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TTthemeClass().ttButton,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Book Now',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
