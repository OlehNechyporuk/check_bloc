// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      id: json['id'] as String?,
      code: json['code'] as String?,
      label: json['label'] as String?,
      symbol: json['symbol'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      extraRate: (json['extra_rate'] as num?)?.toDouble(),
      included: json['included'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      noVat: json['no_vat'] as bool?,
      advancedCode: json['advanced_code'] as String?,
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'label': instance.label,
      'symbol': instance.symbol,
      'rate': instance.rate,
      'extra_rate': instance.extraRate,
      'included': instance.included,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'no_vat': instance.noVat,
      'advanced_code': instance.advancedCode,
    };
