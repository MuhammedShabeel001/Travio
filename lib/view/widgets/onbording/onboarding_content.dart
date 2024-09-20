import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
// import 'package:introduction_screen/introduction_screen.dart';

class OnboardingContent extends PageViewModel {
  OnboardingContent({
    required String title,
    required String body,
    required String image,
    required PageDecoration decoration,
  }) : super(
          title: title,
          body: body,
          image: Image.asset('assets/onboarding/$image', width: 350),
          decoration: decoration,
        );
}
