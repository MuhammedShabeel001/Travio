import 'package:flutter/material.dart';
// import 'package:travio/view/widgets/global/custom_textfield.dart';
import 'package:travio/view/widgets/home/package/review_card.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ReviewCard(
                  userName: 'John Doe',
                  userProfileUrl:
                      'https://via.placeholder.com/150', // Placeholder profile image
                  rating: 4,
                  review:
                      'Amazing trip! The itinerary was well-planned, and the guides were very knowledgeable.',
                ),
                ReviewCard(
                  userName: 'Jane Smith',
                  userProfileUrl:
                      'https://via.placeholder.com/150', // Placeholder profile image
                  rating: 5,
                  review:
                      'A fantastic experience! Highly recommend this package.',
                ),
                ReviewCard(
                  userName: 'Sam Wilson',
                  userProfileUrl:
                      'https://via.placeholder.com/150', // Placeholder profile image
                  rating: 3,
                  review:
                      'It was good, but I felt some activities could have been better organized.',
                ),
                ReviewCard(
                  userName: 'Lisa Wong',
                  userProfileUrl:
                      'https://via.placeholder.com/150', // Placeholder profile image
                  rating: 4,
                  review:
                      'Great value for money. The transport and accommodation were excellent.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
