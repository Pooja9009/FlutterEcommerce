// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleProductResponse _$SingleProductResponseFromJson(
        Map<String, dynamic> json) =>
    SingleProductResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Product.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleProductResponseToJson(
        SingleProductResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
