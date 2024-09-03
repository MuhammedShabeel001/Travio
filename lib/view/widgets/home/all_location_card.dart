import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/location_provider.dart';
import 'package:travio/view/widgets/home/location_card.dart';

class AllLocationCarousel extends StatelessWidget {
  const AllLocationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          if (locationProvider.places.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                itemCount: locationProvider.places.length < 5
                    ? locationProvider.places.length
                    : 5,
                itemBuilder: (context, index, realIdx) {
                  // Ensure we're showing a maximum of 5 random items if there are more than 5 items
                  final locationsToShow = locationProvider.places.length > 5
                      ? (locationProvider.places..shuffle()).sublist(0, 5)
                      : locationProvider.places;

                  final location = locationsToShow[
                      index]; // Select the item based on the shuffled list

                  return LocationCard(
                    width: 400,
                    image: location.images.isNotEmpty
                        ? location.images[0]
                        : 'assets/images/placeholder.png',
                    label: location.name,
                    location: location,
                  );
                },
                options: CarouselOptions(
                  height: 200, // Increased height to accommodate the redesign
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9, // Show parts of previous/next items
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
