import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/package_model.dart';
import '../../view/widgets/global/debouncer.dart';

/// Provider for managing search state and filters for trip packages.
class SearchProvider with ChangeNotifier {

  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  String _searchTerm = '';
  double _minPrice = 0;
  double _maxPrice = 100000;
  int _totalDays = 14;
  bool _isAscending = true;
  List<String> _recentSearches = [];
  SharedPreferences? _prefs;
  List<TripPackageModel> _filteredPackages = [];

  String get searchTerm => _searchTerm;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  int get totalDays => _totalDays;
  bool get isAscending => _isAscending;
  List<String> get recentSearches => _recentSearches;
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  TextEditingController searchController = TextEditingController();

  SearchProvider() {
    _loadRecentSearches();
  }

  /// Loads recent searches from SharedPreferences.
  Future<void> _loadRecentSearches() async {
    _prefs = await SharedPreferences.getInstance();
    _recentSearches = _prefs?.getStringList('recentSearches') ?? [];
    notifyListeners();
  }

  /// Handles search submission and applies filters to the list of packages.
  void onSearchSubmitted(String term, List<TripPackageModel> packages) {
    updateSearchTerm(term);
    addRecentSearch(term);
    applyFilters(packages);
  }

  /// Adds a term to recent searches, maintaining a maximum of 5 entries.
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

  /// Removes a specific term from recent searches.
  void removeRecentSearch(String term) {
    _recentSearches.remove(term);
    _prefs?.setStringList('recentSearches', _recentSearches);
    notifyListeners();
  }

  /// Clears all recent searches.
  void clearRecentSearches() {
    _recentSearches.clear();
    _prefs?.remove('recentSearches');
    notifyListeners();
  }

  /// Updates the search term and applies filters with debounce.
  void updateSearchTerm(String term) {
    _debouncer.run(() {
      _searchTerm = term.toLowerCase();
      applyFilters(_filteredPackages);
    });
    notifyListeners();
  }

  /// Sets the minimum price filter and notifies listeners.
  void setMinPrice(double value) {
    _minPrice = value;
    notifyListeners();
  }

  /// Sets the maximum price filter and notifies listeners.
  void setMaxPrice(double value) {
    _maxPrice = value;
    notifyListeners();
  }

  /// Sets the total days filter and notifies listeners.
  void setTotalDays(int days) {
    _totalDays = days;
    notifyListeners();
  }

  /// Sets the sort order and notifies listeners.
  void setSortOrder(bool isAscending) {
    _isAscending = isAscending;
    notifyListeners();
  }

  /// Applies all filters to the list of packages.
  void applyFilters(List<TripPackageModel> packages) {
    List<TripPackageModel> searchFilteredPackages = packages.where((package) {
      final nameMatch = package.name.toLowerCase().contains(_searchTerm);
      final countryMatch = package.locations
          .any((location) => location.toLowerCase().contains(_searchTerm));
      final activitiesMatch = package.activities
          .any((activity) => activity.toLowerCase().contains(_searchTerm));
      return nameMatch || countryMatch || activitiesMatch;
    }).toList();

    _filteredPackages = searchFilteredPackages.where((package) {
      final priceMatch =
          package.offerPrice >= _minPrice && package.offerPrice <= _maxPrice;
      final daysMatch = package.totalDays <= _totalDays;
      return priceMatch && daysMatch;
    }).toList();

    _filteredPackages.sort((a, b) {
      if (_isAscending) {
        return a.offerPrice.compareTo(b.offerPrice);
      } else {
        return b.offerPrice.compareTo(a.offerPrice);
      }
    });

    notifyListeners();
  }

  /// Resets all filters to their default values.
  void resetFilters() {
    _minPrice = 0;
    _maxPrice = 100000;
    _totalDays = 14;
    _isAscending = true;

    notifyListeners();
  }
}
