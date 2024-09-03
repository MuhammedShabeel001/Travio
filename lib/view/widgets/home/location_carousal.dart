// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travio/controller/provider/location_provider.dart';
// import 'package:travio/view/widgets/home/location_card.dart';

// class LocationCarousel extends StatelessWidget {
//   const LocationCarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Consumer<LocationProvider>(
//         builder: (context, locationProvider, child) {
//           if (locationProvider.places.isEmpty) {
//             return const SizedBox.shrink();
//           }
//           return Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               CarouselSlider.builder(
//                 itemCount: locationProvider.places.length < 5
//                     ? locationProvider.places.length
//                     : 5,
//                 itemBuilder: (context, index, realIdx) {
//                   // Ensure we're showing a maximum of 5 random items if there are more than 5 items
//                   final locationsToShow = locationProvider.places.length > 5
//                       ? (locationProvider.places..shuffle()).sublist(0, 5)
//                       : locationProvider.places;

//                   final location = locationsToShow[
//                       index]; // Select the item based on the shuffled list

//                   return LocationCard(
//                     width: 340,
//                     image: location.images.isNotEmpty
//                         ? location.images[0]
//                         : 'assets/images/placeholder.png',
//                     label: location.name,
//                     location: location,
//                   );
//                 },
//                 options: CarouselOptions(
//                   height: 200, // Increased height to accommodate the redesign
//                   autoPlay: false,
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.7, // Show parts of previous/next items
//                   enableInfiniteScroll: true,
//                   aspectRatio: 0.7,
//                   enlargeStrategy: CenterPageEnlargeStrategy.height,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     // SizedBox(
//     //   height: 200,
//     //   child: Consumer<LocationProvider>(
//     //     builder: (context, locationProvider, child) {
//     //       if (locationProvider.places.isEmpty) {
//     //         return const Center(child: CircularProgressIndicator());
//     //       }

//     //       return ListView(
//     //         scrollDirection: Axis.horizontal,
//     //         shrinkWrap: true,
//     //         children: locationProvider.places.map((place) {
//     //           return LocationCard(
//     //             width: 240,
//     //             image: place.images.isNotEmpty
//     //                 ? place.images[0]
//     //                 : 'assets/images/placeholder.png',
//     //             label: place.name,
//     //             location: place,
//     //           );
//     //         }).toList(),
//     //       );
//     //     },
//     //   ),
//     // );
//   }
// }



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
          // Fetch only Indian locations
          final indianLocations = locationProvider.locationsInIndia;

          if (indianLocations.isEmpty) {
            return const SizedBox.shrink(); // or return a loading indicator if needed
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: indianLocations.length < 5
                    ? indianLocations.length
                    : 5,
                itemBuilder: (context, index, realIdx) {
                  // Ensure we're showing a maximum of 5 random items if there are more than 5 items
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
