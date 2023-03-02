import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{
  @JsonKey(name: "_id")
  String? id;
  String title;
  String description;
  String price;
  List foodPhoto;
  // List category;
  String createAt;

  Product(
      this.title, this.description, this.price, this.foodPhoto, this.createAt,
      [this.id]);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
