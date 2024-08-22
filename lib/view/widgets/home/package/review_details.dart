import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Reviews will be here.'),
    );
  }
}




// import 'package:flutter/material.dart';
// import '../../../../model/package_model.dart';

// class ReviewsTab extends StatelessWidget {
//   const ReviewsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // This would come from the trip package details passed in the previous screen
//     final TripPackageModel tripPackage = ModalRoute.of(context)!.settings.arguments as TripPackageModel;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Customer Reviews",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: tripPackage.customerReviews.length,
//               itemBuilder: (context, index) {
//                 final review = tripPackage.customerReviews[index];
//                 return ReviewDetails(review: review);
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Add functionality for adding new reviews
//             },
//             child: const Text("Add Review"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReviewDetails extends StatelessWidget {
//   final Map<String, String> review;

//   const ReviewDetails({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             review['userName'] ?? '',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             review['comment'] ?? '',
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black54,
//               height: 1.5,
//             ),
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }
