// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['fullName'] as String?,
      json['email'] as String?,
      json['dob'] as String?,
      json['phone'] as String?,
      json['password'] as String?,
      json['avatar'] as String?,
      userId: json['userId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'dob': instance.dob,
      'phone': instance.phone,
      'password': instance.password,
      'avatar': instance.avatar,
    };
