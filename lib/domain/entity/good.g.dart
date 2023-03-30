// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Good _$GoodFromJson(Map<String, dynamic> json) => Good(
      code: json['code'] as String?,
      name: json['name'] as String?,
      barcode: json['barcode'] as String?,
      exciseBarcode: json['excise_barcode'] as String?,
      exciseBarcodes: (json['excise_barcodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      header: json['header'] as String?,
      footer: json['footer'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      tax: (json['tax'] as List<dynamic>?)?.map((e) => e as int).toList(),
      uktzed: json['uktzed'] as String?,
    );

Map<String, dynamic> _$GoodToJson(Good instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'barcode': instance.barcode,
      'excise_barcode': instance.exciseBarcode,
      'excise_barcodes': instance.exciseBarcodes,
      'header': instance.header,
      'footer': instance.footer,
      'price': instance.price,
      'tax': instance.tax,
      'uktzed': instance.uktzed,
    };
