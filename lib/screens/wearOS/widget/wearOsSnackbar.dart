import 'package:flutter/material.dart';

wearOsShowSnackbar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(
      //   label: 'dismiss',
      //   onPressed: () {},
      // ),
    ),
  );
}
