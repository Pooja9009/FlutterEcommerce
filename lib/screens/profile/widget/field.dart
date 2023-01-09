import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePasswordField extends StatefulWidget {
  const ProfilePasswordField(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.validator,
      this.inputFormatter,
      this.errorText,
      this.controller})
      : super(key: key);

  final String? hintText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final String? errorText;
  final controller;

  @override
  State<ProfilePasswordField> createState() => _ProfilePasswordFieldState();
}

class _ProfilePasswordFieldState extends State<ProfilePasswordField> {
  final TextEditingController controller = TextEditingController();
  bool isHidden = true;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        cursorColor: Colors.red,
        obscureText: isHidden,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 22),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
              borderRadius: BorderRadius.circular(30)),
          errorText: widget.validator != null ? null : widget.errorText,
          errorStyle: const TextStyle(fontSize: 14),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.lock, size: 24, color: Colors.black),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontFamily: 'OpenSans', color: Colors.black, fontSize: 17),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: isHidden
                  ? const Icon(
                      Icons.visibility_off,
                      size: 24,
                      color: Colors.black,
                    )
                  : const Icon(Icons.visibility, size: 24, color: Colors.black),
              onPressed: togglePasswordVisibility,
              // color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
