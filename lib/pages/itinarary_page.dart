import 'package:flutter/material.dart';
import 'package:travio/widgets/common/appbar.dart';

class ItinararyPage extends StatelessWidget {
  const ItinararyPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: ttAppBar(context, 'Itinarary', ItinararyCenter(context))
    );
  }

  // ignore: non_constant_identifier_names
  Center ItinararyCenter(BuildContext context){
    return const Center(
      child: Text('Your Itinarary'),
    );
  }
}