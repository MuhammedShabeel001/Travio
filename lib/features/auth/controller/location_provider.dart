import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/features/auth/models/place_model.dart';
// import 'package:your_project/models/place_model.dart'; // Replace with your actual file path

class LocationProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

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
}
