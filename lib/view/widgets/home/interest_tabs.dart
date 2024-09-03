import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/home/interests/interest_detail_page.dart';

class InterestTabs extends StatelessWidget {
  final IconData icon;
  final String label;
  const InterestTabs({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
        // Navigate to InterestDetailPage when tapped
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => InterestDetailPage(interest: label),
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
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20 ),
              child: Icon(icon, size: 30)),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
