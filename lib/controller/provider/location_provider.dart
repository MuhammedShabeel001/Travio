import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/place_model.dart';

class LocationProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<PlaceModel> _places = [];
  List<PlaceModel> get places => _places;

  List<PlaceModel> _locationsByInterest = [];
  List<PlaceModel> get locationsByInterest => _locationsByInterest;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  LocationProvider() {
    _fetchIndianLocations();
  }

  // Fetch all Indian locations from Firestore
  void _fetchIndianLocations() {
    db.collection('places').where('country', isEqualTo: 'India').snapshots().listen((snapshot) {
      _places = snapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data()))
          .toList();
      notifyListeners();
    });
  }

  // Fetch locations based on interest/activity field
  void getLocationsByInterest(String interest) {
    db.collection('places').where('activities', isEqualTo: interest).get().then((snapshot) {
      _locationsByInterest = snapshot.docs
          .map((doc) => PlaceModel.fromMap(doc.data()))
          .toList();
      notifyListeners();
    }).catchError((e) {
      // Handle error if needed
      print('Error fetching locations by interest: $e');
    });
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
