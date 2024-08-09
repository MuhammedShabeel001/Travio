import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:travio/controller/provider/auth_provider.dart';

import '../global/logout_alert.dart';

class LegalCard extends StatelessWidget {
  final AuthProvider authProvider;
  const LegalCard({
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
            'Legal',   
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
              'Help',
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(Icons.help_outline_rounded),
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
              'Get in touch',
              
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(Icons.contact_mail_outlined),
          ),
          // ListTile(
          //   onTap: () {
          //     // showDialog(
          //     //   context: context,
          //     //   builder: (context) =>
          //     //       tLogOut(context, authProvider),
          //     // );
          //   },
          //   title: const Text(
          //     'Version',
          //     style: TextStyle(fontSize: 20),
          //   ),
          //   // leading: SvgPicture.asset(''),
          //   trailing: Text('1.01.001'),
          // ),
        ],
      ),
    );
  }
}
