import 'package:flutter/material.dart';
import 'package:travio/widgets/common/appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ttAppBar(context, 'Search', SearchCenter(context))
    );
  }

  // ignore: non_constant_identifier_names
  Center SearchCenter(BuildContext context){
    return const Center(
      child: Text('Search'),
    );
  }
}