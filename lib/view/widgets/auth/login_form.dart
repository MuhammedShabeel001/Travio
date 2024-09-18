import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/view/pages/auth/login/restpassword.dart';
import 'package:travio/view/widgets/auth/google_login.dart';
import 'package:travio/view/widgets/auth/login_footer.dart';
import 'package:travio/utils/validations/validation.dart';
import 'package:travio/view/widgets/global/navbar.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.authProvider,
  });

  final formKey = GlobalKey<FormState>();
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E mail',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    TextFormField(
                      controller: authProvider.loginEmailController,
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
                      validator: (value) => JValidator.validateEmail(value),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: authProvider.loginPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                      validator: (value) => JValidator.validatePassword(value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const ResentPassword(),
                              ),
                            );
                          },
                          child: const Text('Forgot password '),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const GoogleLogin(),
                const SizedBox(height: 20),
                const LoginFooter(),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: authProvider.loading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authProvider.signIn(
                        onSuccess: () {
                          log('onSuccess callback started');

                         
                            // Debug output to check if `TTnavBar` is created correctly
                           
                            log('Attempting navigation to TTnavBar');
                           Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => const TTnavBar(),), (route) => false,);
                           
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   CupertinoPageRoute(
                            //     builder: (context) => const TTnavBar(),
                            //   ),
                            //   (route) => false,
                            // );
                          

                         

                          log('onSuccess callback completed');
                        },
                        onError: (message) {
                          // Show error message
                          BotToast.showText(text: message);
                          log('Login error: $message');
                        },
                      );

                      // Clear text fields after login attempt
                      authProvider.loginEmailController.clear();
                      authProvider.loginPasswordController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TTthemeClass().ttThird,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: TTthemeClass().ttLightPrimary,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
