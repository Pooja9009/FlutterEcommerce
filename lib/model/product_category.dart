import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  @JsonKey(name: "_id")
  String? id;
  String foodCategoryTitle;
  String foodCategoryImageUrl;
  String foodCategoryCreateAt;

  ProductCategory(this.foodCategoryTitle, this.foodCategoryImageUrl,
      this.foodCategoryCreateAt,
      {this.id});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
