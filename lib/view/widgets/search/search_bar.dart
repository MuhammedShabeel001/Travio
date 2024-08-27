import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/search/filter_bottomsheet.dart';
import '../../../model/package_model.dart'; // Import the package model
import '../../../model/place_model.dart';   // Import the place model

class TtSearchBar extends StatelessWidget {
  final Color? bgColor;
  final TextEditingController controller;
  final void Function(String) onSearch;
  final List<TripPackageModel> allPackages; // Add this to accept packages
  final List<PlaceModel> allPlaces;         // Add this to accept places

  const TtSearchBar({super.key, 
    required this.onSearch,
    this.bgColor,
    required this.controller,
    required this.allPackages, // Pass packages from the parent widget
    required this.allPlaces,   // Pass places from the parent widget
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearch,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: TTthemeClass().ttThird),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: bgColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: TTthemeClass().ttThird, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Pass the full list of packages and places to the FilterBottomSheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return FilterBottomSheet(
                      allPackages: allPackages, // Pass packages here
                      allPlaces: allPlaces,     // Pass places here
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
