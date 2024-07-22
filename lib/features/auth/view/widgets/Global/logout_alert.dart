import 'package:flutter/material.dart';
import 'package:travio/features/auth/controller/auth_provider.dart';
import 'package:travio/features/auth/view/pages/login/login_page.dart';

Widget tLogOut(BuildContext context, AuthProvider authProvider) {
  return AlertDialog(
    title: const Text('Log Out'),
    content: const Text('Are you sure you want to log out?'),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Log Out'),
        onPressed: () async {
          await authProvider.signOut(
            onSuccess: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LogInScreen(),), (route) => false,);
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            },
          );
        },
      ),
    ],
  );
}
