import 'package:flutter/material.dart';
import '../../../model/place_model.dart';
// import '../../models/place_model.dart';

class SPlaceCard extends StatelessWidget {
  final PlaceModel place;

  const SPlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(place.name),
        subtitle: Text(place.description),
        leading: place.images.isNotEmpty
            ? Image.network(place.images[0], width: 80, height: 80, fit: BoxFit.cover)
            : const Icon(Icons.place),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
