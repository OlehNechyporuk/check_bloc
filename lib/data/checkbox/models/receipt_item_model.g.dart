// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptItemModel _$ReceiptItemModelFromJson(Map<String, dynamic> json) =>
    ReceiptItemModel(
      id: json['id'] as int?,
      goodModel: GoodModel.fromJson(json['good'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      discounstModel: (json['discounts'] as List<dynamic>)
          .map((e) => DiscountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceiptItemModelToJson(ReceiptItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'good': instance.goodModel,
      'discounts': instance.discounstModel,
    };
