import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/view/widgets/global/logo.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/auth/login_form.dart';
// import 'package:travio/widgets/common/customs/custom_buttons.dart';
// import 'package:travio/widgets/common/customs/custom_textfield.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: TTthemeClass().ttThirdHalf,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            width: double.infinity,
            child: const TtLogo(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TTthemeClass().ttLightPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.all(20),
              //--------------------------------LOGIN FORM-----------------------------
              child: LoginForm(authProvider: authProvider),
            ),
          )
        ],
      ),
    );
  }
}

