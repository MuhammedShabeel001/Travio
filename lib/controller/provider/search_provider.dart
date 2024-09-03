// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../model/package_model.dart';
// import '../../model/place_model.dart';

// class SearchProvider with ChangeNotifier {
//   List<TripPackageModel> _filteredPackages = [];
//   List<TripPackageModel> get filteredPackages => _filteredPackages;

//   List<PlaceModel> _filteredPlaces = [];
//   List<PlaceModel> get filteredPlaces => _filteredPlaces;

//   String _searchTerm = '';
//   String get searchTerm => _searchTerm;

//   bool _showLocations = true;
//   bool get showLocations => _showLocations;

//   bool _showPackages = true;
//   bool get showPackages => _showPackages;

//   RangeValues _priceRange = const RangeValues(0, 10000);
//   RangeValues get priceRange => _priceRange;

//   double _minRating = 0;
//   double get minRating => _minRating;

//   int _totalDays = 1;
//   int get totalDays => _totalDays;

//   List<String> _recentSearches = [];
//   List<String> get recentSearches => _recentSearches;

//   // Initialize SharedPreferences
//   SharedPreferences? _prefs;

//   SearchProvider() {
//     _loadRecentSearches();
//   }

//   // Load recent searches from SharedPreferences
//   Future<void> _loadRecentSearches() async {
//     _prefs = await SharedPreferences.getInstance();
//     _recentSearches = _prefs?.getStringList('recentSearches') ?? [];
//     notifyListeners();
//   }

//   // Add a search term to recent searches
//   void addRecentSearch(String term) {
//     term = term.trim();
//     if (term.isEmpty) return;

//     // Remove if already exists to avoid duplicates
//     _recentSearches.remove(term);
//     _recentSearches.insert(0, term);

//     // Keep only the latest 5 searches
//     if (_recentSearches.length > 5) {
//       _recentSearches = _recentSearches.sublist(0, 5);
//     }

//     _prefs?.setStringList('recentSearches', _recentSearches);
//     notifyListeners();
//   }

//   // Remove a search term from recent searches
//   void removeRecentSearch(String term) {
//     _recentSearches.remove(term);
//     _prefs?.setStringList('recentSearches', _recentSearches);
//     notifyListeners();
//   }

//   // Clear all recent searches
//   void clearRecentSearches() {
//     _recentSearches.clear();
//     _prefs?.remove('recentSearches');
//     notifyListeners();
//   }

//   // Modify updateSearchTerm to add to recent searches
//   void updateSearchTerm(String term) {
//     _searchTerm = term.toLowerCase();
//     notifyListeners();
//   }

//   // Call this when search is submitted
//   void onSearchSubmitted(String term, List<TripPackageModel> packages, List<PlaceModel> places) {
//     updateSearchTerm(term);
//     addRecentSearch(term);
//     applyFilters(packages, places);
//   }

//   TextEditingController searchController = TextEditingController();

//   // // Function to update the search term
//   // void updateSearchTerm(String term) {
//   //   _searchTerm = term.toLowerCase();
//   //   notifyListeners();  // Notify listeners to update UI
//   // }

//   // Function to set whether to show locations
//   void setShowLocations(bool value) {
//     _showLocations = value;
//     notifyListeners();
//   }

//   // Function to set whether to show packages
//   void setShowPackages(bool value) {
//     _showPackages = value;
//     notifyListeners();
//   }

//   // Function to set price range
//   void setPriceRange(RangeValues values) {
//     _priceRange = values;
//     notifyListeners();
//   }

//   // Function to set minimum rating
//   void setMinRating(double rating) {
//     _minRating = rating;
//     notifyListeners();
//   }

//   // Function to set total days
//   void setTotalDays(int days) {
//     _totalDays = days;
//     notifyListeners();
//   }

//   // Function to apply the filters
//   void applyFilters(List<TripPackageModel> packages, List<PlaceModel> places) {
//     // Reset filtered lists
//     _filteredPackages = [];
//     _filteredPlaces = [];

//     // Filter packages
//     if (_showPackages) {
//       _filteredPackages = packages.where((package) {
//         final priceMatch = package.offerPrice >= _priceRange.start && package.offerPrice <= _priceRange.end;



//         //change like count to ratings
//         final ratingMatch = package.likeCount >= _minRating;
//         final daysMatch = package.totalDays >= _totalDays;

//         return priceMatch && ratingMatch && daysMatch;
//       }).toList();
//     }

