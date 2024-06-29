import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/pages/phone%20number/number_page.dart';
import 'package:travio/pages/restpassword.dart';
import 'package:travio/pages/sign%20up/sign_up_page.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_buttons.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';

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
            child: SizedBox(
              height: 150,
              width: 300,
              child: SvgPicture.asset(
                'assets/logo/Logo  (d mode).svg',
                fit: BoxFit.contain,
              ),
            ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E mail',
                              style: const TextStyle(
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: const TextStyle(
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){

                                   Navigator.push(context,  MaterialPageRoute(builder: (context) => ResentPassword(),));
                                }, child: Text('Forgot password '))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: TTthemeClass()
                                    .ttLightPrimary, // Custom background color
                                borderRadius: BorderRadius.circular(
                                    25), // Custom border radius
                                border: Border.all(
                                  color: TTthemeClass()
                                      .ttSecondary, // Custom border color
                                  width: 2, // Custom border width
                                ),
                              ),
                              child: IconButton(
                                iconSize: 30, // Custom icon size
                                icon: SvgPicture.asset(
                                    'assets/icons/google.svg'), // Icon with custom color
                                onPressed: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .loginWithGoogle(context);
                    },
                              ),
                            ),
                            // tSignIn('assets/icons/google.svg'),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: TTthemeClass()
                                    .ttLightPrimary, // Custom background color
                                borderRadius: BorderRadius.circular(
                                    25), // Custom border radius
                                border: Border.all(
                                  color: TTthemeClass()
                                      .ttSecondary, // Custom border color
                                  width: 2, // Custom border width
                                ),
                              ),
                              child: IconButton(
                                iconSize: 30, // Custom icon size
                                icon: SvgPicture.asset(
                                    'assets/icons/phone.svg'), // Icon with custom color
                                onPressed: () {
                                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NumberPage(),
                          ));
                                  // Define your onPressed functionality here
                                },
                              ),
                            ),
                            // tSignIn('assets/icons/phone.svg'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(150, 0, 0, 0),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: TTthemeClass().ttThird,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(
                                            isActive: false,
                                          ),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // tActiveBottomButton('Login', true),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.signIn(context);
                      authProvider.loginEmailController.clear();
                      authProvider.loginPasswordController.clear();
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
