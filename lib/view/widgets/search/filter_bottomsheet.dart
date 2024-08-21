import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/search_provider.dart'; // Adjust the import path according to your project
import '../../../model/package_model.dart'; // Import the package model
import '../../../model/place_model.dart';   // Import the place model

class FilterBottomSheet extends StatelessWidget {
  final List<TripPackageModel> allPackages; // Add parameters for full list of packages
  final List<PlaceModel> allPlaces;         // Add parameters for full list of places

  FilterBottomSheet({
    required this.allPackages, // Pass full list of packages
    required this.allPlaces,   // Pass full list of places
  });

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          
          // Filter Type Selection (Locations and Packages)
          Text('Select Type'),
          Row(
            children: [
              Checkbox(
                value: searchProvider.showLocations,
                onChanged: (value) {
                  searchProvider.setShowLocations(value!);
                },
              ),
              Text('Locations'),
              Checkbox(
                value: searchProvider.showPackages,
                onChanged: (value) {
                  searchProvider.setShowPackages(value!);
                },
              ),
              Text('Packages'),
            ],
          ),
          
          // Warning if neither Locations nor Packages are selected
          if (!searchProvider.showLocations && !searchProvider.showPackages)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Please select at least one option.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          Divider(),
          
          // Price Range Slider
          Text('Price Range'),
          RangeSlider(
            values: searchProvider.priceRange,
            min: 0,
            max: 10000,
            divisions: 100,
            labels: RangeLabels(
              searchProvider.priceRange.start.round().toString(),
              searchProvider.priceRange.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              searchProvider.setPriceRange(values);
            },
          ),
          Divider(),
          
          // Ratings Slider
          Text('Ratings'),
          Slider(
            value: searchProvider.minRating,
            min: 0,
            max: 5,
            divisions: 5,
            label: searchProvider.minRating.toString(),
            onChanged: (value) {
              searchProvider.setMinRating(value);
            },
          ),
          Divider(),
          
          // Total Number of Days Slider
          Text('Total Number of Days'),
          Slider(
            value: searchProvider.totalDays.toDouble(),
            min: 1,
            max: 30,
            divisions: 30,
            label: searchProvider.totalDays.toString(),
            onChanged: (value) {
              searchProvider.setTotalDays(value.round());
            },
          ),
          Divider(),
          
          // Apply Filters Button
          ElevatedButton(
            onPressed: () {
              // Ensure at least one option is selected
              if (searchProvider.showLocations || searchProvider.showPackages) {
                searchProvider.applyFilters(allPackages, allPlaces); // Pass the full list of packages and places
                Navigator.pop(context); // Close the bottom sheet after applying
              }
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
