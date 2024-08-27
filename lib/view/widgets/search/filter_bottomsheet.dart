import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/search_provider.dart'; // Adjust the import path according to your project
import '../../../model/package_model.dart'; // Import the package model
import '../../../model/place_model.dart';   // Import the place model

class FilterBottomSheet extends StatelessWidget {
  final List<TripPackageModel> allPackages; // Add parameters for full list of packages
  final List<PlaceModel> allPlaces;         // Add parameters for full list of places

  const FilterBottomSheet({super.key, 
    required this.allPackages, // Pass full list of packages
    required this.allPlaces,   // Pass full list of places
  });

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Filter Type Selection (Locations and Packages)
          const Text(
            'Select Type',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: searchProvider.showLocations,
                  onChanged: (value) {
                    searchProvider.setShowLocations(value);
                  },
                  title: const Text('Locations'),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: searchProvider.showPackages,
                  onChanged: (value) {
                    searchProvider.setShowPackages(value);
                  },
                  title: const Text('Packages'),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          if (!searchProvider.showLocations && !searchProvider.showPackages)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Please select at least one option.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          const Divider(thickness: 1, height: 32),
          
          // Price Range Slider
          const Text(
            'Price Range',
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              thumbColor: Theme.of(context).colorScheme.primary,
              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Theme.of(context).colorScheme.primary,
            ),
            child: RangeSlider(
              values: searchProvider.priceRange,
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                searchProvider.priceRange.start.round().toString(),
                searchProvider.priceRange.end.round().toString(),
              ),
              onChanged: (values) {
                searchProvider.setPriceRange(values);
              },
            ),
          ),
          const Divider(thickness: 1, height: 32),

          // Ratings Slider
          const Text(
            'Ratings',
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              thumbColor: Theme.of(context).colorScheme.primary,
              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Theme.of(context).colorScheme.primary,
            ),
            child: Slider(
              value: searchProvider.minRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: searchProvider.minRating.toString(),
              onChanged: (value) {
                searchProvider.setMinRating(value);
              },
            ),
          ),
          const Divider(thickness: 1, height: 32),

          // Total Number of Days Slider
          const Text(
            'Total Number of Days',
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              thumbColor: Theme.of(context).colorScheme.primary,
              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Theme.of(context).colorScheme.primary,
            ),
            child: Slider(
              value: searchProvider.totalDays.toDouble(),
              min: 1,
              max: 30,
              divisions: 30,
              label: searchProvider.totalDays.toString(),
              onChanged: (value) {
                searchProvider.setTotalDays(value.round());
              },
            ),
          ),
          const Divider(thickness: 1, height: 32),

          // Apply Filters Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (searchProvider.showLocations || searchProvider.showPackages) {
                  searchProvider.applyFilters(allPackages, allPlaces);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
