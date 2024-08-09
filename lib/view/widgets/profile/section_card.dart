import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/theme.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function onTap;

  const SectionCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      
      decoration: BoxDecoration(
        color: TTthemeClass().ttLightPrimary,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        onTap: () => onTap(),
        leading: SvgPicture.asset(iconPath),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: TTthemeClass().ttLightText,
          ),
        ),
        trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
      ),
    );
  }
}
