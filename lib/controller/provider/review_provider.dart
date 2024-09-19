import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/review_model.dart';

/// Provider for managing reviews associated with trip packages.
class ReviewProvider with ChangeNotifier {
  List<ReviewModel> reviews = [];

  /// Fetches reviews for a given package ID from Firestore.
  Future<void> fetchReviews(String packageId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('trip_packages')
          .doc(packageId)
          .collection('reviews')
          .get();

      reviews = await Future.wait(snapshot.docs.map((doc) async {
        final data = doc.data();
        final userId = data['userId'] as String;

        // Fetch user data from users collection
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        final userData = userDoc.data() as Map<String, dynamic>;

        return ReviewModel.fromMap(
          {
            ...data,
            'userName': userData['name'], 
          },
          doc.id,
        );
      }).toList());

      notifyListeners();
    } catch (e) {
      log('Error fetching reviews: $e');
    }
  }

  /// Submits a new review to Firestore and adds it to the local list.
  Future<void> submitReview({
    required String packageId,
    required String userId,
    required double rating,
    required String reviewText,
  }) async {
    try {
      // Fetch user data from the 'users' collection
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;

      // Prepare review data
      final reviewData = {
        'userId': userId,
        'rating': rating,
        'reviewText': reviewText,
        'timestamp': FieldValue.serverTimestamp(),
        'userName': userData['name'],
      };

      // Add the review to Firestore
      final docRef = await FirebaseFirestore.instance
          .collection('trip_packages')
          .doc(packageId)
          .collection('reviews')
          .add(reviewData);

      // Fetch the newly created review document from Firestore
      final newReview = ReviewModel.fromMap(
        await docRef.get().then((doc) => doc.data() as Map<String, dynamic>),
        docRef.id,
      );

      // Add the new review to the local list and notify listeners
      reviews.add(newReview);
      notifyListeners();
    } catch (e) {
      log('Error submitting review: $e');
    }
  }
}
