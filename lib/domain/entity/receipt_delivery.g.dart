// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptDelivery _$ReceiptDeliveryFromJson(Map<String, dynamic> json) =>
    ReceiptDelivery(
      email: json['email'] as String?,
      emails:
          (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ReceiptDeliveryToJson(ReceiptDelivery instance) =>
    <String, dynamic>{
      'email': instance.email,
      'emails': instance.emails,
      'phone': instance.phone,
    };
