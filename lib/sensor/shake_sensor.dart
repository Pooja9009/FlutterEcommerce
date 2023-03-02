import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/routes.dart';
import 'package:techies_battle/screens/sign_in/sign_in_screen.dart';
import 'package:techies_battle/screens/splash/splash_screen.dart';
import 'package:techies_battle/theme.dart';

class ShakeSensor extends StatefulWidget {
  const ShakeSensor({Key? key}) : super(key: key);

  @override
  State<ShakeSensor> createState() => _ShakeSensorState();
}

class _ShakeSensorState extends State<ShakeSensor> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    listenSensor();

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
      // setState(() {});
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    _streamSubscription.cancel();
    super.dispose();
  }

  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  Future<void> listenSensor() async {
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        print("IS NEAR -->$_isNear");
      });
      if (_isNear == true) {
        // show logout alert dialog
        showAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: theme(),
      // home: const WearOsLoginScree(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      },
    ).show();
  }
}
