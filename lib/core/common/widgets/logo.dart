import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TtLogo extends StatelessWidget {
  const TtLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 300,
      child: SvgPicture.asset(
        'assets/logo/Logo  (d mode).svg',
        fit: BoxFit.contain,
      ),
    );
  }
}