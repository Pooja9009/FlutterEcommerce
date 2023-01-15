import 'package:json_annotation/json_annotation.dart';
import 'package:techies_battle/model/product_category.dart';

part 'product_category_response.g.dart';

@JsonSerializable()
class ProductCategoryResponse {
  bool? success;
  String? message;
  List<ProductCategory>? data;

  ProductCategoryResponse({this.success, this.data});

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryResponseToJson(this);
}
