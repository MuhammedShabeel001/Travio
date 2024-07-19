import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travio/core/common/appbar.dart';
import 'package:travio/features/auth/view/pages/home/widgets/interest_tabs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ttAppBar(context, 'Home', HomeCenter(context)));
  }

  // ignore: non_constant_identifier_names
  SingleChildScrollView HomeCenter(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover by interests',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InterestTabs(icon: Icons.hiking_rounded, label: 'Hiking'),
                InterestTabs(icon: Icons.terrain_rounded, label: 'Mountain'),
                InterestTabs(icon: Icons.forest_rounded, label: 'Forest'),
                InterestTabs(icon: Icons.beach_access_rounded, label: 'Sea'),
                InterestTabs(icon: Icons.grid_view_rounded, label: 'More'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Explore the world',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  buildExploreItem('Dubai', 'assets/images/entry_pic.png'),
                  buildExploreItem('Bhutan', 'assets/images/entry_pic.png'),
                  buildExploreItem('Paris', 'assets/images/entry_pic.png'),
                  buildExploreItem('Japan', 'assets/images/entry_pic.png')
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'India',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            // ListView(
            //   scrollDirection: Axis.horizontal,
            //   shrinkWrap: true,
            //   children: [
            //     buildExploreItem('Palakkad', 'assets/images/entry_pic.png'),
            //     buildExploreItem('Malappuram', 'assets/images/entry_pic.png'),
            //     buildExploreItem('Kozhicode', 'assets/images/entry_pic.png'),
            //     buildExploreItem('Trivandram', 'assets/images/entry_pic.png')
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
// Widget buildInterestItem(IconData icon, String label) {
//     return ;
//   }

  Widget buildExploreItem(String label, String imagePath) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15,)
      ],
    );
  }






  //  Widget buildExploreItem(String label, String imagePath) {
  //   return Row(
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //             color: Colors.white, borderRadius: BorderRadius.circular(18)),
  //         width: 200,
  //         // height: 300,
  //         child: Column(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(18),
  //               child: Image.asset(
  //                 imagePath,
  //                 fit: BoxFit.cover,
  //                 height: 160,
  //                 width: double.infinity,
  //               ),
  //             ),
  //             SizedBox(height: 8),
  //             Text(
  //               label,
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         width: 15,
  //       )
  //     ],
  //   );
  // }
}
