import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/tax_entity.dart';

part 'tax_model.g.dart';

@JsonSerializable()
class TaxModel extends TaxEntity {
  const TaxModel({
    required super.id,
    required super.code,
    required super.label,
    required super.symbol,
    required super.rate,
    required super.extraRate,
    required super.included,
    required super.createdAt,
    required super.updatedAt,
    required super.noVat,
    required super.advancedCode,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) =>
      _$TaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaxModelToJson(this);
}
