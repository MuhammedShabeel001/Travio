import 'package:flutter/material.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:travio/pages/home_page.dart';
import 'package:travio/pages/itinarary_page.dart';
import 'package:travio/pages/profile_page.dart';
import 'package:travio/pages/search_page.dart';
import 'package:travio/pages/trip_plan_page.dart';
import 'package:travio/utils/theme.dart';

class TTnavBar extends StatefulWidget {
  const TTnavBar({Key? key}) : super(key: key);

  @override
  State<TTnavBar> createState() => _TTnavBarState();
}

class _TTnavBarState extends State<TTnavBar> {
  int currentIndex = 0;

  final List<Widget> _tabs = [
    HomePage(),
    SearchPage(),
    TripPlanPage(),
    ItinararyPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _tabs[currentIndex],
          ),
          Positioned(
           bottom: -15,
            left: 0,
            right: 0,
            child: DotCurvedBottomNav(
              // scrollController: _,
              // hideOnScroll: true,
              backgroundColor: TTthemeClass().ttLightPrimary,
              animationDuration: Duration(milliseconds: 300),
              animationCurve: Curves.ease,
              indicatorColor: TTthemeClass().ttThird,
              height: 70,
              
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                Icon(Icons.home,color: TTthemeClass().ttThird,), // Icon for Home page
                Icon(Icons.search,color: TTthemeClass().ttThird,), // Icon for Search page
                Icon(Icons.add,color: TTthemeClass().ttThird,), // Icon for Profile page
                Icon(Icons.airplane_ticket_outlined,color: TTthemeClass().ttThird,), // Icon for Profile page
                Icon(Icons.person,color: TTthemeClass().ttThird,), // Icon for Profile page
              ],
            ),
          ),
        ],
      ),
    );
  }
}
