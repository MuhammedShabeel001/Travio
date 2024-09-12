import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import '../../../controller/provider/auth_provider.dart';

class BookedPackagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.user?.id;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Booked Packages')),
        body: const Center(child: Text('User not logged in.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Booked Packages')),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('bookedPackages')
            .where('userId', isEqualTo: userId)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
         
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final bookedPackage = snapshot.data!.docs[index].data() as Map<String, dynamic>;
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
                

                    if (packageSnapshot.hasData && packageSnapshot.data!.exists) {
                      final packageData = packageSnapshot.data!.data() as Map<String, dynamic>;

                      // Convert the start and end dates to readable format
                      final Timestamp startTimestamp = bookedPackage['startDate'] as Timestamp;
                      final Timestamp endTimestamp = bookedPackage['endDate'] as Timestamp;
                      final DateTime startDate = startTimestamp.toDate();
                      final DateTime endDate = endTimestamp.toDate();
                      final String formattedStartDate = DateFormat('dd MMM yyyy').format(startDate);
                      final String formattedEndDate = DateFormat('dd MMM yyyy').format(endDate);

                      return GestureDetector(
                        onTap: () {
                          // Handle on tap event, e.g., navigate to package details page.
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Package Name and Date Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      packageData['name'] ?? 'Package Name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Start Date: $formattedStartDate',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          'End Date: $formattedEndDate',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Divider to separate sections
                                const Divider(thickness: 1, color: Colors.grey),

                                const SizedBox(height: 12),

                                // Price Information
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Package Price:',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '₹${packageData['offerPrice']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // More details like location, etc., can be added here
                                    Text(
                                      packageData['location'] ?? 'Location Info',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300],
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          height: 120,
                        ),
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
      ),
    );
  }
}
