// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      foodId: json['foodId'] == null
          ? null
          : Product.fromJson(json['foodId'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'foodId': instance.foodId,
      'quantity': instance.quantity,
    };
