
import 'package:json_annotation/json_annotation.dart';
import 'package:techies_battle/model/export_model.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  String? id;
  String? userId;
  Product? foodId;
  int? quantity;

  Cart({this.id, this.userId, this.foodId, this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
