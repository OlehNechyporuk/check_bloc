import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/bonus_entity.dart';

part 'bonus_model.g.dart';

@JsonSerializable()
class BonusModel extends BonusEntity {
  const BonusModel({required super.id});

  factory BonusModel.fromJson(Map<String, dynamic> json) =>
      _$BonusModelFromJson(json);

  Map<String, dynamic> toJson() => _$BonusModelToJson(this);
}
