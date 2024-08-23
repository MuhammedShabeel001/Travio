import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/core/theme/theme.dart';

import '../../../../controller/provider/booking_provider.dart';
import '../../../../controller/provider/package_provider.dart';
import '../../../../model/package_model.dart';
import '../../../widgets/home/package/booking_bottom_sheet.dart';
import '../../../widgets/home/package/bottom_buttom.dart';
import '../../../widgets/home/package/carousal_images.dart';
import '../../../widgets/home/package/likes_review.dart';
import '../../../widgets/home/package/package_info.dart';
import '../../../widgets/home/package/review_details.dart';
// import 'controller/provider/booking_provider.dart';
// import 'controller/provider/package_provider.dart'; // Ensure this is imported
// import 'model/package_model.dart';
// import 'widgets/home/package/booking_bottom_sheet.dart';
// import 'widgets/home/package/carousal_images.dart';
// import 'widgets/home/package/likes_review.dart';
// import 'widgets/home/package/package_info.dart';
// import 'widgets/home/package/review_details.dart';

class TripPackageDetailPage extends StatelessWidget {
  final TripPackageModel tripPackage;

  const TripPackageDetailPage({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => BookingProvider(),
        child: Scaffold(
          body: Consumer<TripPackageProvider>(
            builder: (context, packageProvider, child) {
              // Precache images
              for (var imageUrl in tripPackage.images) {
                precacheImage(NetworkImage(imageUrl), context);
              }
      
              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 350.0,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: CarouselWidget(tripPackage: tripPackage),
                        ),
                        bottom: const PreferredSize(
                          preferredSize: Size.fromHeight(100.0),
                          child: Column(
                            children: [
                              TabBar(
                                indicatorColor: Colors.white,
                                labelColor: Colors.white,
                                tabs: [
                                  Tab(text: "About"),
                                  Tab(text: "Reviews"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PackageInfoWidget(tripPackage: tripPackage),
                            const SizedBox(height: 24),
                            LikesAndReviewsWidget(tripPackage: tripPackage),
                          ],
                        ),
                      ),
                      const ReviewsTab(),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: BookButton(
            onTap: () => _showBookingBottomSheet(context, tripPackage),
          ),
        ),
      ),
    );
  }

  void _showBookingBottomSheet(BuildContext context, TripPackageModel tripPackage) {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    bookingProvider.updatePrice(tripPackage.offerPrice); // Set the price per person here

    showModalBottomSheet(
      context: context,
      backgroundColor: TTthemeClass().ttSecondary,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BookingBottomSheet(
          // onPackageChange: bookingProvider.resetBookingState,
          tripPackage: tripPackage);
      },
    );
  }
}
