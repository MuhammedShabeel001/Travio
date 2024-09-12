import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/model/package_model.dart';
import 'package:travio/view/widgets/home/package/review_card.dart';

class ReviewsTab extends StatelessWidget {
  final TripPackageModel tripPackage;

  const ReviewsTab({Key? key, required this.tripPackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviews = tripPackage.customerReviews;

    if (reviews.isEmpty) {
      return  SizedBox(
        height: 30,
        child: Center(child: Lottie.asset('assets/animations/empty_review.json')));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final userId = reviews.keys.elementAt(index);
        final reviewText = reviews[userId] ?? '';

        return ReviewCard(
          userName: '$userId', // You might want to fetch the actual username if available
          userProfileUrl: 'assets/images/default_pfpf.jpg', // Placeholder image, replace with actual user image if available
          review: reviewText,
        );
      },
    );
  }
}