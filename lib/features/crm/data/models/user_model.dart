import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.phone,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.roles,
    required super.status,
    required super.created,
    required super.avatar,
    required super.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
