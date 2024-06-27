// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travio/providers/auth_provider.dart';

// class SignUpForm extends StatelessWidget {
//    SignUpForm({super.key});

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {

    
//     return Consumer<AuthProvider>(
//       builder: (context, authProvider, child) {
//         return ListView(
//           padding: const EdgeInsets.only(
//             top: 15,
//             left: 20,
//             right: 20,
//           ),
//           children: [
//             const Text(
//               '''Create account with easy and 
// fast method''',
//               style: TextStyle(
//                 fontSize: 19,
//                 color: Color.fromARGB(99, 0, 0, 0),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Email',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     // Email format validation using regex
//                     bool validEmail = RegExp(
//                       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                       caseSensitive: false,
//                       multiLine: false,
//                     ).hasMatch(value);
//                     if (!validEmail) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                   controller: textControllers.emailController,
//                   decoration: InputDecoration(
//                     hintText: 'example@gmail.com',
//                     hintStyle: const TextStyle(
//                       color: Color.fromARGB(101, 0, 0, 0),
//                     ),
//                     fillColor: TTthemeClass().ttThirdOpacity,
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 20.0,
//                       horizontal: 20.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Password',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     // Add password validation logic here if needed
//                     return null;
//                   },
//                   controller: textControllers.passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: '*************',
//                     hintStyle: const TextStyle(
//                       color: Color.fromARGB(101, 0, 0, 0),
//                     ),
//                     fillColor: TTthemeClass().ttThirdOpacity,
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 20.0,
//                       horizontal: 20.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             tTextfield(Labeltext: 'Password', HintText: 'password'),
//             const SizedBox(
//               height: 15,
//             ),
//             tTextfield(Labeltext: 'Confirm Password', HintText: 'password'),
//           ],
//         );
//       },
//     );
//   }
// }
