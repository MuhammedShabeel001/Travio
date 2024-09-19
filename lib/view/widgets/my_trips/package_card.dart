import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:travio/view/widgets/my_trips/shimmer_effect.dart';

import '../../../core/theme/theme.dart';

class ItinararyPackageCard extends StatelessWidget {
  final Map<String, dynamic> bookedPackage;
  final String packageId;

  const ItinararyPackageCard({
    super.key,
    required this.bookedPackage,
    required this.packageId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('trip_packages').doc(packageId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerEffect(); // Replace with shimmer effect if needed
        }

        if (snapshot.hasError) {
          return ListTile(title: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const ListTile(title: Text('Package details not found.'));
        }

        final packageData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final Timestamp? startTimestamp = bookedPackage['startDate'] as Timestamp?;
        final Timestamp? endTimestamp = bookedPackage['endDate'] as Timestamp?;
        final String formattedStartDate = startTimestamp != null
            ? DateFormat('dd MMM yyyy').format(startTimestamp.toDate())
            : 'N/A';
        final String formattedEndDate = endTimestamp != null
            ? DateFormat('dd MMM yyyy').format(endTimestamp.toDate())
            : 'N/A';

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  packageData['images']?[0] ?? 'https://via.placeholder.com/300x150',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Text('Image not available')),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            packageData['name'] ?? 'Package Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: TTthemeClass().ttLightText,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          (packageData['locations'] as List?)?.take(3).join(', ') ?? 'No info',
                          style: TextStyle(color: TTthemeClass().ttThird),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: TTthemeClass().ttThird, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '$formattedStartDate - $formattedEndDate',
                          style: TextStyle(color: TTthemeClass().ttThird),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${packageData['offer_price'] ?? 'N/A'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: TTthemeClass().ttDardPrimary,
                          ),
                        ),
                        Text(
                          '${packageData['total_number_of_days'] ?? 'N/A'} Days',
                          style: TextStyle(color: TTthemeClass().ttThird),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Includes: ${(packageData['activities'] as List?)?.take(3).join(', ') ?? 'No info'}',
                      style: TextStyle(color: TTthemeClass().ttThird, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
