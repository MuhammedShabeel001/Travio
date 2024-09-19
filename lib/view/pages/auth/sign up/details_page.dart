import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';
import '../../../widgets/auth/details_widget.dart';
import '../../../widgets/global/welcome_bar.dart'; // New file for extracted widgets

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          // Welcome bar section at the top
          Flexible(flex: 1, child: tWelcome('')),

          // Main content section with form and profile image
          Flexible(
            flex: 5,
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // Profile image upload widget
                        ProfileImageWidget(authProvider: authProvider),

                        const SizedBox(height: 20),

                        // Form fields (extracted to separate file)
                        UserInfoForm(authProvider: authProvider, formKey: _formKey),
                      ],
                    ),
                  ),

                  // Submit button at the bottom
                  SubmitButton(authProvider: authProvider, formKey: _formKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
