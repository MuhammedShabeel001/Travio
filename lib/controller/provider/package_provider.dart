import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/package_model.dart';

class TripPackageProvider extends ChangeNotifier{

  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<TripPackageModel> _package = [];
  List<TripPackageModel> get package => _package;

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
}