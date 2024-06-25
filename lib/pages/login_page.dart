import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travio/pages/sign%20up/sign_up_page.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_buttons.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTthemeClass().ttThirdHalf,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        tTextfield(
                          Labeltext: 'Email',
                          HintText: 'example@gmail.com',
                        ),
                        SizedBox(height: 15),
                        tTextfield(
                          Labeltext: 'Password',
                          HintText: 'password',
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            tSignIn('assets/icons/google.svg'),
                            SizedBox(width: 20),
                            tSignIn('assets/icons/phone.svg'),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
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
                                          builder: (context) =>
                                              const SignUpPage(),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TTthemeClass().ttThird,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        color: TTthemeClass().ttLightPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
