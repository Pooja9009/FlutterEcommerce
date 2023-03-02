import 'package:flutter/material.dart';
import 'package:techies_battle/screens/wearOS/screen/cart.dart';
import 'package:techies_battle/screens/wearOS/screen/logout.dart';
import 'package:techies_battle/screens/wearOS/screen/order.dart';
import 'package:techies_battle/screens/wearOS/screen/profile.dart';

class WearOsDashboard extends StatefulWidget {
  const WearOsDashboard({
    Key? key,
  }) : super(key: key);
  static String routeName = "/WearOsDashboard";

  @override
  State<WearOsDashboard> createState() => _WearOsDashboardState();
}

class _WearOsDashboardState extends State<WearOsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              UserProfile(),
              WearOsCartScreen(),
              SizedBox(
                height: 5,
              ),
              WearOsOrderScreen(),
              SizedBox(
                height: 5,
              ),
              WearOsLogoutScreen(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
