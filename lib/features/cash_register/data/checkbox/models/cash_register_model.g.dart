// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegisterModel _$CashRegisterModelFromJson(Map<String, dynamic> json) =>
    CashRegisterModel(
      id: json['id'] as String,
      fiscalNumber: json['fiscal_number'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      convertNumber: const JsonStringToInt().fromJson(json['number']),
      address: json['address'] as String?,
      title: json['title'] as String?,
      offlineMode: json['offline_mode'] as bool?,
      stayOffline: json['stay_offline'] as bool?,
      hasShift: json['has_shift'] as bool?,
      documentsState: json['documents_state'] as Map<String, dynamic>?,
      emergencyDate: json['emergency_date'] == null
          ? null
          : DateTime.parse(json['emergency_date'] as String),
      emergencyDetails: json['emergency_details'] as String?,
    );

Map<String, dynamic> _$CashRegisterModelToJson(CashRegisterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fiscal_number': instance.fiscalNumber,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'address': instance.address,
      'title': instance.title,
      'offline_mode': instance.offlineMode,
      'stay_offline': instance.stayOffline,
      'has_shift': instance.hasShift,
      'documents_state': instance.documentsState,
      'emergency_date': instance.emergencyDate?.toIso8601String(),
      'emergency_details': instance.emergencyDetails,
      'number': _$JsonConverterToJson<dynamic, int>(
          instance.convertNumber, const JsonStringToInt().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
