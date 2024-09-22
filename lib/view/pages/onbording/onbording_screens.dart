import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/auth/login/login_page.dart';
import '../../../utils/services/preferences_service.dart';
import '../../widgets/onbording/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    await PreferencesService().setOnboardingCompleted();

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (_) => const LogInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      bodyAlignment: Alignment.center,
      imageAlignment: Alignment.bottomCenter,
      imageFlex: 2,
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, .0, 16.0, 16.0),
      pageColor: Color.fromRGBO(250, 249, 246, 1),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        OnboardingContent(
          title: "Make your own private travel plan",
          body: "Formulate your strategy to receive wonderful gift packs",
          image: 'first.png',
          decoration: pageDecoration,
        ),
        OnboardingContent(
          title: "Customize your High-end travel",
          body: "Countless high-end entertainment facilities",
          image: 'second.png',
          decoration: pageDecoration,
        ),
        OnboardingContent(
          title: "High-end leisure project to choose from",
          body:
              "The world’s first-class modern leisure and entertainment method",
          image: 'third.png',
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
      next: const Icon(Icons.arrow_forward,color: Colors.black,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: TTthemeClass().ttThirdOpacity,
        activeSize: const Size(25.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
