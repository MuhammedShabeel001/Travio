import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/package_provider.dart';
import '../../../../model/package_model.dart';

class PackageInfoWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const PackageInfoWidget({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                tripPackage.name,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                tripPackageProvider.isLiked(tripPackage.id)
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                color: Colors.black,
              ),
              onPressed: () async {
                await tripPackageProvider.toggleLike(tripPackage.id);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          tripPackage.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                '₹${tripPackage.realPrice}',
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₹${tripPackage.offerPrice}',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' *per person',
                      style: TextStyle(
                        fontSize: 10, // Smaller font size
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Daily Plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Column(
          children: tripPackage.dailyPlan.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${entry.key + 1}: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Text(
          tripPackage.activities.join(', '),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Transport Options',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Text(
          tripPackage.transportOptions.join(', '),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          tripPackage.locations.length <= 1 ? 'Country' : 'Countries',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Text(
          tripPackage.locations.join(', '),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
