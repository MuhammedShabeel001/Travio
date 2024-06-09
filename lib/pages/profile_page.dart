import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:travio/utils/theme.dart';
import 'package:travio/widgets/common/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ttAppBar(context, 'Profile', listView());

    // DraggableHome(
    // appBarColor: TTthemeClass().ttLightPrimary,
    // title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: TTthemeClass().ttLightText,),),
    // centerTitle: false,
    // headerExpandedHeight: 0.15,
    // backgroundColor: TTthemeClass().ttSecondary,
    // headerWidget: Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30,),
    //   color: TTthemeClass().ttLightPrimary,
    //   child:  Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Profile',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: TTthemeClass().ttLightText,),),
    //     ],
    //   ),
    // ),

    // body: );
  }

  ListView listView() {
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
                // color: Color(0xffFF0E58),
                child: Image.asset('assets/images/lisa image.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Lisa Smith',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const Text(
              'She/her',
              style: TextStyle(
                fontSize: 15,color: Color.fromRGBO(0, 0, 0, 0.5)
              ),
            ),
            const Text(
              'lisasmith@gmail.com',
              style: TextStyle(
                fontSize: 15,color: Color.fromRGBO(0, 0, 0, 0.5)
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(30, 0, 0, 0),style: BorderStyle.solid,width: 1),
                  color: TTthemeClass().ttLightPrimary, borderRadius: BorderRadius.circular(15)),
              width: 360,
              child:  const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text('Wishlist',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                 ListTile(
                    leading: Icon(Icons.history),
                    title: Text('History',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Text('Theme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit profile',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Privacy Policy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit_document),
                    title: Text('Terms of Service',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete my account',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log out',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('version'),
                  Text('1.01.001')
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
