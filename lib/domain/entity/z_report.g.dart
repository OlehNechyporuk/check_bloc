// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'z_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZReport _$ZReportFromJson(Map<String, dynamic> json) => ZReport(
      id: json['id'] as String?,
      serial: json['serial'] as int?,
      isZReport: json['is_z_report'] as bool?,
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxes: (json['taxes'] as List<dynamic>?)
          ?.map((e) => Tax.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellReceiptsCount: json['sell_receipts_count'] as int?,
      returnReceiptsCount: json['return_receipts_count'] as int?,
      cashWithdrawalReceiptsCount:
          json['cash_withdrawal_receipts_count'] as int?,
      transfersCount: json['transfers_count'] as int?,
      transfersSum: json['transfers_sum'] as int?,
      balance: json['balance'] as int?,
      initial: json['initial'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      discountsSum: json['discounts_sum'] as int?,
      extraChargeSum: json['extra_charge_sum'] as int?,
      transactionFail: json['transaction_fail'] as bool?,
    );

Map<String, dynamic> _$ZReportToJson(ZReport instance) => <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'is_z_report': instance.isZReport,
      'payments': instance.payments,
      'taxes': instance.taxes,
      'sell_receipts_count': instance.sellReceiptsCount,
      'return_receipts_count': instance.returnReceiptsCount,
      'cash_withdrawal_receipts_count': instance.cashWithdrawalReceiptsCount,
      'transfers_count': instance.transfersCount,
      'transfers_sum': instance.transfersSum,
      'balance': instance.balance,
      'initial': instance.initial,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'discounts_sum': instance.discountsSum,
      'extra_charge_sum': instance.extraChargeSum,
      'transaction_fail': instance.transactionFail,
    };
