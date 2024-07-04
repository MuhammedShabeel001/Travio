// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/providers/auth_provider.dart';
import 'package:travio/controller/utils/theme.dart';
import 'package:travio/core/common/appbar.dart';
import 'package:travio/view/widgets/Global/logout_alert.dart';

class ProfilePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String userId = authProvider.user?.id ?? ''; // Assuming user ID is accessible in authProvider

    return Scaffold(
      body: ttAppBar(context, 'Profile', listView(context, authProvider, userId)),
    );
  }

  ListView listView(BuildContext context, AuthProvider authProvider, String userId) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: authProvider.fetchUserData(userId),
              builder: (context, snapshot) {
                if (authProvider.isLoadingFetchUser) {
                  return const Center(child: CircularProgressIndicator());
                } else 
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching user data'));
                } else {
                  return SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: authProvider.user?.profile != null
                                ? Image.network(authProvider.user!.profile!)
                                : Image.asset('assets/images/lisa image.png'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          authProvider.user?.name ?? 'Loading...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: TTthemeClass().ttLightText,
                          ),
                        ),
                        Text(
                          authProvider.user?.pronouns ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                        Text(
                          authProvider.user?.email ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(30, 0, 0, 0),
                  style: BorderStyle.solid,
                  width: 1,
                ),
                color: TTthemeClass().ttLightPrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 360,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/wishlist.svg'),
                    title: Text(
                      'Wishlist',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/recent.svg'),
                    title: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/theme.svg'),
                    title: Text(
                      'Theme',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/edit.svg'),
                    title: Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/privacyPolicy.svg'),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/termsOfService.svg'),
                    title: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/delete.svg'),
                    title: Text(
                      'Delete my account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => tLogOut(context),
                      );
                    },
                    leading: SvgPicture.asset('assets/icons/log-out.svg'),
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: SvgPicture.asset('assets/icons/forward-arrow.svg'),
                  ),
                  const SizedBox(height: 30),
                  Text('version', style: TextStyle(color: TTthemeClass().ttLightText)),
                  Text('1.01.001', style: TextStyle(color: TTthemeClass().ttLightText)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
