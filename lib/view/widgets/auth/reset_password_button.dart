import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';

/// Widget to handle the Reset Password button logic.
class ResetPasswordButton extends StatelessWidget {
  final AuthProvider authProvider;

  const ResetPasswordButton({required this.authProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          authProvider.resetPassword(
            onSuccess: () {
              BotToast.showText(text: 'Password reset email sent');
            },
            onError: (message) {
              BotToast.showText(text: message);
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TTthemeClass().ttThird,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Reset password',
          style: TextStyle(
            fontSize: 20,
            color: TTthemeClass().ttLightPrimary,
          ),
        ),
      ),
    );
  }
}
