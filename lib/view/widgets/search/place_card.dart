import 'package:flutter/material.dart';
import '../../../model/place_model.dart';
// import '../../models/place_model.dart';

class SPlaceCard extends StatelessWidget {
  final PlaceModel place;

  SPlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(place.name),
        subtitle: Text(place.description),
        leading: place.images.isNotEmpty
            ? Image.network(place.images[0], width: 80, height: 80, fit: BoxFit.cover)
            : Icon(Icons.place),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
