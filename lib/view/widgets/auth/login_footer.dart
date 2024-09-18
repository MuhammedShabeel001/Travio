import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/auth/sign%20up/sign_up_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    CupertinoPageRoute(
                      builder: (context) => SignUpPage(
                        // isActive: false,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}


