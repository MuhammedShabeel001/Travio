import 'package:flutter/material.dart';

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
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(52, 0, 0, 0),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(17)),
            padding: EdgeInsets.all(13),
            child: Icon(icon, size: 30)),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
