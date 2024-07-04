import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// import 'package:provider/provider.dart';
import 'package:travio/view/pages/phone%20number/otp_page.dart';
// import 'package:travio/providers/auth_provider.dart';
import 'package:travio/controller/utils/theme.dart';

class NumberPage extends StatelessWidget {
  const NumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
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
                    'Enter Your Phone Number',
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(99, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  IntlPhoneField(
                    initialCountryCode: 'IN',
                    decoration: InputDecoration(
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
                    onChanged: (phone) {
                      phoneController.text = phone.completeNumber;
                    },
                    onCountryChanged: (phone) {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final completePhoneNumber = phoneController.text.trim();
          if (completePhoneNumber.isNotEmpty) {
            // final formattedPhoneNumber = '+${phoneController.text}';
            // await authProvider.verifyPhoneNumber(formattedPhoneNumber);
            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const OtpPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Please enter a valid phone number')),
            );
          }
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
                  fontWeight: FontWeight.w600),
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
