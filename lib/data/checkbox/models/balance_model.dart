import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/domain/entity/balance_entity.dart';

part 'balance_model.g.dart';

@JsonSerializable()
class BalanceModel extends BalanceEntity {
  const BalanceModel({
    required super.initial,
    required super.balance,
    required super.cashSales,
    required super.cardSales,
    required super.discountsSum,
    required super.extraChargeSum,
    required super.cashReturns,
    required super.cardReturns,
    required super.serviceIn,
    required super.serviceOut,
    required super.updatedAt,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);
}
