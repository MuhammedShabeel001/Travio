import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/package_provider.dart';
import '../../../../core/theme/theme.dart';
import '../../../widgets/home/package/package_card.dart';

// import '../../model/package_model.dart';
// import '../../provider/trip_package_provider.dart';
// import 'package_card.dart'; // Adjust the import path according to your project structure

class PackagesListPage extends StatelessWidget {
  const PackagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text('Packages',style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: TTthemeClass().ttThird,
      ),
      body: FutureBuilder(
        future: packageProvider.fetchAllPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading packages.'));
          } else if (packageProvider.package.isEmpty) {
            return const Center(child: Text('No packages available.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: packageProvider.package.length,
            itemBuilder: (context, index) {
              final package = packageProvider.package[index];
              return Column(
                children: [
                  SizedBox(height: 12,),
                  PackageCard(
                    height: 150,
                    image: package.images.isNotEmpty
                        ? package.images[0]
                        : '', // Assumes at least one image
                    label: package.name,
                    package: package,
                    width: double.infinity, // Adjust width if needed
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
