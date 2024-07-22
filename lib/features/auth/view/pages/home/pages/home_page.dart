import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/core/common/appbar.dart';
import 'package:travio/features/auth/controller/location_provider.dart';
import 'package:travio/features/auth/view/pages/home/widgets/explore_item.dart';
import 'package:travio/features/auth/view/pages/home/widgets/interest_tabs.dart';
import 'package:travio/features/auth/view/pages/home/widgets/location_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ttAppBar(context, 'Home', HomeCenter(context)),
    );
  }

  // ignore: non_constant_identifier_names
  SingleChildScrollView HomeCenter(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover by interests',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InterestTabs(icon: Icons.hiking_rounded, label: 'Hiking'),
                InterestTabs(icon: Icons.terrain_rounded, label: 'Mountain'),
                InterestTabs(icon: Icons.forest_rounded, label: 'Forest'),
                InterestTabs(icon: Icons.beach_access_rounded, label: 'Sea'),
                InterestTabs(icon: Icons.grid_view_rounded, label: 'More'),
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore the world',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('More'),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: const [
                  ExploreItem(
                      image: 'assets/images/entry_pic.png', label: 'Dubai'),
                  ExploreItem(
                      image: 'assets/images/entry_pic.png', label: 'Paris'),
                  ExploreItem(
                      image: 'assets/images/entry_pic.png', label: 'London'),
                  ExploreItem(
                      image: 'assets/images/entry_pic.png', label: 'Japan'),
                  ExploreItem(
                      image: 'assets/images/entry_pic.png', label: 'Korea'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'India',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('More')
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 200,
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  if (locationProvider.places.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: locationProvider.places.map((place) {
                      return LocationCard(
                        image: place.images.isNotEmpty
                            ? place.images[0]
                            : 'assets/images/placeholder.png',
                        label: place.name,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
