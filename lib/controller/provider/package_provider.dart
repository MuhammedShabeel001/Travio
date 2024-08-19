// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../model/package_model.dart';

// class TripPackageProvider with ChangeNotifier {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   List<TripPackageModel> _package = [];
//   List<TripPackageModel> get package => _package;

//   List<TripPackageModel> _filteredPackages = [];
//   List<TripPackageModel> get filteredPackages => _filteredPackages;

//   List<TripPackageModel> _packageByInterest = [];
//   List<TripPackageModel> get packageByInterest => _packageByInterest;

//   String _searchTerm = '';
//   String get searchTerm => _searchTerm;

//   TextEditingController searchController = TextEditingController();

//   TripPackageProvider() {
//     fetchAllPackages();
//   }

//   Future<void> fetchAllPackages() async {
//     try {
//       QuerySnapshot tripPackageSnapshot = await db.collection('trip_packages').get();
//       _package = tripPackageSnapshot.docs
//           .map((doc) => TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();

//       _filteredPackages = _package;  // Initially, all packages are displayed
//       notifyListeners();
//     } catch (e) {
//       log('Error fetching package data: $e');
//     }
//   }

//   void updateSearchTerm(String term) {
//     _searchTerm = term.toLowerCase();
//     _filteredPackages = _package.where((package) {
//       final nameLower = package.name.toLowerCase();
//       final activitiesLower = package.activities.map((activity) => activity.toLowerCase()).toList();

//       return nameLower.contains(_searchTerm) ||
//           activitiesLower.any((activity) => activity.contains(_searchTerm));
//     }).toList();

//     notifyListeners();  // Notify listeners to update the UI
//   }

//   void getPackagesByInterest(String interest) {
//     db.collection('trip_packages')
//         .where('activities', arrayContains: interest)
//         .get()
//         .then((snapshot) {
//           _packageByInterest = snapshot.docs
//               .map((doc) => TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
//               .toList();
//           notifyListeners();
//         }).catchError((e) {
//           log('Error fetching packages by interest: $e');
//         });
//   }
// }



import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/package_model.dart';

class TripPackageProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  List<TripPackageModel> _packageByInterest = [];
  List<TripPackageModel> get packageByInterest => _packageByInterest;

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  TextEditingController searchController = TextEditingController();

  TripPackageProvider() {
    fetchAllPackages();
  }

  Future<void> fetchAllPackages() async {
    try {
      QuerySnapshot tripPackageSnapshot = await db.collection('trip_packages').get();
      _package = tripPackageSnapshot.docs
          .map((doc) => TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredPackages = _package;  // Initially, all packages are displayed
      notifyListeners();
    } catch (e) {
      log('Error fetching package data: $e');
    }
  }

  void updateSearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    _filteredPackages = _package.where((package) {
      final nameLower = package.name.toLowerCase();
      final activitiesLower = package.activities.map((activity) => activity.toLowerCase()).toList();

      return nameLower.contains(_searchTerm) ||
          activitiesLower.any((activity) => activity.contains(_searchTerm));
    }).toList();

    notifyListeners();  // Notify listeners to update the UI
  }

  void getPackagesByInterest(String interest) {
    db.collection('trip_packages')
        .where('activities', arrayContains: interest)
        .get()
        .then((snapshot) {
          _packageByInterest = snapshot.docs
              .map((doc) => TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
          notifyListeners();
        }).catchError((e) {
          log('Error fetching packages by interest: $e');
        });
  }
}
