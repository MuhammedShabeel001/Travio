import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/package_model.dart';
import 'package:travio/model/place_model.dart';
import 'package:travio/view/pages/home/package/package_detail_page.dart';


class PackageCard extends StatelessWidget {
  final String image;
  final String label;
  final TripPackageModel package;

  const PackageCard({
    super.key,
    required this.image,
    required this.label, required this.package,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripPackageDetailPage(tripPackage: package),
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
