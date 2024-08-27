import 'package:flutter/material.dart';
import 'package:travio/view/widgets/home/interest_tabs.dart';

class InterestRow extends StatelessWidget {
  const InterestRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      // padding: const EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(horizontal: 15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InterestTabs(icon: Icons.hiking_rounded, label: 'Hiking'),
          InterestTabs(icon: Icons.terrain_rounded, label: 'Mountain'),
          InterestTabs(icon: Icons.forest_rounded, label: 'Forest'),
          InterestTabs(icon: Icons.beach_access_rounded, label: 'Sea'),
          InterestTabs(icon: Icons.grid_view_rounded, label: 'More'),
        ],
      ),
    );
  }
}
