import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/search_provider.dart'; // Adjust the import path according to your project
import '../../../model/package_model.dart'; // Import the package model

class FilterBottomSheet extends StatelessWidget {
  final List<TripPackageModel> allPackages;

  const FilterBottomSheet({
    super.key,
    required this.allPackages,
  });

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Min and Max Price Range Fields
          const Text('Price Range'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Min Price'),
                  keyboardType: TextInputType.number,
                  initialValue: searchProvider.minPrice.toString(),
                  onChanged: (value) {
                    searchProvider.setMinPrice(double.tryParse(value) ?? 0);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Max Price'),
                  keyboardType: TextInputType.number,
                  initialValue: searchProvider.maxPrice.toString(),
                  onChanged: (value) {
                    searchProvider.setMaxPrice(double.tryParse(value) ?? 10000);
                  },
                ),
              ),
            ],
          ),
          const Divider(thickness: 1, height: 32),

          // Total Number of Days Dropdown
          const Text('Total Number of Days'),
          DropdownButtonFormField<int>(
  value: searchProvider.totalDays,
  items: const [
    DropdownMenuItem(value: 1, child: Text('1 Day')),
    DropdownMenuItem(value: 2, child: Text('2 Days')),
    DropdownMenuItem(value: 3, child: Text('3 Days')),
    DropdownMenuItem(value: 4, child: Text('4 Days')),
    DropdownMenuItem(value: 5, child: Text('5 Days')),
    DropdownMenuItem(value: 6, child: Text('6 Days')),
    DropdownMenuItem(value: 7, child: Text('1 Week')),
    DropdownMenuItem(value: 14, child: Text('2 Weeks')),
    DropdownMenuItem(value: 21, child: Text('3 Weeks')),
    DropdownMenuItem(value: 30, child: Text('1 Month')),
  ],
  onChanged: (value) {
    if (value != null) {
      searchProvider.setTotalDays(value);
    }
  },
),
          const Divider(thickness: 1, height: 32),

          // Sort Order Dropdown
          const Text('Sort Order'),
          DropdownButtonFormField<bool>(
            value: searchProvider.isAscending,
            items: const [
              DropdownMenuItem(value: true, child: Text('Ascending')),
              DropdownMenuItem(value: false, child: Text('Descending')),
            ],
            onChanged: (value) {
              if (value != null) {
                searchProvider.setSortOrder(value);
              }
            },
          ),
          const Divider(thickness: 1, height: 32),

          // Apply Filters Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                searchProvider.applyFilters(allPackages);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Reset Filters Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                searchProvider.resetFilters();
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Reset Filters',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
