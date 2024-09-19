import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/location_provider.dart';
import 'package:travio/view/widgets/home/location_card.dart';

class LocationCarousel extends StatelessWidget {
  const LocationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          final indianLocations = locationProvider.locationsInIndia;

          if (indianLocations.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount:
                    indianLocations.length < 5 ? indianLocations.length : 5,
                itemBuilder: (context, index, realIdx) {
                  final locationsToShow = indianLocations.length > 5
                      ? (indianLocations..shuffle()).sublist(0, 5)
                      : indianLocations;

                  final location = locationsToShow[index];

                  return LocationCard(
                    width: 340,
                    image: location.images.isNotEmpty
                        ? location.images[0]
                        : 'assets/images/placeholder.png',
                    label: location.name,
                    location: location,
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  enableInfiniteScroll: false,
                  aspectRatio: 0.7,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
