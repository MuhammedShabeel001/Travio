// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:travio/providers/auth.dart';
// import 'package:travio/models/user_model.dart';
// import 'package:travio/providers/auth_provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final UserModel? user = authProvider.user;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: user == null
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Name: ${user.name}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Email: ${user.email}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Phone Number: ${user.phonenumber}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Pronouns: ${user.pronouns}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   // Add more fields as needed
//                 ],
//               ),
//             ),
//     );
//   }
// }
