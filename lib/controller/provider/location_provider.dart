// import 'dart:developer';

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

  final SearchProvider searchProvider;
  final TripPackageProvider tripPackageProvider;

  LocationProvider(this.searchProvider, this.tripPackageProvider) {
    fetchAllLocations();
  }

  void fetchAllLocations() {
    db.collection('places').snapshots().listen((snapshot) {
      _places =
          snapshot.docs.map((doc) => PlaceModel.fromMap(doc.data())).toList();

      final packages = tripPackageProvider.package;

      searchProvider.applyFilters(packages, _places);
      notifyListeners();
    });
  }

  void getLocationsByInterest(String interest) {
    db
        .collection('places')
        .where('activities', isEqualTo: interest)
        .get()
        .then((snapshot) {
      _locationsByInterest =
          snapshot.docs.map((doc) => PlaceModel.fromMap(doc.data())).toList();
      notifyListeners();
    }).catchError((e) {
      // print('Error fetching locations by interest: $e');
    });
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
