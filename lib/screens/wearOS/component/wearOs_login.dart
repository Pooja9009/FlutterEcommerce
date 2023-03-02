import 'package:flutter/material.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/helper/keyboard.dart';
import 'package:techies_battle/repository/remote_repository/remote_user_repository.dart';
import 'package:techies_battle/screens/wearOS/component/wearOs_dashboard.dart';
import 'package:techies_battle/screens/wearOS/widget/wearOsSnackbar.dart';

class WearOsLoginScree extends StatefulWidget {
  const WearOsLoginScree({
    Key? key,
  }) : super(key: key);
  static String routeName = "/wearOsLogin";

  @override
  State<WearOsLoginScree> createState() => _WearOsLoginScreeState();
}

class _WearOsLoginScreeState extends State<WearOsLoginScree> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: "9808792123");
  final _passwordController = TextEditingController(text: "password123");

  _loginUserWithAPI(String phoneNumber, String password) async {
    final isNewUserLogin =
        await UserRepository().loginUser(phoneNumber, password);
    // _showMessage(isNewUserLogin!);

    if (isNewUserLogin == true) {
      // Success Login
      wearOsShowSnackbar(context, "Login Success!", Colors.green);
      Navigator.pushReplacementNamed(context, WearOsDashboard.routeName);
    } else {
      // Login Failed
      wearOsShowSnackbar(context, "Invalid Credentials!", Colors.red);
    }
  }

  String? phone;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  buildEmailFormField(),
                  const SizedBox(height: 15),
                  buildPasswordFormField(),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          _loginUserWithAPI(
                              _phoneController.text, _passwordController.text);
                          // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        hintText: "Enter your phone number",

        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
