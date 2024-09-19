import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/package_model.dart';
import '../../model/review_model.dart';

class TripPackageProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> _filteredPackages = [];
  List<TripPackageModel> _filteredBookedPackages = [];
  List<TripPackageModel> _filteredAchievedPackages = [];
  List<TripPackageModel> _filteredReviewPackages = [];
  List<TripPackageModel> _packageByInterest = [];
  String _searchTerm = '';

  List<TripPackageModel> get package => _package;
  List<TripPackageModel> get filteredPackages => _filteredPackages;
  List<TripPackageModel> get filteredBookedPackages => _filteredBookedPackages;
  List<TripPackageModel> get filteredAchievedPackages => _filteredAchievedPackages;
  List<TripPackageModel> get filteredReviewPackages => _filteredReviewPackages;
  List<TripPackageModel> get packageByInterest => _packageByInterest;
  String get searchTerm => _searchTerm;

  TextEditingController searchController = TextEditingController();

  /// Initializes data by fetching all packages, most booked, and top reviewed packages.
  Future<void> initializeData() async {
    await Future.wait([
      fetchAllPackages(),
      fetchMostBookedPackages(),
      fetchTopReviewedPackages()
    ]);
  }

  /// Fetches all trip packages from Firestore.
  Future<void> fetchAllPackages() async {
    try {
      final QuerySnapshot tripPackageSnapshot =
          await db.collection('trip_packages').get();
      _package = tripPackageSnapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      _filteredPackages = _package;
      notifyListeners();
    } catch (e) {
      log('Error fetching all packages: $e');
    }
  }

  /// Fetches packages booked by a user.
  Future<void> fetchBookedPackagesByUser(String userId) async {
    await _fetchPackagesByUser('bookedPackages', userId, (packages) {
      _filteredBookedPackages = packages;
    });
  }

  /// Fetches packages achieved (archived) by a user.
  Future<void> fetchAchievedPackagesByUser(String userId) async {
    await _fetchPackagesByUser('archivedPackages', userId, (packages) {
      _filteredAchievedPackages = packages;
    });
  }

  /// Generic method to fetch packages by user from a specific collection.
  Future<void> _fetchPackagesByUser(String collection, String userId,
      Function(List<TripPackageModel>) callback) async {
    try {
      final QuerySnapshot snapshot = await db
          .collection(collection)
          .where('userId', isEqualTo: userId)
          .get();

      final List<TripPackageModel> packages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      callback(packages);
      notifyListeners();
    } catch (e) {
      log('Error fetching packages for user: $e');
    }
  }

  /// Fetches reviews for a specific package.
  Future<void> fetchPackageReviews(String packageId) async {
    try {
      final QuerySnapshot reviewsSnapshot = await db
          .collection('trip_packages')
          .doc(packageId)
          .collection('reviews')
          .orderBy('timestamp', descending: true)
          .get();

      final List<ReviewModel> reviews = reviewsSnapshot.docs.map((doc) {
        return ReviewModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      final index = _package.indexWhere((pkg) => pkg.id == packageId);
      if (index != -1) {
        _package[index] = _package[index].copyWith(reviews: reviews);
        notifyListeners();
      }
    } catch (e) {
      log('Error fetching package reviews: $e');
    }
  }

  /// Fetches the most booked packages.
  Future<void> fetchMostBookedPackages({int limit = 2}) async {
    await _fetchPackages('booked_count', limit, (packages) {
      _filteredBookedPackages = packages;
    });
  }

  /// Fetches the top reviewed packages.
  Future<void> fetchTopReviewedPackages({int limit = 1}) async {
    await _fetchPackages('customer_reviews', limit, (packages) {
      _filteredReviewPackages = packages;
    });
  }

  /// Generic method to fetch packages based on a field and limit.
  Future<void> _fetchPackages(String orderByField, int limit,
      Function(List<TripPackageModel>) callback) async {
    try {
      final QuerySnapshot snapshot = await db
          .collection('trip_packages')
          .orderBy(orderByField, descending: true)
          .where(orderByField, isGreaterThan: 0)
          .limit(limit)
          .get();

      final List<TripPackageModel> packages = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      callback(packages);
      notifyListeners();
    } catch (e) {
      log('Error fetching packages: $e');
    }
  }

  /// Updates the search term and filters packages accordingly.
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

  /// Fetches packages by a specific interest.
  void getPackagesByInterest(String interest) async {
    try {
      final QuerySnapshot snapshot = await db
          .collection('trip_packages')
          .where('activities', arrayContains: interest)
          .get();

      _packageByInterest = snapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      log('Error fetching packages by interest: $e');
    }
  }
}
