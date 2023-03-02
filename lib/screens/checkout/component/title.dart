import 'package:flutter/material.dart';

class TitleName extends StatefulWidget {
  final String? hintText;
  const TitleName({Key? key, this.hintText}) : super(key: key);

  @override
  State<TitleName> createState() => _TitleNameState();
}

class _TitleNameState extends State<TitleName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.hintText!,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
