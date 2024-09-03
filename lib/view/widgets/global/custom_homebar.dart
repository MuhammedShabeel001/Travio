import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:travio/view/widgets/global/navbar.dart'; // Make sure this path is correct

import '../../../controller/provider/auth_provider.dart';
import '../../../core/theme/theme.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? userId = authProvider.auth?.currentUser?.uid;
    if (userId != null) {
      authProvider.fetchUserData(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Get the full name and split it to get the first name
    String fullName = authProvider.user?.name ?? 'User';
    String firstName = fullName.split(' ')[0]; // Splitting the name by space and taking the first part

    return DraggableHome(
      appBarColor: TTthemeClass().ttLightPrimary,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            // color: white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: TTthemeClass().ttSecondary,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: authProvider.user?.profile ?? '',
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.grey,
              ),
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              firstName, // Displaying only the first name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: TTthemeClass().ttLightText,
              ),
            ),
          ),
        ],
      ),
      centerTitle: false,
      headerExpandedHeight: 0.15,
      backgroundColor: TTthemeClass().ttSecondary,
      // backgroundColor: Colors.white,
      headerWidget: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        color: TTthemeClass().ttLightPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: TTthemeClass().ttSecondary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: authProvider.user?.profile ?? '',
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.grey,
                    ),
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Hi ${firstName},', // Displaying only the first name
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: TTthemeClass().ttLightText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: [
        widget.body,
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
