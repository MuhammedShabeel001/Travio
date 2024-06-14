

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travio/pages/otp_page.dart';

class PhoneNumberScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: _phoneController.text,
                  verificationCompleted: (phoneAuthCredential) {
                    
                  }, 
                  verificationFailed: (error) {
                    log(error.toString());
                  }, 
                  codeSent: (verificationId, forceResendingToken) {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verificationId,)),
                );
                  }, 
                  codeAutoRetrievalTimeout: (verificationId) {
                    log('Auto retrieval Timeout');
                  },);
                // Handle phone number submission logic
                
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
