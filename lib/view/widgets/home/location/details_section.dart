import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final String distance;
  final String weather;
  final String description;
  final String country;
  final String continent;
  final String activities;

  const DetailsSection({
    super.key,
    required this.distance,
    required this.weather,
    required this.description,
    required this.country,
    required this.continent,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.redAccent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                distance,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.map, color: Colors.blueAccent),
              onPressed: () {
                // Navigate to map functionality (if applicable)
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.cloud, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(
              weather,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black87,
                fontSize: 16,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 16),
        Divider(thickness: 1, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  country,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continent:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  continent,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(thickness: 1, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        const Text(
          'Activities:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: activities
              .split(', ')
              .map((activity) => Chip(
                    label: Text(activity),
                    backgroundColor: Colors.purpleAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
