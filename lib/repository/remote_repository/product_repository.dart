import 'dart:io';

import 'package:techies_battle/data/remote_data_source/product_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/data/remote_data_source/response/single_product_response.dart';
import 'package:techies_battle/model/export_model.dart';

class ProductRepository {
  Future<bool> addProduct(File? file, Product product) async {
    return await ProductRemoteData().addProduct(file, product);
  }

  Future<ProductResponse?> getAllProduct() async {
    return await ProductRemoteData().getAllProduct();
  }

  Future<SingleProductResponse?> getSingleProduct(String foodId) async {
    return await ProductRemoteData().getSingleProduct(foodId);
  }

  Future<ProductResponse?> getAllProductCategory(String categoryId) async {
    return await ProductRemoteData().getAllProductCategory(categoryId);
  }
}
