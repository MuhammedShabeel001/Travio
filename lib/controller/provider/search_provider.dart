import 'package:flutter/material.dart';
import '../../model/package_model.dart';
import '../../model/place_model.dart';

class SearchProvider with ChangeNotifier {
  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  List<PlaceModel> _filteredPlaces = [];
  List<PlaceModel> get filteredPlaces => _filteredPlaces;

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  bool _showLocations = true;
  bool get showLocations => _showLocations;

  bool _showPackages = true;
  bool get showPackages => _showPackages;

  RangeValues _priceRange = const RangeValues(0, 10000);
  RangeValues get priceRange => _priceRange;

  double _minRating = 0;
  double get minRating => _minRating;

  int _totalDays = 1;
  int get totalDays => _totalDays;

  TextEditingController searchController = TextEditingController();

  // Function to update the search term
  void updateSearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    notifyListeners();  // Notify listeners to update UI
  }

  // Function to set whether to show locations
  void setShowLocations(bool value) {
    _showLocations = value;
    notifyListeners();
  }

  // Function to set whether to show packages
  void setShowPackages(bool value) {
    _showPackages = value;
    notifyListeners();
  }

  // Function to set price range
  void setPriceRange(RangeValues values) {
    _priceRange = values;
    notifyListeners();
  }

  // Function to set minimum rating
  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  // Function to set total days
  void setTotalDays(int days) {
    _totalDays = days;
    notifyListeners();
  }

  // Function to apply the filters
  void applyFilters(List<TripPackageModel> packages, List<PlaceModel> places) {
    // Reset filtered lists
    _filteredPackages = [];
    _filteredPlaces = [];

    // Filter packages
    if (_showPackages) {
      _filteredPackages = packages.where((package) {
        final priceMatch = package.offerPrice >= _priceRange.start && package.offerPrice <= _priceRange.end;



        //change like count to ratings
        final ratingMatch = package.likeCount >= _minRating;
        final daysMatch = package.totalDays >= _totalDays;

        return priceMatch && ratingMatch && daysMatch;
      }).toList();
    }

    // Filter places
    if (_showLocations) {
      _filteredPlaces = places.where((place) {
        // final priceMatch = place.offerPrice >= _priceRange.start && place.price <= _priceRange.end;
        // final ratingMatch = place.rating >= _minRating;
        // final daysMatch = place.totalDays >= _totalDays;

        // return priceMatch && ratingMatch && daysMatch;
        return false;
      }).toList();
    }

    notifyListeners(); // Notify listeners to update the UI with filtered results
  }
}
