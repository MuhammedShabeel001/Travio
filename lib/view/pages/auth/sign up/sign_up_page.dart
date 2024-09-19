import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/auth/sign%20up/details_page.dart';
import 'package:travio/view/widgets/global/welcome_bar.dart';
import 'package:travio/view/widgets/auth/sign_up_form.dart';
import 'package:travio/view/widgets/auth/terms_and_conditions.dart';
import 'package:travio/view/widgets/auth/sign_up_button.dart';
import 'package:travio/view/widgets/auth/login_redirect.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          // Welcome bar at the top
          Flexible(flex: 1, child: tWelcome('Welcome to')),
          // Main content area
          Flexible(
            flex: 4,
            child: Container(
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
                  // Scrollable content area
                  Expanded(
                    child: _buildScrollableContent(context),
                  ),
                  // Bottom section with terms, sign up button, and login redirect
                  _buildBottomSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      children: [
        const Text(
          'Create account with easy and \nfast method',
          style: TextStyle(
            fontSize: 19,
            color: Color.fromARGB(99, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 20),
        SignUpForm(formKey: _formKey),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TermsAndConditions(),
        const SizedBox(height: 10),
        SignUpButton(
          formKey: _formKey,
          onPressed: () => _handleSignUp(context),
        ),
        const LoginRedirect(),
      ],
    );
  }

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => DetailsPage()),
      );
    }
  }
}