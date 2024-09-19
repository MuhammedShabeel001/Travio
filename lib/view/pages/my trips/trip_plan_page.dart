import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:travio/view/widgets/my_trips/package_card.dart';

import '../../../controller/provider/auth_provider.dart';
import '../../../controller/provider/payment_provider.dart';
import '../../../core/theme/theme.dart';
import '../../widgets/my_trips/empty_state.dart';
import '../../widgets/my_trips/shimmer_effect.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

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
        title: Text(
          'Itinerary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: TTthemeClass().ttLightText,
          ),
        ),
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
            return const ShimmerEffect();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const EmptyState();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final bookedPackage = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final packageId = bookedPackage['packageId'] as String?;

              if (packageId == null || packageId.isEmpty) {
                return const ListTile(title: Text('Invalid package ID.'));
              }

              return ItinararyPackageCard(
                bookedPackage: bookedPackage,
                packageId: packageId,
              );
            },
          );
        },
      ),
    );
  }
}
