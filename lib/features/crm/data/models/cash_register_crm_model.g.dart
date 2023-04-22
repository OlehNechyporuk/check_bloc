// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_crm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegisterCrmModel _$CashRegisterCrmModelFromJson(
        Map<String, dynamic> json) =>
    CashRegisterCrmModel(
      id: json['id'] as int,
      title: json['title'] as String,
      modelType: CashRegisterTypeCrmModel.fromJson(
          json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashRegisterCrmModelToJson(
        CashRegisterCrmModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.modelType,
    };
