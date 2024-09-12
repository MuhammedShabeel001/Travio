import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArchivedPackagesPage extends StatelessWidget {
  final String? userId;

  const ArchivedPackagesPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    debugPrint('User ID: $userId');
    return Scaffold(
      appBar: AppBar(title: const Text('Archived Packages')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('archivedPackages')
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
                final archievedPackage =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                final packageId = archievedPackage['packageId'] as String?;

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
                            'Dates: ${archievedPackage['startDate']} - ${archievedPackage['endDate']}'),
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
      ),
    );
  }
}
