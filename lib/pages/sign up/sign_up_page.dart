import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/pages/login_page.dart';
import 'package:travio/pages/sign%20up/details_page.dart';
import 'package:travio/pages/entry_page.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';
import 'package:travio/widgets/common/customs/welcome_bar.dart';

class SignUpPage extends StatelessWidget {
  final bool isActive;

  SignUpPage({super.key, required this.isActive});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          Flexible(flex: 1, child: tWelcome('Welcome to')),
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20,
                      ),
                      children: [
                        const Text(
                          '''Create account with easy and 
fast method''',
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(99, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
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
                                  // Email format validation using regex
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
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  // Add password validation logic here if needed
                                  return null;
                                },
                                controller: authProvider.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: '*************',
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
                              const Text(
                                'Confirm Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  // Add password validation logic here if needed
                                  return null;
                                },
                                // controller: authProvider.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: '*************',
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
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                          RichText(
                            text: TextSpan(
                              text: 'I agree with ',
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(
                                  text: ':',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      Consumer<AuthProvider>(
                        builder: (context, model, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: model.isChecked
                                  ? () async {
                                      if (_formKey.currentState!.validate()) {
                                        await authProvider.signup(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  DetailsPage(),
                                          ),
                                        );
                                      }
                                    }
                                  : null,
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(color: TTthemeClass().ttThird),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
