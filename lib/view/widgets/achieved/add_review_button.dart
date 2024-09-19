import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/review_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddReviewButton extends StatelessWidget {
  final Map<String, dynamic> packageData;

  const AddReviewButton({super.key, required this.packageData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showReviewBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TTthemeClass().ttThird,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Add Review',
          style: TextStyle(fontSize: 20, color: TTthemeClass().ttLightPrimary),
        ),
      ),
    );
  }

  void _showReviewBottomSheet(BuildContext context) {
    double rating = 3.0;
    final TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Leave a Review',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    rating = newRating;
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: reviewController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Write a review',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await Provider.of<ReviewProvider>(context, listen: false).submitReview(
                        packageId: packageData['id'],
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        rating: rating,
                        reviewText: reviewController.text,
                      );
                      reviewController.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Review submitted successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to submit review. Please try again.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TTthemeClass().ttThird,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: 20,
                      color: TTthemeClass().ttLightPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
