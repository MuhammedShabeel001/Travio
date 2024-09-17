import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/package_provider.dart';
import '../../../../model/package_model.dart';

class LikesAndReviewsWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const LikesAndReviewsWidget({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripPackageProvider>(
      builder: (context, tripPackageProvider, child) {
        final isLiked = tripPackageProvider.isLiked(tripPackage.id);
        final likeCount = tripPackageProvider.package
            .firstWhere((pkg) => pkg.id == tripPackage.id)
            .likeCount;
        final reviewCount = tripPackage.reviews.length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  '$likeCount Likes',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  '$reviewCount Reviews',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
