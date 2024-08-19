import 'package:flutter/material.dart';

import '../../model/package_model.dart';
import '../../model/place_model.dart';
// import 'package:your_app/model/package_model.dart';
// import 'package:your_app/model/place_model.dart';

class SearchProvider with ChangeNotifier {
  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  List<PlaceModel> _filteredPlaces = [];
  List<PlaceModel> get filteredPlaces => _filteredPlaces;

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  TextEditingController searchController = TextEditingController();

  // Function to update the search term
  void updateSearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    notifyListeners();  // Notify listeners to update UI
  }

  // Combined function to search within both packages and locations
  void searchCombined(List<TripPackageModel> packages, List<PlaceModel> places) {
    if (_searchTerm.isEmpty) {
      _filteredPackages = packages;
      _filteredPlaces = places;
    } else {
      // Search in packages
      _filteredPackages = packages.where((package) {
        final nameLower = package.name.toLowerCase();
        final activitiesLower = package.activities.map((activity) => activity.toLowerCase()).toList();
        return nameLower.contains(_searchTerm) ||
            activitiesLower.any((activity) => activity.contains(_searchTerm));
      }).toList();

      // Search in places
      _filteredPlaces = places.where((place) {
        final searchLower = _searchTerm.toLowerCase();
        final activities = place.activities.toLowerCase().split(', ');

        return place.name.toLowerCase().contains(searchLower) ||
            place.country.toLowerCase().contains(searchLower) ||
            place.continent.toLowerCase().contains(searchLower) ||
            activities.any((activity) => activity.contains(searchLower));
      }).toList();
    }
    
    // Notify listeners to update UI
    notifyListeners();
  }
}
