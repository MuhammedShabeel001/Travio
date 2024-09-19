import 'package:flutter/material.dart';

class PackageHeader extends StatelessWidget {
  final Map<String, dynamic> packageData;

  const PackageHeader({super.key, required this.packageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(
                packageData['images'] != null && packageData['images'].isNotEmpty
                    ? packageData['images'][0]
                    : 'https://via.placeholder.com/200',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          packageData['name'] ?? 'Package Name',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          packageData['description'] ?? 'No description available.',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
