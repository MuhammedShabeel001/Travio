import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/payment_provider.dart';

class PackageDetailPage extends StatelessWidget {
  final Map<String, dynamic> packageData;
  final Map<String, dynamic> archivedPackage;

  const PackageDetailPage({
    required this.packageData,
    required this.archivedPackage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int numberOfPeople = archivedPackage['numberOfPeople'] ?? 1;
    final double totalAmount = packageData['offer_price'] * numberOfPeople;
    final String shortNote =
        archivedPackage['shortNote'] ?? 'No additional notes about the trip.';

    final DateTime startDate =
        (archivedPackage['startDate'] as Timestamp).toDate();
    final DateTime endDate = (archivedPackage['endDate'] as Timestamp).toDate();
    final String formattedStartDate =
        DateFormat('dd MMM yyyy').format(startDate);
    final String formattedEndDate = DateFormat('dd MMM yyyy').format(endDate);
    final String packageId = packageData['id'];
    log(packageId);
    return Scaffold(
      appBar: AppBar(
        title: Text(packageData['name'] ?? 'Package Detail'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              packageData['name'] ?? 'Package Name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Dates: $formattedStartDate - $formattedEndDate',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Price per Person: ₹${packageData['offer_price']}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.green),
            ),
            Text(
              'Total Amount: ₹$totalAmount',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Text(
              'Number of People: $numberOfPeople',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              'Description: ${packageData['description'] ?? 'No description available'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
