import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/profile/achieved_details_page.dart';

import '../../../model/package_model.dart';
import '../home/package/package_detail_page.dart';
// import 'trip_package_detail_page.dart'; // Import the TripPackageDetailPage

class ArchivedPackagesPage extends StatelessWidget {
  final String? userId;

  const ArchivedPackagesPage({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTthemeClass().ttSecondary,
      appBar: AppBar(
        backgroundColor: TTthemeClass().ttSecondary,
        automaticallyImplyLeading: false,
        title: const Text('Archived Packages'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('archivedPackages')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final archivedPackage =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final packageId = archivedPackage['packageId'] as String?;

                if (packageId == null || packageId.isEmpty) {
                  return const ListTile(
                    // title: Text('Invalid package ID.'),
                  );
                }

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
                      final packageData = packageSnapshot.data!.data() as Map<String, dynamic>;

                      final Timestamp? startTimestamp = archivedPackage['startDate'] as Timestamp?;
                      final Timestamp? endTimestamp = archivedPackage['endDate'] as Timestamp?;

                      final String formattedStartDate = startTimestamp != null
                          ? DateFormat('dd MMM yyyy').format(startTimestamp.toDate())
                          : 'N/A';
                      final String formattedEndDate = endTimestamp != null
                          ? DateFormat('dd MMM yyyy').format(endTimestamp.toDate())
                          : 'N/A';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to detailed page or show more details
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => PackageDetailPage(
                                  
                                  packageData: packageData,
                                  archivedPackage: archivedPackage,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Package Name
                                        Text(
                                          packageData['name'] ?? 'Package Name',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),

                                        // Date Range
                                        Text(
                                          'Dates: $formattedStartDate - $formattedEndDate',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),

                                        // Price Info
                                        Text(
                                          'Price: ₹${packageData['offerPrice']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_right),
                                    onPressed: () {
                                      // Navigate to TripPackageDetailPage
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => TripPackageDetailPage(
                                            tripPackage: TripPackageModel.fromMap(packageData),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const ListTile(
                        // title: Text('Package details not found.'),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No archived packages found.'));
          }
        },
      ),
    );
  }
}
