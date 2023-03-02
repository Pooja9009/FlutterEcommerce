import 'package:flutter/material.dart';
import 'package:techies_battle/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      // bottomNavigationBar: DashboardScreen(),
    );
  }
}
