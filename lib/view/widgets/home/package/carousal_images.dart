import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:travio_admin/controller/package_provider.dart';
// import 'package:travio_admin/view/widgets/global/shimmer_loading.dart';
// // import 'package:travio_admin/widgets/global/shimmer_loading.dart';
// import 'package:travio_admin/model/package_model.dart';

import '../../../../model/package_model.dart';
import '../../global/custom_image_loader.dart';

class CarouselWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const CarouselWidget({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            // onPageChanged: (index, reason) {
            //   Provider.of<TripPackageProvider>(context, listen: false)
            //       .updateIndex(index);
            // },
          ),
          items: tripPackage.images.map((imageUrl) {
            return CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              placeholder: (context, url) => ShimmerPlaceholder(
                width: MediaQuery.of(context).size.width,
                height: 350.0,
              ),
              errorWidget: (context, error, stackTrace) => Image.asset(
                'assets/images/placeholder.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            );
          }).toList(),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8), // Bottom color (Black)
                Colors.transparent, // Top color (Transparent)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                log('tapped');
                Navigator.pop(context);
                log('tapped 2');
              },
            ),
          ),
        ),
      ],
    );
  }
}
