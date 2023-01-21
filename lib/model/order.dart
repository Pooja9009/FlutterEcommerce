
import 'package:json_annotation/json_annotation.dart';
import 'package:techies_battle/model/export_model.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "_id")
  String? id;
  User? userId;
  Product? foodId;
  int? orderedQty;
  int? totalPrice;
  String? deliveryStatusMessage;
  String? deliveryDate;

  Order(
      {this.id,
      this.userId,
      this.foodId,
      this.orderedQty,
      this.totalPrice,
      this.deliveryStatusMessage,
      this.deliveryDate});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
