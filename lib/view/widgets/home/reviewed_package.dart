import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';

class ReviewedPackageCarousel extends StatelessWidget {
  const ReviewedPackageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final packageProvider =
          Provider.of<TripPackageProvider>(context, listen: false);
      if (packageProvider.filteredPackages.isEmpty) {
        packageProvider.fetchTopReviewedPackages();
      }
    });

    return Consumer<TripPackageProvider>(
      builder: (context, packageProvider, child) {
        if (packageProvider.filteredPackages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final packagesToShow = packageProvider.filteredPackages.length > 5
            ? (packageProvider.filteredPackages..shuffle()).sublist(0, 5)
            : packageProvider.filteredPackages;

        return SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: packagesToShow.length,
                options: CarouselOptions(
                  height: 200,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  enableInfiniteScroll: true,
                  aspectRatio: 0.7,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                itemBuilder: (context, index, realIdx) {
                  final package = packagesToShow[index];

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
          ),
        );
      },
    );
  }
}
