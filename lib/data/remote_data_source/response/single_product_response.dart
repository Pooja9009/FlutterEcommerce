import 'package:json_annotation/json_annotation.dart';
import 'package:techies_battle/model/export_model.dart';

part 'single_product_response.g.dart';

@JsonSerializable()
class SingleProductResponse {
  bool? success;
  String? message;
  Product? data;

  SingleProductResponse({this.success, this.message, this.data});

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleProductResponseToJson(this);
}
