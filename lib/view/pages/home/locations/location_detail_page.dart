import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/location_provider.dart';
import '../../../../model/place_model.dart';
import '../../../widgets/home/location/carousel_image.dart';
import '../../../widgets/home/location/details_section.dart';
import '../../../widgets/home/location/header_section.dart';

class LocationDetailPage extends StatelessWidget {
  final PlaceModel location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          for (var imageUrl in location.images) {
            precacheImage(NetworkImage(imageUrl), context);
          }

          return Column(
            children: [
              if (location.images.isNotEmpty)
                CarouselImage(
                  images: location.images,
                  onPageChanged: (index) {
                    locationProvider.updateIndex(index);
                  },
                  currentIndex: locationProvider.currentIndex,
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderSection(name: location.name),
                        const SizedBox(height: 16),
                        DetailsSection(
                          distance: "200 km away", // Hardcoded distance
                          weather: "24°C, Cloudy", // Hardcoded weather
                          description: location.description,
                          country: location.country,
                          continent: location.continent,
                          activities: location.activities,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
