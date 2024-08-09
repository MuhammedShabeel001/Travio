import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travio/controller/provider/auth_provider.dart';

import '../global/logout_alert.dart';

class SettingsCard extends StatelessWidget {
  final AuthProvider authProvider;
  const SettingsCard({
    super.key, required this.authProvider, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) =>
                    tLogOut(context, authProvider),
              );
            },
            title: const Text(
              'Log out',
              style: TextStyle(fontSize: 20),
            ),
            leading: SvgPicture.asset('assets/icons/log-out.svg'),
          ),
          ListTile(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) =>
              //       tLogOut(context, authProvider),
              // );
            },
            title: const Text(
              'Delete',
              
              style: TextStyle(fontSize: 20,color: Colors.red),
            ),
            leading: SvgPicture.asset('assets/icons/delete.svg',),
          ),
          ListTile(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) =>
              //       tLogOut(context, authProvider),
              // );
            },
            title: const Text(
              'Version',
              style: TextStyle(fontSize: 20),
            ),
            // leading: SvgPicture.asset(''),
            trailing: Text('1.01.001'),
          ),
        ],
      ),
    );
  }
}
