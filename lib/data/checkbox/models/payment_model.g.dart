// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['id'] as String,
      code: json['code'] as int,
      type: json['type'] as String,
      providerType: json['provider_type'] as String,
      label: json['label'] as String,
      sellSum: json['sell_sum'] as int,
      returnSum: json['return_sum'] as int,
      serviceIn: json['service_in'] as int,
      serviceOut: json['service_out'] as int,
      cashWithdrawal: json['cash_withdrawal'] as int,
      cashWithdrawalCommission: json['cash_withdrawal_commission'] as int,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'type': instance.type,
      'provider_type': instance.providerType,
      'label': instance.label,
      'sell_sum': instance.sellSum,
      'return_sum': instance.returnSum,
      'service_in': instance.serviceIn,
      'service_out': instance.serviceOut,
      'cash_withdrawal': instance.cashWithdrawal,
      'cash_withdrawal_commission': instance.cashWithdrawalCommission,
    };
