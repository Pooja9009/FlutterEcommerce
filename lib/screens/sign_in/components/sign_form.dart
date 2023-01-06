import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/app/utils/notification.dart';
import 'package:techies_battle/components/custom_surfix_icon.dart';
import 'package:techies_battle/components/dashboard.dart';
import 'package:techies_battle/components/form_error.dart';
import 'package:techies_battle/helper/keyboard.dart';
import 'package:techies_battle/repository/remote_repository/remote_user_repository.dart';
import 'package:techies_battle/screens/forgot_password/forgot_password_screen.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: "9808792123");
  final _passwordController = TextEditingController(text: "password123");

  _loginUserWithAPI(String phoneNumber, String password) async {
    final isNewUserLogin =
        await UserRepository().loginUser(phoneNumber, password);
    // _showMessage(isNewUserLogin!);

    if (isNewUserLogin == true) {
      MyNotification.showNotification(
          notificationTitle: "Login",
          notificationMessage: "You are successfully logged in");
      // Success Login
      showSnackbar(context, "Login Success!", Colors.green);
      Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
    } else {
      // Login Failed
      showSnackbar(context, "Invalid Credentials!", Colors.red);
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

  // Finger Sensor
  bool authenticated = false;
  //FingerPrint setup
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometric;

  List<BiometricType>? _availableBiometrics;
  String authorized = "Not authorized";

  Future<void> _checkBiometric() async {
    bool? canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometric;

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() async {
      authorized =
          authenticated ? "Authorization Successful" : "Failed to authenticate";

      if (authenticated) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? val = pref.getString("token");
        // // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, HomePage.route);

        if (val != null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            ),
          );
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: "Logged In",
              body: "You are now logged in to your account!",
            ),
          );
        } else if (val == null) {
          // ignore: use_build_context_synchronously
          return MotionToast.error(
            description: const Text(
                "Sorry No Token Found, Login Using your Credentials!"),
          ).show(context);
        }
      }
      print(authorized);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                _loginUserWithAPI(
                    _phoneController.text, _passwordController.text);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Text(
            "Or",
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
          TextButton(
              onPressed: () {
                _authenticate();
              },
              child: Text(
                "Login Fingerprint",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenHeight(17)),
              )),
        ],
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _phoneController,
      // keyboardType: TextInputType.emailAddress,
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
        // else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
