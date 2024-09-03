import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/search/filter_bottomsheet.dart';
import '../../../model/package_model.dart';
import '../../../model/place_model.dart';

class TtSearchBar extends StatelessWidget {
  final Color? bgColor;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  final List<TripPackageModel> allPackages;
  final List<PlaceModel> allPlaces;

  const TtSearchBar({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    this.bgColor,
    required this.controller,
    required this.allPackages,
    required this.allPlaces, required Null Function(dynamic String) onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: TTthemeClass().ttThird),
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.grey[600]),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: bgColor ?? Colors.white,
        suffixIcon: IconButton(
          icon: Icon(Icons.filter_list, color: TTthemeClass().ttThird),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return FilterBottomSheet(
                  allPackages: allPackages,
                  // allPlaces: allPlaces,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
