// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountModel _$DiscountModelFromJson(Map<String, dynamic> json) =>
    DiscountModel(
      type: json['type'] as String,
      mode: json['mode'] as String,
      value: (json['value'] as num).toDouble(),
      taxCode: json['tax_code'] as int?,
      taxCodes:
          (json['tax_codes'] as List<dynamic>?)?.map((e) => e as int).toList(),
      name: json['name'] as String?,
      privilege: json['privilege'] as String?,
      sum: json['sum'] as int?,
    );

Map<String, dynamic> _$DiscountModelToJson(DiscountModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'mode': instance.mode,
      'value': instance.value,
      'tax_code': instance.taxCode,
      'tax_codes': instance.taxCodes,
      'name': instance.name,
      'privilege': instance.privilege,
      'sum': instance.sum,
    };
