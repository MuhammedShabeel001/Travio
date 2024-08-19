import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/search/filter_bottomsheet.dart';

class ttSearchBar extends StatelessWidget {
  Color? bgColor;
  final TextEditingController controller;
//  final ValueChanged<String> onChanged;
  final void Function(String) onSearch;

  ttSearchBar({
    required this.onSearch,
    this.bgColor,
    required this.controller,
    // required this.onChanged,
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
          SizedBox(width: 8),
          Container(
            // clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => FilterBottomSheet(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
