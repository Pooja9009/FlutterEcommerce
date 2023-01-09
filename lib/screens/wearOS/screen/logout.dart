import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/screens/wearOS/component/wearOs_login.dart';
import 'package:techies_battle/screens/wearOS/widget/wearOsSnackbar.dart';

class WearOsLogoutScreen extends StatefulWidget {
  const WearOsLogoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WearOsLogoutScreen> createState() => WearOsLogoutScreenState();
}

class WearOsLogoutScreenState extends State<WearOsLogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.red,
        ),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.clear();
          Navigator.pushReplacementNamed(context, WearOsLoginScree.routeName);
          wearOsShowSnackbar(context, "Logout Successfully!", Colors.redAccent);
        },
        child: const Text(
          "Log Out",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
