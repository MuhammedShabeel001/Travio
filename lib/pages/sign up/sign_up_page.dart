import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/pages/entry_page.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_buttons.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(153, 255, 255, 255),
                    ),
                  ),
                  Text(
                    'travio',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                        tTextfield(
                            Labeltext: 'Email', HintText: 'example@gmail.com'),
                        const SizedBox(
                          height: 15,
                        ),
                        tTextfield(Labeltext: 'Password', HintText: 'password'),
                        const SizedBox(
                          height: 15,
                        ),
                        tTextfield(
                            Labeltext: 'Confirm Password',
                            HintText: 'password'),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: tActiveBottomButton('Sign up',false)
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
                                  builder: (context) => const EntryPage(),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
