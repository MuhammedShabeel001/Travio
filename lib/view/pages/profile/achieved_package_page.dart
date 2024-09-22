import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/pages/profile/achieved_details_page.dart';
import 'package:travio/view/widgets/my_trips/shimmer_effect.dart';

import '../../../model/package_model.dart';
import '../home/package/package_detail_page.dart';

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
            return const Center(child: ShimmerEffect());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final archivedPackage =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final packageId = archivedPackage['packageId'] as String?;

                if (packageId == null || packageId.isEmpty) {
                  return const ListTile();
                }

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('trip_packages')
                      .doc(packageId)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot> packageSnapshot) {
                    if (packageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: ShimmerEffect());
                    }

                    if (packageSnapshot.hasData &&
                        packageSnapshot.data!.exists) {
                      final packageData =
                          packageSnapshot.data!.data() as Map<String, dynamic>;

                      final Timestamp? startTimestamp =
                          archivedPackage['startDate'] as Timestamp?;
                      final Timestamp? endTimestamp =
                          archivedPackage['endDate'] as Timestamp?;

                      final String formattedStartDate = startTimestamp != null
                          ? DateFormat('dd MMM yyyy')
                              .format(startTimestamp.toDate())
                          : 'N/A';
                      final String formattedEndDate = endTimestamp != null
                          ? DateFormat('dd MMM yyyy')
                              .format(endTimestamp.toDate())
                          : 'N/A';
                      final int numberOfPeople =
                          archivedPackage['numberOfPeople'] ?? 1;
                      final double totalAmount =
                          packageData['offer_price'] * numberOfPeople;
                      double pricePerPerson = packageData['offer_price'];
                      double gstPerPerson = pricePerPerson * 0.06;
                      double totalWithGst =
                          totalAmount + (gstPerPerson * numberOfPeople);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          packageData['name'] ?? 'Package Name',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Dates: $formattedStartDate - $formattedEndDate',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Price: ₹${totalWithGst.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/navigate.svg',
                                      color: Colors.black,
                                      height: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              TripPackageDetailPage(
                                            tripPackage:
                                                TripPackageModel.fromMap(
                                                    packageData),
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
                      return const ListTile();
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
