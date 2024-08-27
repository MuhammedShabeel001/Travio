import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';

import 'package:travio/view/widgets/global/custom_homebar.dart';
import 'package:travio/view/widgets/home/booked_package.dart';
// import 'package:travio/view/widgets/home/reviewed_package.dart';

// import '../../widgets/home/explore_listview.dart';
import '../../widgets/home/interest_row.dart';
import '../../widgets/home/location_carousal.dart';
import '../../widgets/home/package_carousal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TripPackageProvider>().initializeData();

    return const Scaffold(
      body: HomeBar(body: HomeCenter()),
    );
  }
}

class HomeCenter extends StatelessWidget {
  const HomeCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.watch<TripPackageProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Discover by Interests'),
          const SizedBox(height: 16),
          const InterestRow(),
          const SizedBox(height: 15),
          TPackageCarousel(
            packages: packageProvider.filteredBookedPackages,
            title: 'Most Booked Packages',
          ),
          const SizedBox(height: 15),
          TPackageCarousel(
            packages: packageProvider.filteredReviewPackages,
            title: 'Top Reviewed Packages',
          ),
          const SizedBox(height: 30),
          const SectionHeader(title: 'India'),
          const SizedBox(height: 15),
          const LocationCarousel(),
          const SizedBox(height: 30),
          const SectionHeader(title: 'Packages'),
          const SizedBox(height: 15),
          const PackageCarousel(),
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
