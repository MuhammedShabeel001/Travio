import 'package:flutter/material.dart';
// import 'package:travio/view/widgets/global/custom_textfield.dart';
import 'package:travio/view/widgets/home/package/review_card.dart';

import '../../../../core/theme/theme.dart';

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
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Add Your Review',
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black87,
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //       TextFormField(
          //         maxLines: 3,
          //         decoration: InputDecoration(
          //           hintText: 'Write your review here...',
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(12.0),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       ElevatedButton(
          //         onPressed: () {
          //           // Handle review submission
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor:
          //               Colors.orange, // Adjust to match your theme
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 12, horizontal: 24),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //         ),
          //         child: const Text(
          //           'Submit Review',
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      // floatingActionButton: Container(
      //   // width: double.infinity,
      //   // height: 80,
      //   padding: EdgeInsets.only(left: 24),
      //   // decoration: BoxDecoration(color: Colors.greenAccent),
      //   child: Row(
      //     // crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       Flexible(
      //         child: TextField(
      //           decoration: InputDecoration(
      //             hintText: 'Write your review here...',
      //             hintStyle: const TextStyle(
      //               color: Color.fromARGB(101, 0, 0, 0),
      //             ),
      //             fillColor: TTthemeClass().ttThirdOpacity,
      //             filled: true,
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(20.0),
      //               borderSide: BorderSide.none,
      //             ),
      //             contentPadding: const EdgeInsets.symmetric(
      //               // vertical: 20.0,
      //               horizontal: 20.0,
      //             ),
      //           ),
      //         ),
      //       ),
      //       IconButton(onPressed: (){}, icon: Icon(Icons.abc))
      //     ],
      //   ),
      // ),

      bottomNavigationBar: Container(
        // width: double.infinity,
        // height: 80,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // decoration: BoxDecoration(color: Colors.greenAccent),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: TextField(
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(101, 0, 0, 0),
                  ),
                  fillColor: TTthemeClass().ttThirdOpacity,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Container(
              decoration: BoxDecoration(
                color: TTthemeClass().ttThirdOpacity,
                borderRadius: BorderRadius.circular(20)

              ),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)))
          ],
        ),
      ),
    );
  }
}
