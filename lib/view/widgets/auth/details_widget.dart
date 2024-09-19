import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:travio/view/widgets/global/navbar.dart';

import '../global/custom_textfield.dart';

// Profile Image Widget
class ProfileImageWidget extends StatelessWidget {
  final AuthProvider authProvider;

  const ProfileImageWidget({Key? key, required this.authProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                        image: AssetImage('assets/images/default_pfpf.jpg'),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// User Information Form Widget
class UserInfoForm extends StatelessWidget {
  final AuthProvider authProvider;
  final GlobalKey<FormState> formKey;

  const UserInfoForm({
    Key? key,
    required this.authProvider,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          tTextfield(
            Labeltext: 'Full Name',
            HintText: 'John Wick',
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
    );
  }
}

// Submit Button Widget
class SubmitButton extends StatelessWidget {
  final AuthProvider authProvider;
  final GlobalKey<FormState> formKey;

  const SubmitButton({
    Key? key,
    required this.authProvider,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder<bool>(
        valueListenable: authProvider.loading,
        builder: (context, isLoading, child) {
          return ElevatedButton(
            onPressed: isLoading ? null : () async {
              authProvider.loading.value = true;
              
              if (authProvider.imageTemporary.value != null &&
                  File(authProvider.imageTemporary.value!).existsSync()) {
                File imageFile = File(authProvider.imageTemporary.value!);
                String? imageUrl = await authProvider.uploadImage(imageFile, authProvider.loading);

                if (imageUrl != null) {
                  authProvider.photoController.text = imageUrl;
                  log('Image uploaded successfully: $imageUrl');

                  // Perform signup
                  authProvider.signup(
                    onSuccess: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const TTnavBar()),
                        (route) => false,
                      );
                      BotToast.showText(text: 'Sign up successful');
                    },
                    onError: (message) {
                      BotToast.showText(text: message);
                    },
                  );
                } else {
                  log('Failed to upload image');
                }
              } else {
                log('No image selected or file does not exist');
              }

              if (formKey.currentState?.validate() ?? false) {
                authProvider.dispose();
              }

              authProvider.loading.value = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TTthemeClass().ttThird,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      TTthemeClass().ttLightPrimary,
                    ),
                  )
                : Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 20,
                      color: TTthemeClass().ttLightPrimary,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
