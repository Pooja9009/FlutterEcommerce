import 'package:flutter/material.dart';
import 'package:techies_battle/constants.dart';

class WearOsCartScreen extends StatefulWidget {
  const WearOsCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WearOsCartScreen> createState() => WearOsCartScreenState();
}

class WearOsCartScreenState extends State<WearOsCartScreen> {
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
          backgroundColor: kPrimaryColor,
        ),
        onPressed: () {},
        child: const Text(
          "My Cart",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
