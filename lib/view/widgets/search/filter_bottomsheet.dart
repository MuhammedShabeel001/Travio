import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          // Add your filter options here
          // Example: Filter by category, price range, etc.
          CheckboxListTile(
            title: Text('Filter 1'),
            value: false,
            onChanged: (bool? value) {
              // Handle filter change
            },
          ),
          CheckboxListTile(
            title: Text('Filter 2'),
            value: false,
            onChanged: (bool? value) {
              // Handle filter change
            },
          ),
          // Add more filters as needed
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
