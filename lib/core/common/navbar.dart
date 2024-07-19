import 'package:flutter/material.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travio/features/auth/view/pages/home/pages/home_page.dart';
import 'package:travio/features/auth/view/pages/profile/profile_page.dart';
import 'package:travio/features/auth/view/pages/search/search_page.dart';
import 'package:travio/features/auth/view/pages/my%20trips/trip_plan_page.dart';
import 'package:travio/core/theme/theme.dart';

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
              backgroundColor: TTthemeClass().ttLightPrimary,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.ease,
              indicatorColor: TTthemeClass().ttThird,
              height: 70,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                SvgPicture.asset(
                  'assets/icons/Home.svg',
                ),
                SvgPicture.asset(
                  'assets/icons/search.svg',
                ),
                SvgPicture.asset(
                  'assets/icons/add.svg',
                ),
                // SvgPicture.asset(
                //   'assets/icons/ticket.svg',
                // ),
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
