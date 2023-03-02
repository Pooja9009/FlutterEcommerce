import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/app/constraint/http_service.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/data/remote_data_source/response/single_product_response.dart';
import 'package:techies_battle/model/export_model.dart';

class ProductRemoteData {
  Future<bool> addProduct(File? file, Product product) async {
    bool isProductAdded = false;
    Dio dio = HttpServices().getDioInstance();
    MultipartFile? productFinalImageFile;
    if (file != null) {
      var filePath = file.path;

      var mimeType = lookupMimeType(filePath);

      var image = await MultipartFile.fromFile(filePath,
          filename: filePath.split("/").last,
          contentType: MediaType("image", mimeType!.split("/").last));
      productFinalImageFile = image;
    }
    try {
      // dio ko response
      Map<String, dynamic> productMap = {
        "name": product.title,
        "description": product.description,
        "image": productFinalImageFile,
        "price": product.price,
      };
      var productFormData = FormData.fromMap(productMap);
      Response response = await dio.post(foodUrl,
          data: productFormData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final ProductResponse productResponseData =
          ProductResponse.fromJson(response.data);
      if (productResponseData.success == true) {
        isProductAdded = true;
        return isProductAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductAdded;
  }

  Future<ProductResponse?> getAllProduct() async {
    ProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get(foodUrl);
      // response.data
      productResponse = ProductResponse.fromJson(response.data);
      if (productResponse.success == true) {
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productResponse;
  }

  Future<SingleProductResponse?> getSingleProduct(String foodId) async {
    SingleProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodUrl/$foodId");
      // response.data
      productResponse = SingleProductResponse.fromJson(response.data);
      if (productResponse.success == true) {
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productResponse;
  }

  Future<ProductResponse?> getAllProductCategory(String categoryId) async {
    ProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodUrl/category/$categoryId");
      // response.data
      productResponse = ProductResponse.fromJson(response.data);
      if (productResponse.success == true) {
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productResponse;
  }
}
