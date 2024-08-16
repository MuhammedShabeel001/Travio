import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travio/model/package_model.dart';

class TripPackageProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

  List<TripPackageModel> _packageByInterest = [];
  List<TripPackageModel> get packageByInterest => _packageByInterest;

  // Fetch all packages
  Future<void> fetchAllPackages() async {
    try {
      QuerySnapshot tripPackageSnapshot =
          await db.collection('trip_packages').get();
      _package = tripPackageSnapshot.docs
          .map((doc) =>
              TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error fetching package data: $e');
      BotToast.showText(text: 'Error fetching package data');
    }
  }

  // Fetch packages by interest/activity field
  void getPackagesByInterest(String interest) {
  db
      .collection('trip_packages')
      .where('activities', arrayContains: interest) // Use arrayContains to check within the list
      .get()
      .then((snapshot) {
    _packageByInterest = snapshot.docs
        .map((doc) =>
            TripPackageModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }).catchError((e) {
    // Handle error if needed
    print('Error fetching packages by interest: $e');
  });
}
}
