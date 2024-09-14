import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/model/user_model.dart'; // Ensure this path is correct
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/view/widgets/global/appbar.dart';

import '../../../controller/provider/payment_provider.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access AuthProvider to get the userId
    final authProvider = Provider.of<AuthProvider>(context);
    final String? userId = authProvider.user?.id; 
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the moveExpiredBookingsToArchive function here
      Provider.of<PaymentProvider>(context, listen: false).moveExpiredBookingsToArchive();

    });// or however you get the userId

    return Scaffold(
      body: ttAppBar(
        context,
        'Plan trip',
        addTripCenter(context, userId),
      ),
    );
  }

  Widget addTripCenter(BuildContext context, String? userId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('bookedPackages')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        debugPrint('Query Snapshot Data: ${snapshot.data?.docs}');

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final bookedPackage =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              final packageId = bookedPackage['packageId'] as String?;

              if (packageId == null || packageId.isEmpty) {
                return const ListTile(
                  title: Text('Invalid package ID.'),
                );
              }

              // Fetch complete package details by packageId
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('trip_packages')
                    .doc(packageId)
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> packageSnapshot) {
                  if (packageSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (packageSnapshot.hasData && packageSnapshot.data!.exists) {
                    final packageData =
                        packageSnapshot.data!.data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(packageData['name'] ?? 'Package Name'),
                      subtitle: Text(
                          'Dates: ${bookedPackage['startDate']} - ${bookedPackage['endDate']}'),
                      trailing: Text('Price: ₹${packageData['offerPrice']}'),
                    );
                  } else {
                    return const ListTile(
                      title: Text('Package details not found.'),
                    );
                  }
                },
              );
            },
          );
        } else {
          return const Center(child: Text('No booked packages found.'));
        }
      },
    );
  }
}
