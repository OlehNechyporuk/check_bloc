import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/organization_entity.dart';

part 'organization_model.g.dart';

@JsonSerializable()
class OrganaizationModel extends OrganizationEntity {
  const OrganaizationModel({
    required super.id,
    required super.title,
    required super.edrpou,
    required super.taxNumber,
    required super.createdAt,
    required super.updatedAt,
    required super.subscriptionExp,
    required super.concordLogin,
    required super.concordUid,
    required super.receiptsRatelimitCount,
    required super.receiptsRatelimitInterval,
    required super.canSendSms,
    required super.useSeamlessMode,
  });

  factory OrganaizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganaizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganaizationModelToJson(this);
}
