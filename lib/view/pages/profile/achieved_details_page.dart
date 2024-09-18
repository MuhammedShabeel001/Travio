import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/model/package_model.dart';
import 'package:travio/view/pages/home/package/package_detail_page.dart';

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
    final int numberOfPeople = archivedPackage['numberOfPeople'] ?? 1;
    final double totalAmount = packageData['offer_price'] * numberOfPeople;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TripPackageDetailPage(
                      tripPackage: TripPackageModel.fromMap(packageData),
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/icons/navigate.svg',
                color: const Color.fromARGB(255, 255, 255, 255),
                height: 15,
              ))
        ],
        automaticallyImplyLeading: false,
        title: Text(
          packageData['name'] ?? 'Package Detail',
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: TTthemeClass().ttThird,
      ),
      body: Column(
        children: [
          // Flexible part for package details
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPackageHeader(),
                    const SizedBox(height: 16),
                    _buildPackagePricingInfo(totalAmount, numberOfPeople),
                    const SizedBox(height: 16),
                    _buildPackageDetails(),
                    const SizedBox(height: 16),
                    _buildPackagePlan(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Add Review button fixed at the bottom
          if (user != null) _buildAddReviewButton(context),
        ],
      ),
    );
  }

  // Package header section with image, name, and a brief description
  Widget _buildPackageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(
                packageData['images'] != null && packageData['images'].isNotEmpty
                    ? packageData['images'][0]
                    : 'https://via.placeholder.com/200',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          packageData['name'] ?? 'Package Name',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          packageData['description'] ?? 'No description available.',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Package price information
  Widget _buildPackagePricingInfo(double totalAmount, int numberOfPeople) {
    double pricePerPerson = packageData['offer_price'];
    double gstPerPerson = pricePerPerson * 0.06; // 6% GST
    double totalWithGst = totalAmount + (gstPerPerson * numberOfPeople);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPriceInfo('Price per Person', '₹${pricePerPerson.toStringAsFixed(2)}'),
            _buildPriceInfo('Total Amount', '₹${totalWithGst.toStringAsFixed(2)}'),
            _buildPriceInfo('Number of People', '$numberOfPeople'),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Package detail section
  Widget _buildPackageDetails() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, 'Number of Days',
                packageData['total_number_of_days']?.toString() ?? 'N/A'),
            const Divider(),
            _buildDetailRow(Icons.place, 'Destination',
                _formatDestinationList(packageData['locations'])),
          ],
        ),
      ),
    );
  }

  String _formatDestinationList(dynamic locations) {
    if (locations is List && locations.isNotEmpty) {
      return locations.join(', ');
    } else {
      return 'Unknown';
    }
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  // Package plan section
  Widget _buildPackagePlan() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trip Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            packageData['daily_plan'] != null && packageData['daily_plan'] is Map
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildPlanItems(packageData['daily_plan']),
                  )
                : const Text(
                    'No detailed plan available for this package.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlanItems(Map<String, dynamic> plan) {
    return plan.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.key}: ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            Expanded(
              child: Text(
                entry.value.toString(),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // Add Review button
  Widget _buildAddReviewButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showReviewBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TTthemeClass().ttThird,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Add Review',
          style: TextStyle(fontSize: 20, color: TTthemeClass().ttLightPrimary),
        ),
      ),
    );
  }
  void _showReviewBottomSheet(BuildContext context) {
  double rating = 3.0;
  final TextEditingController reviewController = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              onPressed: () async {
                try {
                  await Provider.of<ReviewProvider>(context, listen: false).submitReview(
                    packageId: packageData['id'],
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    rating: rating,
                    reviewText: reviewController.text,
                  );
                  reviewController.clear();
                  Navigator.pop(context); // Close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Review submitted successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to submit review. Please try again.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TTthemeClass().ttThird,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 20,
                  color: TTthemeClass().ttLightPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
}