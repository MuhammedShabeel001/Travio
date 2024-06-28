import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/auth_provider.dart';

AlertDialog tLogOut(BuildContext context){
  return AlertDialog(
    title: Text('Confirm Sign Out'),
      content: Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).signOut(context);
          },
          child: Text('Sign Out'),
        ),
      ],
  ) ;
}