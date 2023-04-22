import 'package:check_bloc/features/crm/data/models/cash_register_type_crm_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';

part 'cash_register_crm_model.g.dart';

@JsonSerializable()
class CashRegisterCrmModel extends CashRegisterCrmEntity {
  @JsonKey(name: 'type')
  final CashRegisterTypeCrmModel modelType;

  const CashRegisterCrmModel({
    required super.id,
    required super.title,
    required this.modelType,
  }) : super(type: modelType);

  factory CashRegisterCrmModel.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterCrmModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterCrmModelToJson(this);
}
