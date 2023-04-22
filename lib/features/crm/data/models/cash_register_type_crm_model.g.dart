// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_type_crm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegisterTypeCrmModel _$CashRegisterTypeCrmModelFromJson(
        Map<String, dynamic> json) =>
    CashRegisterTypeCrmModel(
      id: json['id'] as int,
      title: json['title'] as String,
      logo: json['logo'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CashRegisterTypeCrmModelToJson(
        CashRegisterTypeCrmModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'logo': instance.logo,
      'status': instance.status,
    };
