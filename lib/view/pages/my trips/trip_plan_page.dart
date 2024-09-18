import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../controller/provider/auth_provider.dart';
import '../../../controller/provider/payment_provider.dart';
import '../../../core/theme/theme.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? userId = authProvider.user?.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentProvider>(context, listen: false).moveExpiredBookingsToArchive();
    });

    return Scaffold(
      backgroundColor: TTthemeClass().ttSecondary,
      appBar: AppBar(
        title: Text('Itinerary',
        style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: TTthemeClass().ttLightText,
              ),),
        backgroundColor: TTthemeClass().ttLightPrimary,
      ),
      body: _buildTripPlanContent(context, userId),
    );
  }

  Widget _buildTripPlanContent(BuildContext context, String? userId) {
    return SizedBox.expand(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookedPackages')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerEffect();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final bookedPackage = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final packageId = bookedPackage['packageId'] as String?;
          
              if (packageId == null || packageId.isEmpty) {
                return const ListTile(title: Text('Invalid package ID.'));
              }
          
              return 
              // _buildEmptyState();
              _buildPackageCard(context, bookedPackage, packageId);
            },
          );
        },
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, Map<String, dynamic> bookedPackage, String packageId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('trip_packages').doc(packageId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
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

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SizedBox(
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/Empty_ticket.json', 
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            'No trip plans found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TTthemeClass().ttLightText),
          ),
          const SizedBox(height: 10),
          Text(
            'Book a package to start planning your trip!',
            style: TextStyle(fontSize: 14, color: TTthemeClass().ttThird),
          ),
        ],
      ),
    );
  }
}
