import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/controller/provider/version_provider.dart';  // Import VersionProvider

import '../global/logout_alert.dart';

class SettingsCard extends StatelessWidget {
  final AuthProvider authProvider;
  const SettingsCard({
    super.key, 
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    // Accessing VersionProvider to load the version
    Provider.of<VersionProvider>(context, listen: false).loadAppVersion();

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
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
              'Log out',
              style: TextStyle(fontSize: 20),
            ),
            leading: SvgPicture.asset('assets/icons/log-out.svg'),
          ),
          ListTile(
            onTap: () {
              // Add any delete functionality if needed
            },
            title: const Text(
              'Version',
              style: TextStyle(fontSize: 20),
            ),
            trailing: Consumer<VersionProvider>(
              builder: (context, versionProvider, child) {
                return Text(versionProvider.version.isEmpty
                    ? 'Loading...'  // Show loading if the version is not yet loaded
                    : versionProvider.version);
              },
            ),
          ),
        ],
      ),
    );
  }
}
