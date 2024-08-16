import 'package:flutter/material.dart';
// import 'package:travio/view/pages/interest_detail_page.dart';

// import '../../pages/home/interests/interest_detail_page.dart';

class ExploreItem extends StatelessWidget {
  final String image;
  final String label;

  const ExploreItem({
    super.key, required this.image, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
