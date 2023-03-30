// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      goods: (json['goods'] as List<dynamic>?)
          ?.map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSum: json['total_sum'] as int?,
      totalPayment: json['total_payment'] as int?,
      totalRest: json['total_rest'] as int?,
      roundSum: json['round_sum'] as int?,
      discounts: (json['discounts'] as List<dynamic>?)
              ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bonuses: (json['bonuses'] as List<dynamic>?)
              ?.map((e) => Bonus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => ReceiptPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      shift: json['shift'] == null
          ? null
          : Shift.fromJson(json['shift'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'goods': instance.goods,
      'total_sum': instance.totalSum,
      'total_payment': instance.totalPayment,
      'total_rest': instance.totalRest,
      'round_sum': instance.roundSum,
      'discounts': instance.discounts,
      'bonuses': instance.bonuses,
      'payments': instance.payments,
      'rounding': instance.rounding,
      'fiscal_code': instance.fiscalCode,
      'fiscal_date': instance.fiscalDate?.toIso8601String(),
      'delivered_at': instance.deliveredAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'shift': instance.shift,
    };
