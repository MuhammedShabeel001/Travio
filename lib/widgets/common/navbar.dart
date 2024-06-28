import 'package:flutter/material.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travio/pages/home_page.dart';
import 'package:travio/pages/itinarary_page.dart';
import 'package:travio/pages/profile_page.dart';
import 'package:travio/pages/search_page.dart';
import 'package:travio/pages/trip_plan_page.dart';
import 'package:travio/utils/theme.dart';

class TTnavBar extends StatefulWidget {
  const TTnavBar({super.key});

  @override
  State<TTnavBar> createState() => _TTnavBarState();
}

class _TTnavBarState extends State<TTnavBar> {
  int currentIndex = 0;

  final List<Widget> _tabs = [
    const HomePage(),
    const SearchPage(),
    const TripPlanPage(),
    const ItinararyPage(),
    const ProfilePage()
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
              animationDuration:const Duration(milliseconds: 300),
              animationCurve: Curves.ease,
              indicatorColor: TTthemeClass().ttThird,
              height: 70,
              
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                SvgPicture.asset('assets/icons/Home.svg',), // Icon for Home page
                SvgPicture.asset('assets/icons/search.svg',), // Icon for Home page
                SvgPicture.asset('assets/icons/add.svg',), // Icon for Home page
                SvgPicture.asset('assets/icons/ticket.svg',), // Icon for Home page
                SvgPicture.asset('assets/icons/profile.svg',),
                 // Icon for Home page
                // Icon(Icons.search,color: TTthemeClass().ttThird,), // Icon for Search page
                // Icon(Icons.add,color: TTthemeClass().ttThird,), // Icon for Profile page
                // Icon(Icons.airplane_ticket_outlined,color: TTthemeClass().ttThird,), // Icon for Profile page
                // Icon(Icons.person,color: TTthemeClass().ttThird,), // Icon for Profile page
              ],
            ),
          ),
        ],
      ),
    );
  }
}
