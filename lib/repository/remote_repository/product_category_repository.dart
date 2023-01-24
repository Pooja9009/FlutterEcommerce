
import 'package:techies_battle/data/remote_data_source/product_category_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/response/product_category_response.dart';
import 'package:techies_battle/model/export_model.dart';

class ProductCatRepository {
  Future<bool> addProductCategory(ProductCategory productCategory) async {
    return await ProductCatRemoteData().addProductCategory(productCategory);
  }

  Future<ProductCategoryResponse?> getAllProductCategory() async {
    return await ProductCatRemoteData().getAllProductCategory();
  }
}
