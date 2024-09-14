import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/view/pages/home/locations/india_location_list_page.dart';
import 'package:travio/view/pages/home/locations/locations_list_page.dart';
import 'package:travio/view/pages/home/package/packages_listout_page.dart';

import 'package:travio/view/widgets/global/custom_homebar.dart';
import 'package:travio/view/widgets/home/all_location_card.dart';
import 'package:travio/view/widgets/home/booked_package.dart';

import '../../../controller/provider/payment_provider.dart';
import '../../widgets/home/interest_row.dart';
import '../../widgets/home/location_carousal.dart';
import '../../widgets/home/package_carousal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TripPackageProvider>().initializeData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the moveExpiredBookingsToArchive function here
      Provider.of<PaymentProvider>(context, listen: false).moveExpiredBookingsToArchive();

    });

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
          const InterestRow(),
          const SizedBox(height: 30),
           SectionHeader(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => PackagesListPage(),));
            },
            title: 'Packages'),
          // const SizedBox(height: 15),
          const PackageCarousel(),
          const SizedBox(height: 30),
          SectionHeader(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => IndiaLocationsListPage(),));
            },
            title: 'India'),
          // const SizedBox(height: 15),
          const LocationCarousel(),
          // const SizedBox(height: 15),
          TPackageCarousel(
            packages: packageProvider.filteredBookedPackages,
            title: 'Most Booked Packages',
          ),
          // const SizedBox(height: 15),
          TPackageCarousel(
            packages: packageProvider.filteredReviewPackages,
            title: 'Top Reviewed Packages',
          ),
           const SizedBox(height: 30),
          SectionHeader(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => LocationsListPage(),));
            },
            title: 'All locations'),
          // const SizedBox(height: 15),
          const AllLocationCarousel(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({required this.title, super.key, required this.onTap});

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
          GestureDetector(
            onTap: onTap,
            child: const Text('More')),
        ],
      ),
    );
  }
}
