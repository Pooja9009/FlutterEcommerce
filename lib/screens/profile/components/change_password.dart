import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/repository/remote_repository/remote_user_repository.dart';
import 'package:techies_battle/screens/profile/widget/color_theme.dart';
import 'package:techies_battle/screens/profile/widget/field.dart';
import 'package:techies_battle/screens/sign_in/sign_in_screen.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static String routeName = "/changePassword";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            padding: const EdgeInsets.only(top: 30 / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        // child:
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    Container(
                      // padding: EdgeInsets.only(top: Dimensions.height30),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: ,
                    // ),
                    Container(
                      // padding: EdgeInsets.only(top: Dimensions.height30),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Center(
                        child: Text(
                          'Hell',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ProfilePasswordField(
                        controller: _oldPasswordController,
                        hintText: 'Enter your old password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfilePasswordField(
                        controller: _newPasswordController,
                        hintText: 'Enter your new password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfilePasswordField(
                        controller: _confirmPasswordController,
                        hintText: 'Re-Enter the new password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Password does not match';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_confirmPasswordController.text ==
                                    _newPasswordController.text) {
                                  final result = await UserRepository()
                                      .changePassword(
                                          _oldPasswordController.text,
                                          _newPasswordController.text);
                                  if (result) {
                                    // Success Login
                                    showSnackbar(
                                        context,
                                        "Password Changed Successfully!",
                                        Colors.green);
                                    doLogout();
                                  } else {
                                    // Login Failed
                                    showSnackbar(context,
                                        "Invalid Old Password!", Colors.red);
                                  }
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Change Password',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void doLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showSnackbar(context, "Logout Successfully!", Colors.orange);
    pref.clear();
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
