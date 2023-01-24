import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.wifi_off,
              size: 100,
            ),
            Text(
              'No Internet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text("Make sure you are connected to Internet!!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20))
          ],
        ));
  }
}
