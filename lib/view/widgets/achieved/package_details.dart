import 'package:flutter/material.dart';

class PackageDetails extends StatelessWidget {
  final Map<String, dynamic> packageData;

  const PackageDetails({super.key, required this.packageData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, 'Number of Days',
                packageData['total_number_of_days']?.toString() ?? 'N/A'),
            const Divider(),
            _buildDetailRow(Icons.place, 'Destination',
                _formatDestinationList(packageData['locations'])),
          ],
        ),
      ),
    );
  }

  String _formatDestinationList(dynamic locations) {
    if (locations is List && locations.isNotEmpty) {
      return locations.join(', ');
    } else {
      return 'Unknown';
    }
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
