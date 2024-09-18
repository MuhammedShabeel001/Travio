import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';

class PackageCarousel extends StatelessWidget {
  const PackageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<TripPackageProvider>(
        builder: (context, packageProvider, child) {
          if (packageProvider.package.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: packageProvider.package.length < 5
                    ? packageProvider.package.length
                    : 5,
                options: CarouselOptions(
                  height: 200, // Increased height to accommodate the redesign
                  autoPlay: false,
                  // enlargeCenterPage: true, 
                  viewportFraction: 0.75, // Show parts of previous/next items
                  enableInfiniteScroll: false,
                  aspectRatio: 0.7,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                itemBuilder: (context, index, realIdx) {
                  // Ensure we're showing a maximum of 5 random items if there are more than 5 items
                  final packagesToShow = packageProvider.package.length > 5
                      ? (packageProvider.package..shuffle()).sublist(0, 5)
                      : packageProvider.package;

                  final package = packagesToShow[
                      index]; // Select the item based on the shuffled list

                  return PackageCard(
                    width: 340,
                    image: package.images.isNotEmpty
                        ? package.images[0]
                        : 'assets/images/placeholder.png',
                    label: package.name,
                    package: package,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
