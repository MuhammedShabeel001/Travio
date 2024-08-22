import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/payment_provider.dart';
import '../../../../model/package_model.dart';

class BookingBottomSheet extends StatelessWidget {
  final TripPackageModel tripPackage;

  const BookingBottomSheet({super.key, required this.tripPackage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Confirm Booking",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Package: ${tripPackage.name}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Text(
                "Total Price: ₹${tripPackage.offerPrice}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              if (paymentProvider.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    paymentProvider.makePayment(
                      amount: tripPackage.offerPrice.toString(),
                      contact: 'YourContactNumber',
                      email: 'YourEmail@example.com',
                    );
                  },
                  child: const Text("Confirm"),
                ),
              if (paymentProvider.paymentStatus.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    paymentProvider.paymentStatus,
                    style: TextStyle(
                      fontSize: 16,
                      color: paymentProvider.paymentStatus.contains('Successful')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
