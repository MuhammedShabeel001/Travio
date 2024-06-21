import 'package:flutter/material.dart';
import 'package:travio/widgets/common/appbar.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ttAppBar(context, 'Plan trip', AddTripCenter(context))
    );
  }

  // ignore: non_constant_identifier_names
  Center AddTripCenter(BuildContext context){
    return const Center(
      child: Text('Plan your trip here'),
    );
  }
}