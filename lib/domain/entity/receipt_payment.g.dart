// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptPayment _$ReceiptPaymentFromJson(Map<String, dynamic> json) =>
    ReceiptPayment(
      type: json['type'] as String?,
      value: json['value'] as int?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$ReceiptPaymentToJson(ReceiptPayment instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'label': instance.label,
    };
