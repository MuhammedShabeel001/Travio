import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/providers/auth_provider.dart';

AlertDialog tLogOut(BuildContext context) {
  return AlertDialog(
    title: const Text('Confirm Sign Out'),
    content: const Text('Are you sure you want to sign out?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          Provider.of<AuthProvider>(context, listen: false).signOut(context);
        },
        child: const Text('Sign Out'),
      ),
    ],
  );
}
