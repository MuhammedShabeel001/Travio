import 'package:flutter/material.dart';

class PackagePlan extends StatelessWidget {
  final Map<String, dynamic> packageData;

  const PackagePlan({super.key, required this.packageData});

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
            const Text(
              'Trip Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            packageData['daily_plan'] != null && packageData['daily_plan'] is Map
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildPlanItems(packageData['daily_plan']),
                  )
                : const Text(
                    'No detailed plan available for this package.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlanItems(Map<String, dynamic> plan) {
    return plan.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.key}: ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            Expanded(
              child: Text(
                entry.value.toString(),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
