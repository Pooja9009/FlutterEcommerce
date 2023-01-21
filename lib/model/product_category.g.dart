// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      json['foodCategoryTitle'] as String,
      json['foodCategoryImageUrl'] as String,
      json['foodCategoryCreateAt'] as String,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'foodCategoryTitle': instance.foodCategoryTitle,
      'foodCategoryImageUrl': instance.foodCategoryImageUrl,
      'foodCategoryCreateAt': instance.foodCategoryCreateAt,
    };
