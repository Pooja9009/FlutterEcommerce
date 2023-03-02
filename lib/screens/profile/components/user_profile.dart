import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/data/remote_data_source/response/user_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/remote_user_repository.dart';
import 'package:techies_battle/screens/profile/components/change_password.dart';
import 'package:techies_battle/screens/profile/components/update_profile.dart';
import 'package:techies_battle/screens/sign_in/sign_in_screen.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';
import 'package:techies_battle/size_config.dart';


import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      child: Column(
        children: [
          // const ProfilePic(),
          getUserProfile(context),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, UpdateProfileScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Lock.svg",
            press: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Favorite",
            icon: "assets/icons/Heart Icon.svg",
            press: () {},
          ),
          // ProfileMenu(
          //   text: "Help Center",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              showAlertDialog(context);
            },
          ),
          ProfileMenu(
            text: "Delete Account",
            icon: "assets/icons/Trash.svg",
            press: () {
              deletAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  FutureBuilder<UserProfileResponse?> getUserProfile(isDark) {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;

            return Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(155),
                  width: getProportionateScreenHeight(155),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData.avatar!),
                      ),
                      Positioned(
                        right: getProportionateScreenHeight(-16),
                        bottom: 0,
                        child: SizedBox(
                          height: getProportionateScreenHeight(46),
                          width: getProportionateScreenHeight(46),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(50)),
                                side: const BorderSide(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xFFF5F6F9),
                            ),
                            onPressed: () {},
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  userData.fullName!,
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.bold),
                ),
                Text(userData.email!,
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(14))),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      },
    ).show();
  }

  void deletAlertDialog(BuildContext context) {
    AwesomeDialog(
      width: getProportionateScreenHeight(400),
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Delete Profile",
      titleTextStyle: TextStyle(fontSize: getProportionateScreenHeight(20)),
      desc: "Your account will be delete permanently!!",
      descTextStyle: TextStyle(fontSize: getProportionateScreenHeight(15)),
      autoHide: const Duration(seconds: 3),
      buttonsTextStyle: TextStyle(
        fontSize: getProportionateScreenHeight(17),
        color: Colors.white,
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await UserRepository().deleteUserProfile();
        showSnackbar(context, "Account Delete Successfully", Colors.green);
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      },
    ).show();
  }
}
