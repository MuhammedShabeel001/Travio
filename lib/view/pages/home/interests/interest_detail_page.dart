import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this if you're using SVGs for icons
import 'package:travio/core/theme/theme.dart';

// import '../../../../controller/provider/location_provider.dart';
import '../../../../controller/provider/package_provider.dart';
import '../../../widgets/home/package/package_card.dart';

class InterestDetailPage extends StatelessWidget {
  final String interest;

  const InterestDetailPage({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.read<TripPackageProvider>();
    // final locationProvider = context.read<LocationProvider>();

    // Fetch data by interest
    packageProvider.getPackagesByInterest(interest);
    // locationProvider.getLocationsByInterest(interest);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(interest,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: TTthemeClass().ttThird, // Adjust to match your theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Packages Section
            const Text(
              '  Packages',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<TripPackageProvider>(
                builder: (context, packageProvider, child) {
                  if (packageProvider.packageByInterest.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/no_data.svg', // Example for SVG icon
                              color: Colors.grey, // Color can be adjusted
                              width: 80,
                              height: 80),
                          const SizedBox(height: 10),
                          const Text(
                            'No Packages Available',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: packageProvider.packageByInterest.length,
                    itemBuilder: (context, index) {
                      final package = packageProvider.packageByInterest[index];
                      return Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          PackageCard(
                            height: 150,
                            image: package.images.isNotEmpty
                                ? package.images[0]
                                : 'assets/images/placeholder.png',
                            label: package.name,
                            package: package,
                          ),
                        ],
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
