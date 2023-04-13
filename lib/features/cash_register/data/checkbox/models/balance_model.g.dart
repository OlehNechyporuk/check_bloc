// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) => BalanceModel(
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

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'initial': instance.initial,
      'balance': instance.balance,
      'cash_sales': instance.cashSales,
      'card_sales': instance.cardSales,
      'discounts_sum': instance.discountsSum,
      'extra_charge_sum': instance.extraChargeSum,
      'cash_returns': instance.cashReturns,
      'card_returns': instance.cardReturns,
      'service_in': instance.serviceIn,
      'service_out': instance.serviceOut,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
