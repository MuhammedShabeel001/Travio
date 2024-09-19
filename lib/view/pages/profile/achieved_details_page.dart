import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/model/package_model.dart';

import '../../widgets/achieved/add_review_button.dart';
import '../../widgets/achieved/package_details.dart';
import '../../widgets/achieved/package_header.dart';
import '../../widgets/achieved/package_plan.dart';
import '../../widgets/achieved/package_pricing_info.dart';
import '../home/package/package_detail_page.dart';

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
              color: Colors.white,
              height: 15,
            ),
          ),
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
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PackageHeader(packageData: packageData),
                    const SizedBox(height: 16),
                    PackagePricingInfo(totalAmount: totalAmount, numberOfPeople: numberOfPeople, packageData: packageData),
                    const SizedBox(height: 16),
                    PackageDetails(packageData: packageData),
                    const SizedBox(height: 16),
                    PackagePlan(packageData: packageData),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          if (user != null) AddReviewButton(packageData: packageData),
        ],
      ),
    );
  }
}
