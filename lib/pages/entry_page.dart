import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/entry_pic.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 150,
            left: 50,
            child: SizedBox(
              height: 150,
              width: 300,
              child: SvgPicture.asset(
                'assets/logo/Logo  (d mode).svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 100,
            child: SizedBox(
              height: 100,
              width: 200,
              child: SvgPicture.asset(
                'assets/logo/title white.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: TTthemeClass().ttLightPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TTthemeClass().ttDardPrimary,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 60,
                    padding: const EdgeInsets.only(left: 30),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_android,
                          size: 30,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Continue with Mobile Number',
                          style: TextStyle(
                            color: TTthemeClass().ttLightFourth,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        Provider.of<AuthProvider>(context, listen: false)
                            .signInWithGoogle(),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TTthemeClass().ttDardPrimary,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 60,
                      padding: const EdgeInsets.only(left: 30),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            size: 30,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: TTthemeClass().ttLightFourth,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TTthemeClass().ttDardPrimary,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 60,
                    padding: const EdgeInsets.only(left: 30),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mail_outline,
                          size: 30,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Login with Mail',
                          style: TextStyle(
                            color: TTthemeClass().ttLightFourth,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(150, 0, 0, 0),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: const EdgeInsets.all(6)),
                        onPressed: () {},
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: TTthemeClass().ttThird),
                        ),
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
