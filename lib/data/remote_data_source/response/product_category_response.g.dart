// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryResponse _$ProductCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..message = json['message'] as String?;

Map<String, dynamic> _$ProductCategoryResponseToJson(
        ProductCategoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
