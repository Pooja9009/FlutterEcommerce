import 'dart:io';

import 'package:techies_battle/data/remote_data_source/response/user_response.dart';
import 'package:techies_battle/data/remote_data_source/user_remote_data.dart';
import 'package:techies_battle/model/export_model.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserRemoteDataSource().registerUser(user);
  }

  Future<bool?> loginUser(String phoneNumber, String password) async {
    return await UserRemoteDataSource().loginUser(phoneNumber, password);
    // bool status = await NetworkConnectivity.isOnline();
    // if (status) {
    //   return UserAPI().loginUser(phoneNumber, password);
    // } else {
    //   return UserRepositoryImplementation().loginUser(phoneNumber, password);
    // }
  }

  Future<UserProfileResponse?> getUserProfile() async {
    return await UserRemoteDataSource().getUserProfile();
  }

  Future<bool> updateUserProfileWithImage(User user, File imageFile) async {
    return await UserRemoteDataSource()
        .updateUserProfileWithImage(user, imageFile);
  }

  Future<bool> updateUserProfile(User user) async {
    return await UserRemoteDataSource().updateUserProfile(user);
  }

  Future<bool?> deleteUserProfile() async {
    return await UserRemoteDataSource().deleteUser();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    return await UserRemoteDataSource()
        .changePassword(oldPassword, newPassword);
  }
}
