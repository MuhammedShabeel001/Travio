import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travio/view/widgets/home/interest_tabs.dart';

import '../../pages/home/interests/more_interest_page.dart';

class InterestRow extends StatelessWidget {
  const InterestRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      // padding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const InterestTabs(icon: Icons.hiking_rounded, label: 'Hiking'),
          const InterestTabs(icon: Icons.nights_stay_rounded, label: 'Camping'), 
          // InterestTabs(icon: Icons.forest_rounded, label: 'Forest'),
          const InterestTabs(icon: Icons.beach_access_rounded, label: 'Beach'),
          const InterestTabs(icon: Icons.directions_bike_rounded, label: 'Cycling'),
          Column(
      children: [
        GestureDetector(
          onTap: () {
        // Navigate to InterestDetailPage when tapped
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ActivityCategoriesPage(),
          ),
        );
      },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(52, 0, 0, 0),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17)),
              // padding: const EdgeInsets.all(13),
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20 ),

              child: const Icon(Icons.grid_view_rounded, size: 30)),
        ),
        const SizedBox(height: 8),
        const Text('More'),
      ],
    )
        ],
      ),
    );
  }
}
