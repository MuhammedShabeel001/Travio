import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travio/pages/entry_page.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ttAppBar(context, 'Profile', listView(context)),
    );
  }

  ListView listView(BuildContext context) {
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
                child: Image.asset('assets/images/lisa image.png'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Lisa Smith',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: TTthemeClass().ttLightText),
            ),
            const Text(
              'She/her',
              style:
                  TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            const Text(
              'lisasmith@gmail.com',
              style:
                  TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(30, 0, 0, 0),
                    style: BorderStyle.solid,
                    width: 1),
                color: TTthemeClass().ttLightPrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 360,
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Icon(Icons.bookmark, color: TTthemeClass().ttLightText),
                    title: Text('Wishlist',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.history, color: TTthemeClass().ttLightText),
                    title: Text('History',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens,
                        color: TTthemeClass().ttLightText),
                    title: Text('Theme',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.edit, color: TTthemeClass().ttLightText),
                    title: Text('Edit profile',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.lock, color: TTthemeClass().ttLightText),
                    title: Text('Privacy Policy',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit_document,
                        color: TTthemeClass().ttLightText),
                    title: Text('Terms of Service',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.delete, color: TTthemeClass().ttLightText),
                    title: Text('Delete my account',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  ListTile(
                    onTap: () {
                      signout(context);
                    },
                    leading:
                        Icon(Icons.logout, color: TTthemeClass().ttLightText),
                    title: Text('Log out',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: TTthemeClass().ttLightText)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: TTthemeClass().ttLightText),
                  ),
                  const SizedBox(height: 30),
                  Text('version',
                      style: TextStyle(color: TTthemeClass().ttLightText)),
                  Text('1.01.001',
                      style: TextStyle(color: TTthemeClass().ttLightText)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void signout(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context1) => const EntryPage()),
      (route) => false,
    );
  }
}
