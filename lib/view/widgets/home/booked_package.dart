// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:travio/controller/provider/package_provider.dart';
// import 'package:travio/view/widgets/home/package/package_card.dart';

// class BookedPackageCarousel extends StatelessWidget {
//   const BookedPackageCarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Consumer<TripPackageProvider>(
//         builder: (context, packageProvider, child) {
//           return FutureBuilder(
//   future: packageProvider.fetchMostBookedPackages(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: const CircularProgressIndicator());
//     }

//     if (snapshot.hasError) {
//       return Center(child: Text('Error: ${snapshot.error}'));
//     }

//     if (packageProvider.filteredPackages.isEmpty) {
//       return const Text('No packages available.');
//     }

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       'Most Booked Packages',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   CarouselSlider.builder(
//                     itemCount: packageProvider.filteredPackages.length < 5
//                         ? packageProvider.filteredPackages.length
//                         : 5,
//                     options: CarouselOptions(
//                       height: 200,
//                       autoPlay: false,
//                       enlargeCenterPage: true,
//                       viewportFraction: 0.85,
//                       enableInfiniteScroll: true,
//                       aspectRatio: 0.7,
//                       enlargeStrategy: CenterPageEnlargeStrategy.height,
//                     ),
//                     itemBuilder: (context, index, realIdx) {
//                       final packagesToShow = packageProvider.filteredPackages;

//                       final package = packagesToShow[index];

//                       return PackageCard(
//                         width: 340,
//                         image: package.images.isNotEmpty
//                             ? package.images[0]
//                             : 'assets/images/placeholder.png',
//                         label: package.name,
//                         package: package,
//                       );
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


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
      return const Center(child: CircularProgressIndicator());
    }

    final packagesToShow = packages.length > 5 ? (packages..shuffle()).sublist(0, 5) : packages;

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
          const Text('More'),
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
            viewportFraction: 0.85,
            enableInfiniteScroll: true,
            aspectRatio: 0.7,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          itemBuilder: (context, index, realIdx) {
            final package = packagesToShow[index];
            return PackageCard(
              width: 340,
              image: package.images.isNotEmpty ? package.images[0] : 'assets/images/placeholder.png',
              label: package.name,
              package: package,
            );
          },
        ),
      ],
    );
  }
}
