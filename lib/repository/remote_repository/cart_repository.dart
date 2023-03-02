
import 'package:techies_battle/data/remote_data_source/cart_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/response/cart_response.dart';

class CartRepository {
  Future<bool> addProductToCart(String foodId, String quantity) async {
    return await CartRemoteData().addProductToCart(foodId, quantity);
  }

  Future<CartResponse?> getAllCart() async {
    return await CartRemoteData().getAllCart();
  }

  Future<bool?> deleteProductFromCart(String foodId) async {
    return await CartRemoteData().deleteCart(foodId);
  }
}
