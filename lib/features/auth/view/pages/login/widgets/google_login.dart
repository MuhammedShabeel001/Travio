import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/features/auth/controller/auth_provider.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          await Provider.of<AuthProvider>(context,
                  listen: false)
              .loginWithGoogle(onSuccess: (){
                log('logged in successfully');
              }, onError: (e){
                log('$e');
              });
        },
      ),
    );
  }
}