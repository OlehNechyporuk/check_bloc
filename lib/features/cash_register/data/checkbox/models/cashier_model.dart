import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/models/organization_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';

part 'cashier_model.g.dart';

@JsonSerializable()
class CashierModel extends CashierEntity {
  @JsonKey(name: 'organization')
  final OrganaizationModel? organizationModel;

  const CashierModel({
    required super.id,
    required super.fullName,
    required super.nin,
    required super.keyId,
    required super.signatureType,
    required super.permissions,
    required super.createdAt,
    required super.updatedAt,
    required super.certificateEnd,
    required super.blocked,
    required this.organizationModel,
  }) : super(organization: organizationModel);

  factory CashierModel.fromJson(Map<String, dynamic> json) =>
      _$CashierModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashierModelToJson(this);
}
