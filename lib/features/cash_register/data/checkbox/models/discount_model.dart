import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/discount_entity.dart';

part 'discount_model.g.dart';

@JsonSerializable()
class DiscountModel extends DiscountEntity {
  const DiscountModel({
    required super.type,
    required super.mode,
    required super.value,
    required super.taxCode,
    required super.taxCodes,
    required super.name,
    required super.privilege,
    required super.sum,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountModelToJson(this);
}
