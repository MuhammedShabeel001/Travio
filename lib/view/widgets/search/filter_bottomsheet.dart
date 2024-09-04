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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Min and Max Price Range Fields
          _buildSectionTitle(context, 'Price Range', Icons.attach_money),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  context,
                  label: 'Min Price',
                  initialValue: searchProvider.minPrice.toString(),
                  onChanged: (value) {
                    searchProvider.setMinPrice(double.tryParse(value) ?? 0);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  context,
                  label: 'Max Price',
                  initialValue: searchProvider.maxPrice.toString(),
                  onChanged: (value) {
                    searchProvider.setMaxPrice(double.tryParse(value) ?? 10000);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1),

          // Total Number of Days Dropdown
          _buildSectionTitle(context, 'Total Number of Days', Icons.calendar_today),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: searchProvider.totalDays,
            items: List.generate(30, (index) {
              final day = index + 1;
              final label = day == 7 ? '1 Week' : day == 14 ? '2 Weeks' : day == 30 ? '1 Month' : '$day Day${day > 1 ? 's' : ''}';
              return DropdownMenuItem(value: day, child: Text(label));
            }),
            onChanged: (value) {
              if (value != null) {
                searchProvider.setTotalDays(value);
              }
            },
            decoration: _inputDecoration(context),
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1),

          // Sort Order Dropdown
          _buildSectionTitle(context, 'Sort Order', Icons.sort),
          const SizedBox(height: 12),
          DropdownButtonFormField<bool>(
            value: searchProvider.isAscending,
            items: [
              DropdownMenuItem(value: true, child: Text('Ascending')),
              DropdownMenuItem(value: false, child: Text('Descending')),
            ],
            onChanged: (value) {
              if (value != null) {
                searchProvider.setSortOrder(value);
              }
            },
            decoration: _inputDecoration(context),
          ),
          const SizedBox(height: 24),

          // Apply Filters Button
          Row(
            children: [
          Flexible(
            child: _buildButton(
              context,
              'Reset Filters',
              Colors.transparent,
              () {
                searchProvider.resetFilters();
                Navigator.pop(context);
              },
              isOutlined: true,
            ),
          ), const SizedBox(width: 12),

          const SizedBox(height: 24),
              Flexible(
                child: _buildButton(
                  context,
                  'Apply Filters',
                  Theme.of(context).colorScheme.primary,
                  () {
                    searchProvider.applyFilters(allPackages);
                    Navigator.pop(context);
                  },
                ),
              ),


            ],
          ),
         

          // Reset Filters Button
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required String initialValue, required ValueChanged<String> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        decoration: _inputDecoration(context, label: label),
        keyboardType: TextInputType.number,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, {String? label}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color backgroundColor, VoidCallback onPressed, {bool isOutlined = false}) {
    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
