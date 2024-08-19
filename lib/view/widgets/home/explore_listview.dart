import 'package:flutter/material.dart';
import 'package:travio/view/widgets/home/explore_item.dart';

class ExploreListView extends StatelessWidget {
  const ExploreListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: const [
          SizedBox(width: 15,),
          ExploreItem(image: 'assets/images/entry_pic.png', label: 'Dubai'),
          ExploreItem(image: 'assets/images/entry_pic.png', label: 'Paris'),
          ExploreItem(image: 'assets/images/entry_pic.png', label: 'London'),
          ExploreItem(image: 'assets/images/entry_pic.png', label: 'Japan'),
          ExploreItem(image: 'assets/images/entry_pic.png', label: 'Korea'),
        ],
      ),
    );
  }
}
