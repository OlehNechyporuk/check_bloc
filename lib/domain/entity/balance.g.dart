// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      initial: json['initial'] as int,
      balance: json['balance'] as int,
      cashSales: json['cash_sales'] as int,
      cardSales: json['card_sales'] as int,
      discountsSum: json['discounts_sum'] as int?,
      extraChargeSum: json['extra_charge_sum'] as int?,
      cashReturns: json['cash_returns'] as int,
      cardReturns: json['card_returns'] as int,
      serviceIn: json['service_in'] as int,
      serviceOut: json['service_out'] as int,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) {
  final val = <String, dynamic>{
    'initial': instance.initial,
    'balance': instance.balance,
    'cash_sales': instance.cashSales,
    'card_sales': instance.cardSales,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('discounts_sum', instance.discountsSum);
  writeNotNull('extra_charge_sum', instance.extraChargeSum);
  val['cash_returns'] = instance.cashReturns;
  val['card_returns'] = instance.cardReturns;
  val['service_in'] = instance.serviceIn;
  val['service_out'] = instance.serviceOut;
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}
