// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../model/package_model.dart';
// import '../../model/user_model.dart';

// class TripPackageProvider with ChangeNotifier {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   List<TripPackageModel> _package = [];
//   List<TripPackageModel> get package => _package;

//   List<TripPackageModel> _filteredPackages = [];
//   List<TripPackageModel> get filteredPackages => _filteredPackages;

//   List<TripPackageModel> _packageByInterest = [];
//   List<TripPackageModel> get packageByInterest => _packageByInterest;

//   Set<String> _likedPackages = {}; // Set to store liked package IDs
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

//   Future<void> getPackageById(String packageId) async {
//     try {
//       DocumentSnapshot packageSnapshot = await db.collection('trip_packages').doc(packageId).get();
//       if (packageSnapshot.exists) {
//         var package = TripPackageModel.fromMap(packageSnapshot.data() as Map<String, dynamic>);
//         // You may need to update a state variable here if required
//         // For example, you might use _selectedPackage
//       }
//     } catch (e) {
//       log('Error fetching package by ID: $e');
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

//   bool isLiked(String packageId) {
//     return _likedPackages.contains(packageId);
//   }

//   // Toggle like status and update the like count in Firestore
//   Future<void> toggleLike(String packageId) async {
//     final User? currentUser = _auth.currentUser;
//     if (currentUser == null) {
//       log('No user is currently signed in.');
//       return;
//     }

//     // Reference to the package and user documents
//     DocumentReference packageRef = db.collection('trip_packages').doc(packageId);
//     DocumentReference userRef = db.collection('users').doc(currentUser.uid);

//     try {
//       // Get current package data
//       DocumentSnapshot packageSnapshot = await packageRef.get();
//       List<String> likedByUserIds = List<String>.from(packageSnapshot.get('liked_by_user_ids') ?? []);

//       // Check if the user has already liked the package
//       bool hasLiked = likedByUserIds.contains(currentUser.uid);

//       if (hasLiked) {
//         // Remove user's ID from the list
//         likedByUserIds.remove(currentUser.uid);
//       } else {
//         // Add user's ID to the list
//         likedByUserIds.add(currentUser.uid);
//       }

//       // Update package document
//       await packageRef.update({
//         'liked_by_user_ids': likedByUserIds,
//         'like_count': likedByUserIds.length,
//       });

//       // Update local liked packages set
//       if (hasLiked) {
//         _likedPackages.remove(packageId);
//       } else {
//         _likedPackages.add(packageId);
//       }

//       // Get current user data
//       DocumentSnapshot userSnapshot = await userRef.get();
//       List<String> likedPackages = List<String>.from(userSnapshot.get('likedPackages') ?? []);

//       if (hasLiked) {
//         // Remove package ID from user's liked packages
//         likedPackages.remove(packageId);
//       } else {
//         // Add package ID to user's liked packages
//         likedPackages.add(packageId);
//       }

//       // Update user document
//       await userRef.update({
//         'likedPackages': likedPackages,
//       });

//       notifyListeners(); // Notify listeners to update the UI

//     } catch (e) {
//       log('Error toggling like status: $e');
//     }
//   }
// }


import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/package_model.dart';

class TripPackageProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> get filteredPackages => _filteredPackages;

  List<TripPackageModel> _packageByInterest = [];
  List<TripPackageModel> get packageByInterest => _packageByInterest;

  Set<String> _likedPackages = {}; // Set to store liked package IDs
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

  Future<void> getPackageById(String packageId) async {
    try {
      DocumentSnapshot packageSnapshot = await db.collection('trip_packages').doc(packageId).get();
      if (packageSnapshot.exists) {
        var package = TripPackageModel.fromMap(packageSnapshot.data() as Map<String, dynamic>);
        // You may need to update a state variable here if required
        // For example, you might use _selectedPackage
      }
    } catch (e) {
      log('Error fetching package by ID: $e');
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

  bool isLiked(String packageId) {
    return _likedPackages.contains(packageId);
  }

  // Toggle like status and update the like count in Firestore
Future<void> toggleLike(String packageId) async {
  final User? currentUser = _auth.currentUser;
  if (currentUser == null) {
    log('No user is currently signed in.');
    return;
  }

  // Reference to the package and user documents
  DocumentReference packageRef = db.collection('trip_packages').doc(packageId);
  DocumentReference userRef = db.collection('users').doc(currentUser.uid);

  try {
    // Get current package data
    DocumentSnapshot packageSnapshot = await packageRef.get();
    List<String> likedByUserIds = List<String>.from(packageSnapshot.get('liked_by_user_ids') ?? []);

    // Check if the user has already liked the package
    bool hasLiked = likedByUserIds.contains(currentUser.uid);

    if (hasLiked) {
      // Remove user's ID from the list
      likedByUserIds.remove(currentUser.uid);
    } else {
      // Add user's ID to the list
      likedByUserIds.add(currentUser.uid);
    }

    // Update package document
    await packageRef.update({
      'liked_by_user_ids': likedByUserIds,
      'like_count': likedByUserIds.length,
    });

    // Update local liked packages set
    if (hasLiked) {
      _likedPackages.remove(packageId);
    } else {
      _likedPackages.add(packageId);
    }

    // Get current user data
    DocumentSnapshot userSnapshot = await userRef.get();
    List<String> likedPackages = List<String>.from(userSnapshot.get('likedPackages') ?? []);

    if (hasLiked) {
      // Remove package ID from user's liked packages
      likedPackages.remove(packageId);
    } else {
      // Add package ID to user's liked packages
      likedPackages.add(packageId);
    }

    // Update user document
    await userRef.update({
      'likedPackages': likedPackages,
    });

    notifyListeners(); // Notify listeners to update the UI

  } catch (e) {
    log('Error toggling like status: $e');
  }
}

}
