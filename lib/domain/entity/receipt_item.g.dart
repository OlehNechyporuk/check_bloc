// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) => ReceiptItem(
      id: json['id'] as int?,
      good: json['good'] == null
          ? null
          : Good.fromJson(json['good'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      discounts: (json['discounts'] as List<dynamic>?)
          ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceiptItemToJson(ReceiptItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'good': instance.good,
      'quantity': ReceiptItem.updateQility(instance.quantity),
      'discounts': instance.discounts,
    };
