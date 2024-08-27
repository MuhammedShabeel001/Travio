import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../controller/provider/location_provider.dart';
import '../../../../model/place_model.dart';
import '../../../widgets/global/custom_image_loader.dart';

class LocationDetailPage extends StatelessWidget {
  final PlaceModel location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
     
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          for (var imageUrl in location.images) {
            precacheImage(NetworkImage(imageUrl), context);
          }

          return Column(
            children: [
              if (location.images.isNotEmpty)
                Stack(
                  children: [
                    Container(
                      height: 350,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 350.0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 6), // Adjusted timing
                          onPageChanged: (index, reason) {
                            locationProvider.updateIndex(index);
                          },
                        ),
                        items: location.images.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: (context, url) =>
                                      ShimmerPlaceholder(
                                    width: MediaQuery.of(context).size.width,
                                    height: 350.0,
                                  ),
                                  errorWidget: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        
                      ),
                    ),
                    Positioned(
          top: 46,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: locationProvider.currentIndex,
                          count: location.images.length,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.grey,
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        Center(
                          child: Text(
                            location.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.redAccent),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "200 km away", // Hardcoded distance
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.map, color: Colors.blueAccent),
                              onPressed: () {
                                // Navigate to map functionality (if applicable)
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.cloud, color: Colors.blueAccent),
                            const SizedBox(width: 8),
                            Text(
                              "24°C, Cloudy", // Hardcoded weather
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          location.description,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(thickness: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Country:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  location.country,
                                  style:
                                      Theme.of(context).textTheme.bodySmall
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Continent:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  location.continent,
                                  style:
                                      Theme.of(context).textTheme.bodySmall
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(thickness: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        const Text(
                          'Activities:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: location.activities
                              .split(', ')
                              .map((activity) => Chip(
                                    label: Text(activity),
                                    backgroundColor: Colors.purpleAccent,
                                    labelStyle: const TextStyle(color: Colors.white),
                                  ))
                              .toList(),
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
