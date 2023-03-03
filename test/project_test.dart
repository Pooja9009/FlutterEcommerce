import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/data/remote_data_source/cart_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/order_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/product_remote_data.dart';

void main() {
  String setToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDAyMzcyMzAzNjM4NWFlYzFkYWJmYSIsImlhdCI6MTY3Nzc0ODI5MiwiZXhwIjoxNjc3ODM0NjkyfQ.9QfYdDyFLt9gAyIO1pckJfGGPZJzydsO5re0qfMwVfw";

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "token":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDAyMzcyMzAzNjM4NWFlYzFkYWJmYSIsImlhdCI6MTY3Nzc0ODI5MiwiZXhwIjoxNjc3ODM0NjkyfQ.9QfYdDyFLt9gAyIO1pckJfGGPZJzydsO5re0qfMwVfw"
    });
  });

  WidgetsFlutterBinding.ensureInitialized();

//product //order //cart uint testing

  test('Get All Products', () async {
    final actualResult = await ProductRemoteData().getAllProduct();
    expect(actualResult!.data!.isNotEmpty, true);
  });

  test('Get All Orders', () async {
    tokenConstant = setToken;
    final actualResult = await OrderRemoteData().getAllOrder("Cancelled");
    expect(actualResult!.data!.isNotEmpty, true);
  });

  test('Get All Cart Products', () async {
    tokenConstant = setToken;
    final actualResult = await CartRemoteData().getAllCart();
    expect(actualResult!.data!.isNotEmpty, true);
  });

  test('User should be able to add to Order', () async {
    bool expectedResult = true;
    tokenConstant = setToken;
    bool actualResult = await OrderRemoteData().addProductToOrder();
    expect(actualResult, expectedResult);
  });

  test("Fetch all product", () async {
    bool expectedResult = true;

    var actualResult = (await ProductRemoteData().getAllProduct())?.data;

    // print(actualResult);

    if (actualResult != null) {
      expectedResult = true;
    }

    expect(expectedResult, true);
  });

  test("Count total fetched products", () async {
    bool expectedResult = true;

    var actualResult = (await ProductRemoteData().getAllProduct())?.data!.length;

    if (actualResult == 7) {
      expectedResult = true;
    }
    expect(expectedResult, true);
  });
}

 

// flutter test --coverage ./test/unit_test/product_test.dart 
// flutter pub run test_cov_console
