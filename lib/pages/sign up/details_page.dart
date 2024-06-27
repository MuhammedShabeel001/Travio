import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/customs/custom_buttons.dart';
import 'package:travio/widgets/common/customs/custom_textfield.dart';
import 'package:travio/widgets/common/customs/welcome_bar.dart';
import 'package:travio/widgets/common/navbar.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: TTthemeClass().ttThird,
      body: Column(
        children: [
          Flexible(flex: 1, child: tWelcome('')),
          Flexible(
            flex: 5,
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
                        Center(
                          child: InkWell(
                            onTap: () async {
                              await authProvider.getImage(authProvider.imageTemporary);
                            },
                            child: ValueListenableBuilder<String?>(
                              valueListenable: authProvider.imageTemporary,
                              builder: (context, imagePath, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TTthemeClass().ttThirdHalf,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: imagePath != null
                                        ? Image.file(
                                            File(imagePath),
                                            fit: BoxFit.cover,
                                          )
                                        : const Image(
                                            image: AssetImage(
                                              'assets/images/default_pfpf.jpg',
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        tTextfield(
                          Labeltext: 'Full Name',
                          HintText: 'john wick',
                          controller: authProvider.nameController,
                        ),
                        tNumberfield(
                          Labeltext: 'Number',
                          controller: authProvider.phoneController,
                        ),
                        tDropdownField(
                          labelText: 'Pronouns',
                          hintText: 'he/him',
                          controller: authProvider.pronounController,
                          items: ['he/him', 'she/her', 'they/them'],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (authProvider.imageTemporary.value != null && File(authProvider.imageTemporary.value!).existsSync()) {
                          File imageFile = File(authProvider.imageTemporary.value!);
                          String? imageUrl = await authProvider.uploadImage(imageFile, authProvider.loading);

                          if (imageUrl != null) {
                            authProvider.photoController.text = imageUrl;
                            print('Image uploaded successfully: $imageUrl');
                            authProvider.addUser(context);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TTnavBar()),(route) => false,);
                          } else {
                            print('Failed to upload image');

                            // Handle the error case here if needed
                          }
                        } else {
                          print('No image selected or file does not exist');
                          // Handle the case where no image is selected or file does not exist
                        }

                        if (_formKey.currentState?.validate() ?? false) {
                          // Implement your adduser function here if needed
                          //authProvider.addUser(context);
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TTnavBar()),(route) => false,);
                          // Clear text controllers
                          authProvider.nameController.clear();
                          authProvider.phoneController.clear();
                          authProvider.emailController.clear();
                          authProvider.passwordController.clear();
                          authProvider.pronounController.clear();
                          authProvider.photoController.clear();
                          // Navigate to the User Profile screen or any other screen
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TTnavBar()),(route) => false,);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TTthemeClass().ttThird,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 20,
                          color: TTthemeClass().ttLightPrimary,
                        ),
                      ),
                    ),
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
