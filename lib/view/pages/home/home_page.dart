import 'package:flutter/material.dart';
import 'package:travio/core/common/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ttAppBar(context, 'Home', HomeCenter(context))
    );
  }

  // ignore: non_constant_identifier_names
  Center HomeCenter(BuildContext context){
    return const Center(
      child: Text('Home'),
    );
  }
}