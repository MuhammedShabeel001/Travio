import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/place_model.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  LocationProvider() {
    _fetchIndianLocations();
  }

  void _fetchIndianLocations() {
    db.collection('places').where('country', isEqualTo: 'India').snapshots().listen((snapshot) {
      _places = snapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data()))
          .toList();
      notifyListeners();
    });
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
