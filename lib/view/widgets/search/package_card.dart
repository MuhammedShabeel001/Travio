import 'package:flutter/material.dart';
import '../../../model/package_model.dart';
// import '../../models/package_model.dart';

class SPackageCard extends StatelessWidget {
  final TripPackageModel package;

  SPackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(package.name),
        subtitle: Text(package.description),
        leading: package.images.isNotEmpty
            ? Image.network(package.images[0], width: 80, height: 80, fit: BoxFit.cover)
            : Icon(Icons.card_travel),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
