import 'package:dio/dio.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/app/constraint/http_service.dart';
import 'package:techies_battle/data/remote_data_source/response/product_category_response.dart';
import 'package:techies_battle/model/export_model.dart';


class ProductCatRemoteData {
  Future<bool> addProductCategory(ProductCategory productCategory) async {
    bool isProductCategoryAdded = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response =
          await dio.post(foodCategoryUrl, data: productCategory.toJson());
      // response.data
      final ProductCategoryResponse productCategoryResponseData =
          ProductCategoryResponse.fromJson(response.data);
      if (productCategoryResponseData.success == true) {
        isProductCategoryAdded = true;
        return isProductCategoryAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductCategoryAdded;
  }

  Future<ProductCategoryResponse?> getAllProductCategory() async {
    ProductCategoryResponse? productCategoryResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodCategoryUrl/get");
      // response.headers = Headers();
      // response.data
      productCategoryResponse = ProductCategoryResponse.fromJson(response.data);
      if (productCategoryResponse.success == true) {
        return productCategoryResponse;
      } else {
        productCategoryResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productCategoryResponse;
  }

}
