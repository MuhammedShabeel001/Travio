import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const SignUpButton({
    super.key,
    required this.formKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, model, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: model.isChecked ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: model.isChecked
                  ? TTthemeClass().ttThird
                  : TTthemeClass().ttThirdOpacity,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 20,
                color: model.isChecked
                    ? TTthemeClass().ttLightPrimary
                    : TTthemeClass().ttThirdHalf,
              ),
            ),
          ),
        );
      },
    );
  }
}