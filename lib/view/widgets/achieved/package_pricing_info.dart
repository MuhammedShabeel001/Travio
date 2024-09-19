import 'package:flutter/material.dart';

class PackagePricingInfo extends StatelessWidget {
  final double totalAmount;
  final int numberOfPeople;
  final Map<String, dynamic> packageData;

  const PackagePricingInfo({super.key, 
    required this.totalAmount,
    required this.numberOfPeople,
    required this.packageData,
  });

  @override
  Widget build(BuildContext context) {
    double pricePerPerson = packageData['offer_price'];
    double gstPerPerson = pricePerPerson * 0.06; // 6% GST
    double totalWithGst = totalAmount + (gstPerPerson * numberOfPeople);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPriceInfo('Price per Person', '₹${pricePerPerson.toStringAsFixed(2)}'),
            _buildPriceInfo('Total Amount', '₹${totalWithGst.toStringAsFixed(2)}'),
            _buildPriceInfo('Number of People', '$numberOfPeople'),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
