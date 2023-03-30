import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable(includeIfNull: false)
class Balance extends Equatable {
  final int initial;
  final int balance;
  @JsonKey(name: 'cash_sales')
  final int cashSales;
  @JsonKey(name: 'card_sales')
  final int cardSales;
  @JsonKey(name: 'discounts_sum')
  final int? discountsSum;
  @JsonKey(name: 'extra_charge_sum')
  final int? extraChargeSum;
  @JsonKey(name: 'cash_returns')
  final int cashReturns;
  @JsonKey(name: 'card_returns')
  final int cardReturns;
  @JsonKey(name: 'service_in')
  final int serviceIn;
  @JsonKey(name: 'service_out')
  final int serviceOut;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Balance({
    required this.initial,
    required this.balance,
    required this.cashSales,
    required this.cardSales,
    required this.discountsSum,
    required this.extraChargeSum,
    required this.cashReturns,
    required this.cardReturns,
    required this.serviceIn,
    required this.serviceOut,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      initial,
      balance,
      cashSales,
      cardSales,
      discountsSum,
      extraChargeSum,
      cashReturns,
      cardReturns,
      serviceIn,
      serviceOut,
      updatedAt,
    ];
  }

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);
}
