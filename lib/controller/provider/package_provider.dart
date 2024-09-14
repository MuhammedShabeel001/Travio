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
  List<TripPackageModel> _filteredBookedPackages = [];
  List<TripPackageModel> get filteredBookedPackages => _filteredBookedPackages;
  List<TripPackageModel> _filteredachievedPackages = [];
  List<TripPackageModel> get filteredachievedPackages =>
      _filteredachievedPackages;
  List<TripPackageModel> _filteredReviewPackages = [];
  List<TripPackageModel> get filteredReviewPackages => _filteredReviewPackages;

  List<TripPackageModel> _packageByInterest = [];
  List<TripPackageModel> get packageByInterest => _packageByInterest;

  final Set<String> _likedPackages = {};
  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  TextEditingController searchController = TextEditingController();

  Future<void> initializeData() async {
    await fetchAllPackages();
    await fetchMostBookedPackages();
    await fetchTopReviewedPackages();
  }

  Future<void> fetchAllPackages() async {
    try {
      QuerySnapshot tripPackageSnapshot =
          await db.collection('trip_packages').get();
      _package = tripPackageSnapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredPackages = _package;
      notifyListeners();
    } catch (e) {
      log('Error fetching package data: $e');
    }
  }

  Future<void> fetchBookedPackagesByUser(String userId) async {
    try {
      QuerySnapshot snapshot = await db
          .collection('bookedPackages')
          .where('userId', isEqualTo: userId)
          .get();

      List<TripPackageModel> bookedPackages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredBookedPackages = bookedPackages;
      notifyListeners();
    } catch (e) {
      log('Error fetching booked packages for user: $e');
    }
  }

  Future<void> fetchAchievedPackagesByUser(String userId) async {
    try {
      QuerySnapshot snapshot = await db
          .collection('archivedPackages')
          .where('userId', isEqualTo: userId)
          .get();

      List<TripPackageModel> bookedPackages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredachievedPackages = bookedPackages;
      notifyListeners();
    } catch (e) {
      log('Error fetching achieved packages for user: $e');
    }
  }

  Future<void> fetchMostBookedPackages({int limit = 2}) async {
    try {
      QuerySnapshot snapshot = await db
          .collection('trip_packages')
          .orderBy('booked_count', descending: true)
          .where('booked_count', isGreaterThan: 0)
          .limit(limit)
          .get();

      List<TripPackageModel> mostBookedPackages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredBookedPackages = mostBookedPackages;
      notifyListeners();
    } catch (e) {
      log('Error fetching most booked packages: $e');
    }
  }

  Future<void> fetchTopReviewedPackages({int limit = 1}) async {
    try {
      QuerySnapshot snapshot = await db
          .collection('trip_packages')
          .orderBy('customer_reviews', descending: true)
          .limit(limit)
          .get();

      List<TripPackageModel> topReviewedPackages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _filteredReviewPackages = topReviewedPackages;
      notifyListeners();
    } catch (e) {
      log('Error fetching top reviewed packages: $e');
    }
  }

  void updateSearchTerm(String term) {
    _searchTerm = term.toLowerCase();
    _filteredPackages = _package.where((package) {
      final nameLower = package.name.toLowerCase();
      final activitiesLower =
          package.activities.map((activity) => activity.toLowerCase()).toList();

      return nameLower.contains(_searchTerm) ||
          activitiesLower.any((activity) => activity.contains(_searchTerm));
    }).toList();

    notifyListeners();
  }

  void getPackagesByInterest(String interest) {
    db
        .collection('trip_packages')
        .where('activities', arrayContains: interest)
        .get()
        .then((snapshot) {
      _packageByInterest = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }).catchError((e) {
      log('Error fetching packages by interest: $e');
    });
  }

  bool isLiked(String packageId) {
    return _likedPackages.contains(packageId);
  }

  Future<void> toggleLike(String packageId) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      log('No user is currently signed in.');
      return;
    }

    DocumentReference packageRef =
        db.collection('trip_packages').doc(packageId);
    DocumentReference userRef = db.collection('users').doc(currentUser.uid);

    try {
      DocumentSnapshot packageSnapshot = await packageRef.get();
      List<String> likedByUserIds =
          List<String>.from(packageSnapshot.get('liked_by_user_ids') ?? []);

      bool hasLiked = likedByUserIds.contains(currentUser.uid);

      if (hasLiked) {
        likedByUserIds.remove(currentUser.uid);
      } else {
        likedByUserIds.add(currentUser.uid);
      }

      await packageRef.update({
        'liked_by_user_ids': likedByUserIds,
        'like_count': likedByUserIds.length,
      });

      if (hasLiked) {
        _likedPackages.remove(packageId);
      } else {
        _likedPackages.add(packageId);
      }

      DocumentSnapshot userSnapshot = await userRef.get();
      List<String> likedPackages =
          List<String>.from(userSnapshot.get('likedPackages') ?? []);

      if (hasLiked) {
        likedPackages.remove(packageId);
      } else {
        likedPackages.add(packageId);
      }

      await userRef.update({
        'likedPackages': likedPackages,
      });

      notifyListeners();
    } catch (e) {
      log('Error toggling like status: $e');
    }
  }
}
