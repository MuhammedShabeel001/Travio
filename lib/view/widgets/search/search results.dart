import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/location_provider.dart';
import 'package:travio/controller/provider/package_provider.dart';


import '../../../model/package_model.dart';
import '../../../model/place_model.dart';

class SearchResults extends StatelessWidget {
  final String searchTerm;
  final String filterTerm;

  const SearchResults({
    required this.searchTerm,
    required this.filterTerm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final packageProvider = Provider.of<TripPackageProvider>(context);

    // Filter locations
    final filteredLocations = locationProvider.places.where((place) {
      return place.name.toLowerCase().contains(searchTerm.toLowerCase()) &&
          (filterTerm.isEmpty || place.activities.contains(filterTerm));
    }).toList();

    // Filter packages
    final filteredPackages = packageProvider.package.where((package) {
      return package.name.toLowerCase().contains(searchTerm.toLowerCase()) &&
          (filterTerm.isEmpty || package.activities.contains(filterTerm));
    }).toList();

    // Combine the results
    final results = [...filteredLocations, ...filteredPackages];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 16.0, // Horizontal spacing
        mainAxisSpacing: 16.0, // Vertical spacing
        childAspectRatio: 1, // Aspect ratio of each item
      ),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        var result = results[index];

        // Determine if the result is a PlaceModel or TripPackageModel
        if (result is PlaceModel) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(result.images[0], fit: BoxFit.cover), // Access images correctly
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(result.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(result.activities), // Activities are a string in PlaceModel
                ),
              ],
            ),
          );
        } else if (result is TripPackageModel) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(result.images[0], fit: BoxFit.cover), // Access images correctly
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(result.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(result.activities.join(', ')), // Activities are a list in TripPackageModel
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink(); // Fallback if the type is unrecognized
        }
      },
    );
  }
}
