import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/view/widgets/search/search_bar.dart';
import '../../../controller/provider/location_provider.dart';
import '../../../controller/provider/package_provider.dart';
import '../../../controller/provider/search_provider.dart'; // Import SearchProvider
import '../../../core/theme/theme.dart';
import '../../widgets/home/location_card.dart';
import '../../widgets/home/package/package_card.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the search provider
    final searchProvider = Provider.of<SearchProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return GestureDetector(
      child: DraggableHome(
        appBarColor: TTthemeClass().ttLightPrimary,
        title: ttSearchBar(
          controller: searchProvider.searchController,
          bgColor: TTthemeClass().ttLightPrimary,
          onSearch: (term) {
            // Update search term and perform search
            searchProvider.updateSearchTerm(term);
            searchProvider.searchCombined(
              tripPackageProvider.package,
              locationProvider.places,
            );
          },
        ),
        centerTitle: false,
        headerExpandedHeight: 0.15,
        backgroundColor: TTthemeClass().ttSecondary,
        headerWidget: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          color: TTthemeClass().ttLightPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ttSearchBar(
                controller: searchProvider.searchController,
                bgColor: TTthemeClass().ttSecondary,
                onSearch: (term) {
                  // Update search term and perform search
                  searchProvider.updateSearchTerm(term);
                  searchProvider.searchCombined(
                    tripPackageProvider.package,
                    locationProvider.places,
                  );
                },
              ),
            ],
          ),
        ),
        body: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Display the search results for locations
                if (searchProvider.filteredPlaces.isNotEmpty)
                  ...searchProvider.filteredPlaces.map(
                    (place) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LocationCard(
                        width: 400,
                        image: place.images.isNotEmpty
                            ? place.images[0]
                            : 'assets/images/placeholder.png',
                        label: place.name,
                        location: place,
                      ),
                    ),
                  ).toList(),

                // Display the search results for packages
                if (searchProvider.filteredPackages.isNotEmpty)
                  ...searchProvider.filteredPackages.map(
                    (package) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PackageCard(
                        width: 400,
                        image: package.images.isNotEmpty
                            ? package.images[0]
                            : 'assets/images/placeholder.png',
                        label: package.name,
                        package: package,
                      ),
                    ),
                  ).toList(),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
