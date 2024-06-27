import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/providers/auth_provider.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: ttAppBar(
        context,
        'Profile',
        FutureBuilder(
          future: authProvider.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching user data'));
            } else {
              return listView(context, authProvider);
            }
          },
        ),
      ),
    );
  }

  ListView listView(BuildContext context, AuthProvider authProvider) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
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
                    leading: Icon(Icons.bookmark, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Wishlist',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.history, color: TTthemeClass().ttLightText),
                    title: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens, color: TTthemeClass().ttLightText),
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
                    leading: Icon(Icons.edit, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit_document, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Delete my account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    onTap: () {
                      authProvider.signOut(context);
                    },
                    leading: Icon(Icons.logout, color: TTthemeClass().ttLightText),
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TTthemeClass().ttLightText,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: TTthemeClass().ttLightText),
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
