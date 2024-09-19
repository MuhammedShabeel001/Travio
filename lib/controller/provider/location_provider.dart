import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import '../../model/place_model.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final SearchProvider searchProvider;
  final TripPackageProvider tripPackageProvider;

  List<PlaceModel> _places = [];
  List<PlaceModel> _locationsInIndia = [];
  int _currentIndex = 0;

  List<PlaceModel> get places => _places;
  List<PlaceModel> get locationsInIndia => _locationsInIndia;
  int get currentIndex => _currentIndex;

  LocationProvider(this.searchProvider, this.tripPackageProvider) {
    fetchAllLocations();
    fetchLocationsInIndia();
  }

  /// Fetches all locations and applies filters from the search provider.
  void fetchAllLocations() {
    db.collection('places').snapshots().listen(
      (snapshot) {
        _places = snapshot.docs
            .map((doc) => PlaceModel.fromMap(doc.data()))
            .toList();

        final packages = tripPackageProvider.package;
        searchProvider.applyFilters(packages);
        
        notifyListeners();
      },
      onError: (error) {
        log('Error fetching locations: $error');
      }
    );
  }

  /// Fetches locations in India.
  void fetchLocationsInIndia() {
    db.collection('places')
      .where('country', isEqualTo: 'India')
      .snapshots()
      .listen(
        (snapshot) {
          _locationsInIndia = snapshot.docs
              .map((doc) => PlaceModel.fromMap(doc.data()))
              .toList();
          notifyListeners();
        },
        onError: (error) {
          log('Error fetching locations in India: $error');
        }
      );
  }

  /// Updates the current index.
  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
