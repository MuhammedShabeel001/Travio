import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
// import 'package:travio/view/home/interest_row.dart';
// import 'package:travio/view/home/explore_list_view.dart';
// import 'package:travio/view/home/location_carousel.dart';
// import 'package:travio/view/home/package_carousel.dart';
import 'package:travio/view/widgets/global/custom_homebar.dart';

import '../../widgets/home/explore_listview.dart';
import '../../widgets/home/interest_row.dart';
import '../../widgets/home/location_carousal.dart';
import '../../widgets/home/package_carousal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TripPackageProvider>().fetchAllPackages();
    return Scaffold(
      body: HomeBar(body: const HomeCenter()),
    );
  }
}

class HomeCenter extends StatelessWidget {
  const HomeCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SectionHeader(title: 'Discover by Interests'),
          SizedBox(height: 16),
          InterestRow(),
          SizedBox(height: 30),
          SectionHeader(title: 'Explore the World'),
          SizedBox(height: 15),
          ExploreListView(),
          SizedBox(height: 30),
          SectionHeader(title: 'India'),
          SizedBox(height: 15),
          LocationCarousel(),
          SizedBox(height: 30),
          SectionHeader(title: 'Packages'),
          SizedBox(height: 15),
          PackageCarousel(),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text('More'),
        ],
      ),
    );
  }
}
