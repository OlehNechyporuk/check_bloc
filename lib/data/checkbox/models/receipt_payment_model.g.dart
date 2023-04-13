// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptPaymentModel _$ReceiptPaymentModelFromJson(Map<String, dynamic> json) =>
    ReceiptPaymentModel(
      type: json['type'] as String,
      value: json['value'] as int?,
      label: json['label'] as String,
    );

Map<String, dynamic> _$ReceiptPaymentModelToJson(
        ReceiptPaymentModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'label': instance.label,
    };
