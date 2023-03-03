import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/data/remote_data_source/user_remote_data.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/export_remote_repo.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "login":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZWUxZTNmZDVlYzMwMzhhYjc0MjhhMCIsImlhdCI6MTY3NjU2MjEyOSwiZXhwIjoxNjc2NjQ4NTI5fQ.Unde-U2EJ_iiL6KoxRdnIYLylSUHq9Q6Yi8E1e-BtKM"
    });
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('User should be able to log in', () async {
    bool expectedResult = true;
    String phone = "9845876427";
    String password = "pooja@123";
    bool actualResult = await UserRemoteDataSource().loginUser(phone, password);
    expect(actualResult, expectedResult);
  });

  test('user registration', () async {
    bool expectedResult = true;
    User user = User(
        'laxmi rijal', 'laxmi@gmail.com', '', '1234567890', 'pooja@123', '');
    final actualResult = await UserRepository().registerUser(user);
    expect(expectedResult, actualResult);
  });
}
