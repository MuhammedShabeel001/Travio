import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoResults extends StatelessWidget {
  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 150,
              child: Lottie.asset('assets/animations/NO_search_found.json')),
          const SizedBox(height: 20),
          const Text(
            'No results found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
