
import 'package:techies_battle/data/remote_data_source/order_remote_data.dart';
import 'package:techies_battle/data/remote_data_source/response/order_response.dart';

class OrderRepository {
  Future<bool> addProductToOrder() async {
    return await OrderRemoteData().addProductToOrder();
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    return await OrderRemoteData().getAllOrder(status);
  }

  Future<bool?> deleteProductFromOrder(String foodId) async {
    return await OrderRemoteData().deleteOrder(foodId);
  }

  Future<bool?> cancelOrder(String orderId) async {
    return await OrderRemoteData().cancelOrder(orderId);
  }
}