//     // Filter places
//     if (_showLocations) {
//       _filteredPlaces = places.where((place) {
//         // final priceMatch = place.offerPrice >= _priceRange.start && place.price <= _priceRange.end;
//         // final ratingMatch = place.rating >= _minRating;
//         // final daysMatch = place.totalDays >= _totalDays;

//         // return priceMatch && ratingMatch && daysMatch;
//         return false;
//       }).toList();
//     }

//     notifyListeners(); // Notify listeners to update the UI with filtered results
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/package_model.dart';
import '../../view/widgets/global/debouncer.dart';

class SearchProvider with ChangeNotifier {
  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  TextEditingController searchController = TextEditingController();

  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  double _minPrice = 0;
  double get minPrice => _minPrice;

  double _maxPrice = 100000;
  double get maxPrice => _maxPrice;

  int _totalDays = 14;
  int get totalDays => _totalDays;

  bool _isAscending = true;
  bool get isAscending => _isAscending;

  List<String> _recentSearches = [];
  List<String> get recentSearches => _recentSearches;

  // Initialize SharedPreferences
  SharedPreferences? _prefs;

  SearchProvider() {
    _loadRecentSearches();
  }

  // Load recent searches from SharedPreferences
  Future<void> _loadRecentSearches() async {
    _prefs = await SharedPreferences.getInstance();
    _recentSearches = _prefs?.getStringList('recentSearches') ?? [];
    notifyListeners();
  }

  void onSearchSubmitted(String term, List<TripPackageModel> packages) {
    updateSearchTerm(term);
    addRecentSearch(term);
    applyFilters(packages);
  }

  // Add a search term to recent searches
  void addRecentSearch(String term) {
    term = term.trim();
    if (term.isEmpty) return;

    _recentSearches.remove(term);
    _recentSearches.insert(0, term);

    if (_recentSearches.length > 5) {
      _recentSearches = _recentSearches.sublist(0, 5);
    }

    _prefs?.setStringList('recentSearches', _recentSearches);
    notifyListeners();
  }

  // Remove a search term from recent searches
  void removeRecentSearch(String term) {
    _recentSearches.remove(term);
    _prefs?.setStringList('recentSearches', _recentSearches);
    notifyListeners();
  }

// void updateSearchTerm(String term) {
//     _debouncer.run(() {
//       _searchTerm = term.toLowerCase();
//       applyFilters(_filteredPackages); // Apply filters after the debounce delay
//     });
//     notifyListeners();
//   }
  // Clear all recent searches
  void clearRecentSearches() {
    _recentSearches.clear();
    _prefs?.remove('recentSearches');
    notifyListeners();
  }

  // Function to update the search term
 void updateSearchTerm(String term) {
    _debouncer.run(() {
      _searchTerm = term.toLowerCase();
      applyFilters(_filteredPackages); // Apply filters after the debounce delay
    });
    notifyListeners();
  }

  // Function to set minimum price
  void setMinPrice(double value) {
    _minPrice = value;
    notifyListeners();
  }

  // Function to set maximum price
  void setMaxPrice(double value) {
    _maxPrice = value;
    notifyListeners();
  }

  // Function to set total days
  void setTotalDays(int days) {
    _totalDays = days;
    notifyListeners();
  }

  // Function to set sort order
  void setSortOrder(bool isAscending) {
    _isAscending = isAscending;
    notifyListeners();
  }

  // Function to apply the filters
  void applyFilters(List<TripPackageModel> packages) {
  // First filter based on the search term
  List<TripPackageModel> searchFilteredPackages = packages.where((package) {
    final nameMatch = package.name.toLowerCase().contains(_searchTerm);
    final countryMatch = package.locations.any((location) => location.toLowerCase().contains(_searchTerm));
    final activitiesMatch = package.activities.any((activity) => activity.toLowerCase().contains(_searchTerm));
    return nameMatch || countryMatch || activitiesMatch;
  }).toList();

  // Apply additional filters
  _filteredPackages = searchFilteredPackages.where((package) {
    final priceMatch = package.offerPrice >= _minPrice && package.offerPrice <= _maxPrice;
    final daysMatch = package.totalDays <= _totalDays; // Adjusted filter to include days less than or equal to the selected value
    return priceMatch && daysMatch;
  }).toList();

  // Sort based on ascending or descending order
  _filteredPackages.sort((a, b) {
    if (_isAscending) {
      return a.offerPrice.compareTo(b.offerPrice);
    } else {
      return b.offerPrice.compareTo(a.offerPrice);
    }
  });

  notifyListeners();
}

  // Function to reset filters to default values
  void resetFilters() {
    _minPrice = 0;
    _maxPrice = 10000;
    _totalDays = 1;
    _isAscending = true;

    notifyListeners();
  }
}
