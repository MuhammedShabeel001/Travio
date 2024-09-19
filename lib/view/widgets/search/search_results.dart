import 'package:flutter/material.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';
import 'package:travio/controller/provider/search_provider.dart';

class SearchResults extends StatelessWidget {
  final SearchProvider searchProvider;

  const SearchResults({super.key, required this.searchProvider});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (searchProvider.filteredPackages.isNotEmpty) ...[
          const Text(
            'Packages',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...searchProvider.filteredPackages.map(
            (package) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PackageCard(
                height: 150,
                width: double.infinity,
                image: package.images.isNotEmpty
                    ? package.images[0]
                    : 'assets/images/placeholder.png',
                label: package.name,
                package: package,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
