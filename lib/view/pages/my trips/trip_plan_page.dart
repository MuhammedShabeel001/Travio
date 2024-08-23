import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travio/view/widgets/global/appbar.dart';

class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ttAppBar(context, 'Plan trip', AddTripCenter(context)),
        // floatingActionButton: FloatingActionButton.large(onPressed: (){
        //   // _showAlertDialog(context);
        // })
        );
  }

  // void _showAlertDialog(BuildContext context) {
  //    showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Column(
  //           children: [
  //             Lottie.asset(
  //               'assets/animations/payment_wallet.json',
  //               // width: 100,
  //               height: 100,
  //               fit: BoxFit.fill,
  //             ),
  //             const SizedBox(height: 16.0),
  //             Text( 'Payment Successful'),
  //           ],
  //         ),
  //         // content: Text(status),
  //       );
  //     },
  //   );
  // }

  // ignore: non_constant_identifier_names
  Center AddTripCenter(BuildContext context) {
    return const Center(
      child: Text('Plan your trip here'),
    );
  }
}
