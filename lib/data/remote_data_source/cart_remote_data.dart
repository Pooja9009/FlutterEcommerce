import 'dart:io';

import 'package:dio/dio.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/app/constraint/http_service.dart';
import 'package:techies_battle/data/remote_data_source/response/cart_response.dart';

class CartRemoteData {
  Future<bool> addProductToCart(String foodId, String quantity) async {
    bool isProductAddedToCart = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.post("$cartUrl/insert/$foodId/$quantity",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final CartResponse cartResponseData =
          CartResponse.fromJson(response.data);
      if (cartResponseData.success == true) {
        isProductAddedToCart = true;
        return isProductAddedToCart;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductAddedToCart;
  }

  Future<CartResponse?> getAllCart() async {
    CartResponse? cartResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$cartUrl/get",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      cartResponse = CartResponse.fromJson(response.data);
      if (cartResponse.success == true) {
        return cartResponse;
      } else {
        cartResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return cartResponse;
  }

    Future<bool> deleteCart(String foodId) async {
      bool isCartDelete = false;
      Dio dio = HttpServices().getDioInstance();
      try {
        // dio ko response
        Response response = await dio.delete("$cartUrl/delete/$foodId",
            options: Options(headers: {
              HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
            }));

        final CartResponse cartResponseData =
            CartResponse.fromJson(response.data);
        if (cartResponseData.success == true) {
          isCartDelete = true;
          return isCartDelete;
        }
      } catch (exception) {
        print(exception);
      }
      return isCartDelete;
    }
}
