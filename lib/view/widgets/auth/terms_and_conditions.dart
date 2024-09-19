import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<AuthProvider>(
          builder: (context, model, child) {
            return Checkbox(
              value: model.isChecked,
              onChanged: (value) {
                model.toggleCheckBox();
              },
            );
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree with ',
              style: const TextStyle(color: Colors.black),
              children: [
                _buildClickableText('Terms and Conditions', () {}),
                const TextSpan(
                  text: ' and ',
                  style: TextStyle(color: Colors.black),
                ),
                _buildClickableText('Privacy Policy', () {}),
                const TextSpan(
                  text: ':',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextSpan _buildClickableText(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}