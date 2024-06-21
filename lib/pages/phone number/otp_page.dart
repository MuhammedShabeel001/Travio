import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/authprovider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/navbar.dart';
import '../../providers/auth_provider.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
                    'Welcome back to',
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
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: TTthemeClass().ttLightPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OTP verification',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '6 digit code has been sent to your Number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(115, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpTextField(
                          numberOfFields: 6,
                          fieldWidth: 53.0,
                          borderColor: TTthemeClass().ttThird,
                          showFieldAsBox: true,
                          fillColor: TTthemeClass().ttThirdOpacity,
                          filled: true,
                          onCodeChanged: (String code) {
                            // Handle OTP code input if needed
                          },
                          onSubmit: (String verificationCode) async {
                            // Example of how to submit OTP for verification
                            await authProvider.signInWithOTP(verificationCode);
                          },
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () async {
                            // Example of how to resend OTP
                            await authProvider.verifyPhoneNumber('+91${phoneController.text}');
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TTnavBar(),), (route) => false,);
          // Handle logic for Continue button press
        },
        backgroundColor: TTthemeClass().ttThird,
        elevation: 0,
        label: Row(
          children: [
            Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                color: TTthemeClass().ttLightPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: TTthemeClass().ttLightPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
