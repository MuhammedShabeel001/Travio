import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/Empty_ticket.json', 
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            'No trip plans found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TTthemeClass().ttLightText),
          ),
          const SizedBox(height: 10),
          Text(
            'Book a package to start planning your trip!',
            style: TextStyle(fontSize: 14, color: TTthemeClass().ttThird),
          ),
        ],
      ),
    );
  }
}
