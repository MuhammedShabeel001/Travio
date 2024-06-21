import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/pages/entry_page.dart';
import 'package:travio/providers/authprovider.dart';
import 'package:travio/utils/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 19,
                      color: const Color.fromARGB(153, 255, 255, 255),
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
                    Container(
                      //
                      child: ListView(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                        ),
                        //padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        children: [
                          const Text(
                            '''Create account with easy 
and fast method''',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(99, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'E mail',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'example@gmail.com',
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(101, 0, 0, 0)),
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
                          SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(101, 0, 0, 0)),
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
                          SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Conform Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(101, 0, 0, 0)),
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

                    //           GestureDetector(
                    // onTap: () {
                    //   context.read<AuthProvider>().toggleCheckBox();
                    // },
                    // child: Row(
                    //   children: [
                    //     Consumer<AuthProvider>(
                    //       builder: (context, model, child) {
                    //         return Checkbox(
                    //           value: model.isChecked,
                    //           onChanged: (value) {
                    //             context.read<AuthProvider>().toggleCheckBox();
                    //           },
                    //         );
                    //       },
                    //     ),
                    Container(
                      // color: Colors.amber,
                      child: Column(
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
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    TextSpan(
                                      text: ':',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle sign-up button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TTthemeClass().ttThird,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: TTthemeClass().ttLightPrimary),
                              ),
                            ),
                          ),
                          // SizedBox(height: 20),
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
                                    padding: const EdgeInsets.all(6)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EntryPage(),
                                      ));
                                },
                                child: Text(
                                  'Log in ',
                                  style:
                                      TextStyle(color: TTthemeClass().ttThird),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
