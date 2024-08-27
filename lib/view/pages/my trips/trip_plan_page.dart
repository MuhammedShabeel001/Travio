import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:travio/view/widgets/global/appbar.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ttAppBar(context, 'Plan trip', addTripCenter(context)),
    );
  }

  Center addTripCenter(BuildContext context) {
    return const Center(
      child: Text('Plan your trip here'),
    );
  }
}
