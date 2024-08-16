import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/location_provider.dart';
import '../../../../controller/provider/package_provider.dart';
import '../../../widgets/home/location_card.dart';
import '../../../widgets/home/package/package_card.dart';

class InterestDetailPage extends StatelessWidget {
  final String interest;

  const InterestDetailPage({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.read<TripPackageProvider>();
    final locationProvider = context.read<LocationProvider>();

    // Fetch data by interest
    packageProvider.getPackagesByInterest(interest);
    locationProvider.getLocationsByInterest(interest);

    return Scaffold(
      appBar: AppBar(title: Text(interest)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Packages', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<TripPackageProvider>(
                builder: (context, packageProvider, child) {
                  if (packageProvider.packageByInterest.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: packageProvider.packageByInterest.length,
                    itemBuilder: (context, index) {
                      final package = packageProvider.packageByInterest[index];
                      return PackageCard(
                        image: package.images.isNotEmpty
                            ? package.images[0]
                            : 'assets/images/placeholder.png',
                        label: package.name,
                        package: package,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text('Locations', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  if (locationProvider.locationsByInterest.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: locationProvider.locationsByInterest.length,
                    itemBuilder: (context, index) {
                      final location = locationProvider.locationsByInterest[index];
                      return LocationCard(
                        image: location.images.isNotEmpty
                            ? location.images[0]
                            : 'assets/images/placeholder.png',
                        label: location.name,
                        location: location,
                      );
                    },
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
