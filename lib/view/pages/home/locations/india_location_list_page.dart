import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/location_provider.dart';
import '../../../../core/theme/theme.dart';
import '../../../widgets/home/location_card.dart';

class IndiaLocationsListPage extends StatelessWidget {
  const IndiaLocationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'India Locations',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: TTthemeClass().ttThird,
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          final indianLocations = locationProvider.locationsInIndia;

          if (indianLocations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: indianLocations.length,
            itemBuilder: (context, index) {
              final location = indianLocations[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: LocationCard(
                  width: 400,
                  image: location.images.isNotEmpty
                      ? location.images[0]
                      : 'assets/images/placeholder.png',
                  label: location.name,
                  location: location,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
