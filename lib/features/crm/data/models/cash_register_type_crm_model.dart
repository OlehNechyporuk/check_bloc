import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';

part 'cash_register_type_crm_model.g.dart';

@JsonSerializable()
class CashRegisterTypeCrmModel extends CashRegisterTypeCrmEntity {
  const CashRegisterTypeCrmModel({
    required super.id,
    required super.title,
    required super.logo,
    required super.status,
  });

  factory CashRegisterTypeCrmModel.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterTypeCrmModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterTypeCrmModelToJson(this);
}
