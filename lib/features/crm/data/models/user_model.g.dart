// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as int,
      created: DateTime.parse(json['created'] as String),
      avatar: json['avatar'] as String?,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'roles': instance.roles,
      'status': instance.status,
      'created': instance.created.toIso8601String(),
      'avatar': instance.avatar,
      'verified': instance.verified,
    };
