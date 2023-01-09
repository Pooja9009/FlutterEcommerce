import 'package:flutter/material.dart';
import 'package:techies_battle/constants.dart';

class WearOsOrderScreen extends StatefulWidget {
  const WearOsOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WearOsOrderScreen> createState() => WearOsOrderScreenState();
}

class WearOsOrderScreenState extends State<WearOsOrderScreen> {
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
          "My Order",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
