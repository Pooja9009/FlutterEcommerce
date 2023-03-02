import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techies_battle/screens/home/home_screen.dart';
import 'package:techies_battle/screens/order/order_screen.dart';


import '../screens/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);
  static String routeName = "/dashboard";

  static const String route = "dashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  final List<Widget> _lstScreen = [
    const HomeScreen(),
    const OrderScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _lstScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
            ),
            label: 'faviroite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/Bell.svg"),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/User Icon.svg"),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color(0xFFB6B6B6),
        // backgroundColor: HexColor.fromHex("#ED9728"),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
