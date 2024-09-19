import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/global/welcome_bar.dart';

import '../../../widgets/auth/email_input.dart';
import '../../../widgets/auth/reset_password_button.dart';

/// This widget handles the reset password screen.
class ResentPassword extends StatelessWidget {
  const ResentPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          // Welcome banner widget
          Flexible(flex: 1, child: tWelcome('Welcome to')),
          
          // The main container which holds the email input and reset button
          Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: TTthemeClass().ttLightPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20,
                      ),
                      children: const[
                         Text(
                          'Enter your E mail here',
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(99, 0, 0, 0),
                          ),
                        ),
                         SizedBox(height: 20),
                        // Email input form field
                         EmailInput(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0),
                  // Reset Password button
                  ResetPasswordButton(authProvider: authProvider),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
