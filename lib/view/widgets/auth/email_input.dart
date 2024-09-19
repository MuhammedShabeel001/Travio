import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';

/// Widget to handle the email input for resetting the password.
class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              bool validEmail = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                caseSensitive: false,
                multiLine: false,
              ).hasMatch(value);
              if (!validEmail) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            controller: authProvider.emailController,
            decoration: InputDecoration(
              hintText: 'example@gmail.com',
              hintStyle: const TextStyle(
                color: Color.fromARGB(101, 0, 0, 0),
              ),
              fillColor: TTthemeClass().ttThirdOpacity,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
