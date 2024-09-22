import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/auth_provider.dart';
import 'package:travio/view/pages/profile/achieved_package_page.dart';
import 'package:travio/view/pages/profile/booked_package_page.dart';
import 'package:travio/view/widgets/global/appbar.dart';
import 'package:travio/view/widgets/profile/legal_card.dart';
import 'package:travio/view/widgets/profile/settings_card.dart';
import 'package:travio/view/widgets/profile/support_card.dart';

import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/section_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String userId = authProvider.auth.currentUser!.uid;

    return Scaffold(
      body: ttAppBar(
        context,
        'Profile',
        listView(context, authProvider, userId),
      ),
    );
  }

  Widget listView(
      BuildContext context, AuthProvider authProvider, String? userId) {
    return FutureBuilder(
      future: authProvider.fetchUserData(userId!),
      builder: (context, snapshot) {
        if (authProvider.isLoadingFetchUser) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching user data'));
        } else {
          final user = authProvider.user;
          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(user: user),
                const SizedBox(height: 20),
                SectionCard(
                    title: 'My Journeys',
                    iconPath: 'assets/icons/journey.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              ArchivedPackagesPage(userId: userId),
                        ),
                      );
                    }),
                SectionCard(
                    title: 'Upcoming Itineraries',
                    iconPath: 'assets/icons/upcoming.svg',
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => BookedPackagesPage(),
                        ),
                      );
                    }),
                SettingsCard(authProvider: authProvider),
                // SupportCard(authProvider: authProvider),
                LegalCard(authProvider: authProvider),
              ],
            ),
          );
        }
      },
    );
  }
}
