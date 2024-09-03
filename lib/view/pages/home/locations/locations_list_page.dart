import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/location_provider.dart';
import '../../../../core/theme/theme.dart';
import '../../../widgets/home/location_card.dart';

// import '../../controller/provider/location_provider.dart';
// import '../../widgets/location_card.dart';

class LocationsListPage extends StatelessWidget {
  const LocationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text('India locations',style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: TTthemeClass().ttThird,
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          final locations = locationProvider.places;

          if (locations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 12,),
                    LocationCard(
                          width: 400,
                          image: location.images.isNotEmpty
                              ? location.images[0]
                              : 'assets/images/placeholder.png',
                          label: location.name,
                          location: location,
                        ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
