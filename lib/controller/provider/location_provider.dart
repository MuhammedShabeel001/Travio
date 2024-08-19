// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../model/place_model.dart';

// class LocationProvider with ChangeNotifier {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   // Holds all the places fetched from Firestore
//   List<PlaceModel> _places = [];
//   List<PlaceModel> get places => _places;

//   // Holds the filtered places based on search query
//   List<PlaceModel> get filteredPlaces {
//     if (_searchTerm.isEmpty) {
//       return _places;
//     } else {
//       return _places.where((place) {
//         final searchLower = _searchTerm.toLowerCase();
//         final activities = place.activities.toLowerCase().split(', ');

//         return place.name.toLowerCase().contains(searchLower) ||
//             place.country.toLowerCase().contains(searchLower) ||
//             place.continent.toLowerCase().contains(searchLower) ||
//             activities.any((activity) => activity.contains(searchLower));
//       }).toList();
//     }
//   }

//   // Holds locations filtered by interest/activity


//   // Search term for filtering places
//   String _searchTerm = '';
//   String get searchTerm => _searchTerm;

//   // Controller for search input
//   TextEditingController searchController = TextEditingController();

//   // Holds the current index for any UI interaction (e.g., tab switching)


//   // Constructor to fetch all locations when the provider is initialized
//   LocationProvider() {
//     fetchAllLocations();
//   }

//   // Fetch all locations from Firestore
//   void fetchAllLocations() {
//     db.collection('places').snapshots().listen((snapshot) {
//       _places = snapshot.docs
//           .map((doc) => PlaceModel.fromMap(doc.data()))
//           .toList();
//       notifyListeners();
//     });
//   }

//   // Update the search term and notify listeners to refresh the filtered results
//   void updateSearchTerm(String term) {
//     _searchTerm = term;
//     notifyListeners();
//   }

//   // Fetch locations based on interest/activity field
 

//   // Update the current index for UI interactions

// }


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';

import '../../model/place_model.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

    List<PlaceModel> _locationsByInterest = [];
  List<PlaceModel> get locationsByInterest => _locationsByInterest;

    int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final SearchProvider searchProvider;  // Reference to SearchProvider
  final TripPackageProvider tripPackageProvider;  // Reference to TripPackageProvider

  LocationProvider(this.searchProvider, this.tripPackageProvider) {
    fetchAllLocations();
  }

  void fetchAllLocations() {
    db.collection('places').snapshots().listen((snapshot) {
      _places = snapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data()))
          .toList();

      // Fetch packages from trip package provider
      final packages = tripPackageProvider.package;

      // Perform combined search
      searchProvider.searchCombined(packages, _places);
      notifyListeners();
    });
  }

  // void getLocationsByInterest(String interest) {
  //   db.collection('places')
  //       .where('activities', isEqualTo: interest)
  //       .get()
  //       .then((snapshot) {
  //         final locationsByInterest = snapshot.docs
  //             .map((doc) => PlaceModel.fromMap(doc.data()))
  //             .toList();

  //         // Fetch packages based on interest from trip package provider
  //         final packagesByInterest = tripPackageProvider.packageByInterest;

  //         // Perform combined search by interest
  //         searchProvider.searchCombined(packagesByInterest, locationsByInterest);
  //         notifyListeners();
  //       }).catchError((e) {
  //         log('Error fetching locations by interest: $e');
  //       });
  // }

   void getLocationsByInterest(String interest) {
    db.collection('places')
        .where('activities', isEqualTo: interest)
        .get()
        .then((snapshot) {
      _locationsByInterest = snapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data()))
          .toList();
      notifyListeners();
    }).catchError((e) {
      print('Error fetching locations by interest: $e');
    });
  }

    void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
