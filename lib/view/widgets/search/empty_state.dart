import 'package:flutter/material.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';

import '../../../model/package_model.dart';

class PackageSection extends StatelessWidget {
  final String title;
  final List<TripPackageModel> packages;

  const PackageSection({super.key, required this.title, required this.packages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        packages.isNotEmpty
            ? Column(
                children: packages
                    .map((package) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PackageCard(
                            height: 200,
                            image: package.images.isNotEmpty
                                ? package.images[0]
                                : 'assets/images/placeholder.png',
                            label: package.name,
                            package: package,
                          ),
                        ))
                    .toList(),
              )
            : const Center(child: Text('No packages available')),
      ],
    );
  }
}
