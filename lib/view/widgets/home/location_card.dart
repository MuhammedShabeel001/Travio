import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/place_model.dart';

import '../../pages/home/locations/location_detail_page.dart';
// import 'package:travio/view/pages/location_detail_page.dart';

class LocationCard extends StatelessWidget {
  final String image;
  final String label;
  final PlaceModel location;

  const LocationCard({
    super.key,
    required this.image,
    required this.label,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailPage(location: location),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            width: 200,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                            imageUrl: image,
                    fit: BoxFit.cover,
                    height: 160,
                    width: double.infinity,
                    errorWidget: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        height: 160,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
