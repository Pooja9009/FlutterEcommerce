import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/components/dashboard.dart';
import 'package:techies_battle/screens/sign_in/sign_in_screen.dart';
import 'package:techies_battle/size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  String? token;

  void _getDataFromSharedPre() async {
    final pref = await SharedPreferences.getInstance();
    final receivedToken = pref.getString("token");
    if (receivedToken != null) {
      token = receivedToken;
      tokenConstant = receivedToken;
    } else {
      token = null;
    }
  }

  @override
  void initState() {
    _getDataFromSharedPre();
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    Timer(const Duration(seconds: 3), () {
      if (token == null) {
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image(
                image: const AssetImage(
                  "assets/images/tech_logo.png",
                ),
                width: getProportionateScreenHeight(200),
                height: getProportionateScreenHeight(200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
