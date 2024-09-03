import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/package_model.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';

class TPackageCarousel extends StatelessWidget {
  final List<TripPackageModel> packages;
  final String title;

  const TPackageCarousel({
    required this.packages,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (packages.isEmpty) {
      return const SizedBox.shrink(); // Return a shrunken SizedBox when empty
    }

    // Limit the number of packages to show to 3
    final packagesToShow =
        packages.length > 3 ? (packages..shuffle()).sublist(0, 3) : packages;

    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // const Text('More'),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider.builder(
          itemCount: packagesToShow.length,
          options: CarouselOptions(
            height: 200,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.90,
            enableInfiniteScroll: false, // Disable infinite scroll
            aspectRatio: 1, 
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          ),
          itemBuilder: (context, index, realIdx) {
            final package = packagesToShow[index];
            return PackageCard(
              width: 400, 
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
  }
}
