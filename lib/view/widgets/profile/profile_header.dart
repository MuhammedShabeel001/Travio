import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/profile/edit_dialog.dart';

import '../../../model/user_model.dart';

class ProfileHeader extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: TTthemeClass().ttLightPrimary,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(75.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: user?.profile != null
                  ? CachedNetworkImage(
                    
                      imageUrl: user.profile!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(color: Colors.black,),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/default_pfpf.jpg',fit: BoxFit.cover,),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                user?.name ?? 'User name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user?.phonenumber.toString() ?? '0000000000',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user?.email ?? 'example@gmail.com',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ],
          ),
          IconButton(onPressed:  () => _showEditProfileDialog(context, user), icon: const Icon(Icons.edit_rounded,color: Colors.black,))
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return EditProfileDialog(user: user);
      },
    );
  }
}