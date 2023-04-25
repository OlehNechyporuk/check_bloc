// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      id: json['id'] as String?,
      type: json['type'] as String,
      status: json['status'] as String,
      receiptItems: (json['goods'] as List<dynamic>?)
              ?.map((e) => ReceiptItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalSum: json['total_sum'] as int,
      totalPayment: json['total_payment'] as int,
      totalRest: json['total_rest'] as int,
      roundSum: json['round_sum'] as int?,
      discountsModel: (json['discounts'] as List<dynamic>?)
              ?.map((e) => DiscountModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bonusesModel: (json['bonuses'] as List<dynamic>?)
              ?.map((e) => BonusModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      paymentsModel: (json['payments'] as List<dynamic>?)
              ?.map((e) =>
                  ReceiptPaymentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      rounding: json['rounding'] as bool?,
      fiscalCode: json['fiscal_code'] as String?,
      fiscalDate: json['fiscal_date'] == null
          ? null
          : DateTime.parse(json['fiscal_date'] as String),
      deliveredAt: json['delivered_at'] == null
          ? null
          : DateTime.parse(json['delivered_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'total_sum': instance.totalSum,
      'total_payment': instance.totalPayment,
      'total_rest': instance.totalRest,
      'round_sum': instance.roundSum,
      'rounding': instance.rounding,
      'fiscal_code': instance.fiscalCode,
      'fiscal_date': instance.fiscalDate?.toIso8601String(),
      'delivered_at': instance.deliveredAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'goods': instance.receiptItems,
      'discounts': instance.discountsModel,
      'bonuses': instance.bonusesModel,
      'payments': instance.paymentsModel,
    };
