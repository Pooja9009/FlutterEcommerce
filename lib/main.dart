import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/sensor/shake_sensor.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey:
            'basic_channel', //shown when enabling permission in the setting
        channelName: 'basic_channel', //name shown in setting
        defaultColor: kPrimaryColor, //default color of the notification
        importance:
            NotificationImportance.High, //display notification on screen
        channelShowBadge:
            true, // to show number of notification badge on app icon
        // locked: false,
        channelDescription: 'test',
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_bcbec49746364b548f9cf8ab6f0e097d",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            home: const ShakeSensor(),
          );
        });
  }
}
