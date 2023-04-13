// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      roles: json['roles'] as String,
      status: json['status'] as int,
      created: DateTime.parse(json['created'] as String),
      avatar: json['avatar'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'roles': instance.roles,
      'status': instance.status,
      'created': instance.created.toIso8601String(),
      'avatar': instance.avatar,
      'verified': instance.verified,
    };
