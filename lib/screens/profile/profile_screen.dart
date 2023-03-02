import 'package:flutter/material.dart';

import 'components/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: const Body(),
      // bottomNavigationBar:
      //     const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
