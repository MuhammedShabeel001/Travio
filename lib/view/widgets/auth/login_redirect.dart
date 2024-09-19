import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(150, 0, 0, 0),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(6),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Log in',
            style: TextStyle(color: TTthemeClass().ttThird),
          ),
        ),
      ],
    );
  }
}