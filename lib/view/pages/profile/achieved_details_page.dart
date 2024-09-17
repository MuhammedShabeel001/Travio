import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/review_provider.dart';

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
    final String packageId = packageData['id'];
    final int numberOfPeople = archivedPackage['numberOfPeople'] ?? 1;
    final double totalAmount = packageData['offer_price'] * numberOfPeople;
    final String shortNote =
        archivedPackage['shortNote'] ?? 'No additional notes about the trip.';
    final user = FirebaseAuth.instance.currentUser;

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
            // Package details
            Text(
              packageData['name'] ?? 'Package Name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

            // Add Review Section
            if (user != null) _buildAddReviewSection(context, packageId, user),
          ],
        ),
      ),
    );
  }

  Widget _buildAddReviewSection(BuildContext context, String packageId, User user) {
    double rating = 3.0;
    final TextEditingController reviewController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Leave a Review',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (newRating) {
            rating = newRating;
          },
        ),
        const SizedBox(height: 8),
        TextField(
          controller: reviewController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Write a review',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            Provider.of<ReviewProvider>(context, listen: false).submitReview(
              packageId: packageId,
              userId: user.uid,
              rating: rating,
              reviewText: reviewController.text,
            );
            reviewController.clear();
          },
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}
