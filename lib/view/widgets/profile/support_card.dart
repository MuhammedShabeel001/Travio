import 'package:flutter/material.dart';
import 'package:travio/controller/provider/auth_provider.dart';

import '../global/logout_alert.dart';

class SupportCard extends StatelessWidget {
  final AuthProvider authProvider;
  const SupportCard({
    super.key,
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Support',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => tLogOut(context, authProvider),
              );
            },
            title: const Text(
              'Help',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(Icons.help_outline_rounded),
          ),
          ListTile(
            onTap: () {},
            title: const Text(
              'Get in touch',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(Icons.contact_mail_outlined),
          ),
        ],
      ),
    );
  }
}
