import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/data/remote_data_source/response/user_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/export_remote_repo.dart';
import 'package:techies_battle/screens/profile/widget/color_theme.dart';
import 'package:techies_battle/screens/profile/widget/header.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/updateProfile";

  @override
  State<StatefulWidget> createState() {
    return _UpdateProfileScreenState();
  }
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  File? uploadImage;

  final _fullNameController = TextEditingController(text: "Test");
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  Widget showUploadedImage(File? pickedImageFile) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.purple, width: 3),
      ),
      color: Colors.red,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              pickedImageFile == null
                  ? Image.asset("images/upload.png")
                  : Image.file(
                      pickedImageFile,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          uploadImage = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      print("Failed to upload Image");
    }
  }

  void showAlertDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () => loadImage(FROM_GALLERY),
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                ElevatedButton.icon(
                    onPressed: () => loadImage(FROM_CAMERA),
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  void setInitialData() async {
    final response = await UserRepository().getUserProfile();
    _fullNameController.text = response!.data!.fullName!;
    _emailController.text = response.data!.email!;
    _phoneController.text = response.data!.phone!;
    _dobController.text = response.data!.dob!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "Update Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            setUserProfile(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<UserProfileResponse?> setUserProfile() {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;

            return Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 30 * 4,
                                height: 40 * 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50 * 2),
                                  child: uploadImage == null
                                      ? Image.network(
                                          userData.avatar!,
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                        )
                                      : Image.file(
                                          uploadImage!,
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                        ),
                                ),
                              ),
                              Positioned(
                                right: -16,
                                bottom: 0,
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: const Color(0xFFF5F6F9),
                                    ),
                                    onPressed: () {
                                      showAlertDialog(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/Camera Icon.svg"),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     showAlertDialog(context);
                              //   },
                              //   child: Container(
                              //     padding:
                              //         const EdgeInsets.fromLTRB(80, 80, 0, 0),
                              //     child: Container(
                              //       height: 40,
                              //       width: 40,
                              //       decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(50 * 2)),
                              //       child: const Icon(
                              //         LineAwesomeIcons.camera,
                              //         color: Colors.red,
                              //         size: 30,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: _fullNameController,
                            decoration: ThemeHelper().textInputDecoration(
                              'Full Name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: _emailController,
                            readOnly: true,
                            decoration: ThemeHelper().textInputDecoration(
                              "E-mail address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: _phoneController,
                            readOnly: true,
                            decoration: ThemeHelper().textInputDecoration(
                              "Mobile Number",
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: _dobController,
                            decoration: ThemeHelper().textInputDecoration(
                              "DOB",
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  _dobController.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Update".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              User user = User(
                                  _fullNameController.text,
                                  _emailController.text,
                                  _dobController.text,
                                  _phoneController.text,
                                  "",
                                  "");
                              bool result = false;
                              uploadImage == null
                                  ? result = await UserRepository()
                                      .updateUserProfile(user)
                                  : result = await UserRepository()
                                      .updateUserProfileWithImage(
                                          user, uploadImage!);
                              if (result == true) {
                                showSnackbar(
                                    context,
                                    "Profile Updated Successfully",
                                    Colors.green);
                              } else {
                                showSnackbar(context,
                                    "Failed to Updated Profile", Colors.red);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
