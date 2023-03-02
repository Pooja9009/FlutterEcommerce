import 'dart:io';

import 'package:dio/dio.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/app/constraint/http_service.dart';
import 'package:techies_battle/data/remote_data_source/response/order_response.dart';

class OrderRemoteData {
  Future<bool> addProductToOrder() async {
    bool isFoodAddedToOrder = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.post("$orderUrl/insert",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isFoodAddedToOrder = true;
        return isFoodAddedToOrder;
      }
    } catch (exception) {
      print(exception);
    }
    return isFoodAddedToOrder;
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    OrderResponse? orderResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$orderUrl/get/$status",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      orderResponse = OrderResponse.fromJson(response.data);
      if (orderResponse.success == true) {
        return orderResponse;
      } else {
        orderResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return orderResponse;
  }

  Future<bool> deleteOrder(String foodId) async {
    bool isOrderDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.delete("$orderUrl/delete/$foodId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderDelete = true;
        return isOrderDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderDelete;
  }

  Future<bool> cancelOrder(String orderId) async {
    bool isOrderCancelled = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.put("$orderUrl/update/$orderId/Cancelled",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderCancelled = true;
        return isOrderCancelled;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderCancelled;
  }
}
