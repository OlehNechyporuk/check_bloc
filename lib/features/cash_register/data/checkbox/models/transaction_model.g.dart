// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String,
      type: json['type'] as String,
      serial: json['serial'] as int,
      status: json['status'] as String,
      requestSignedAt: json['request_signed_at'] == null
          ? null
          : DateTime.parse(json['request_signed_at'] as String),
      requestReceivedAt: json['request_received_at'] == null
          ? null
          : DateTime.parse(json['request_received_at'] as String),
      responseStatus: json['response_status'] as String?,
      responseErrorMessage: json['response_error_message'] as String?,
      responseId: json['response_id'] as String?,
      offlineId: json['offline_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      originalDatetime: DateTime.parse(json['original_datetime'] as String),
      previousHash: json['previous_hash'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'serial': instance.serial,
      'status': instance.status,
      'request_signed_at': instance.requestSignedAt?.toIso8601String(),
      'request_received_at': instance.requestReceivedAt?.toIso8601String(),
      'response_status': instance.responseStatus,
      'response_error_message': instance.responseErrorMessage,
      'response_id': instance.responseId,
      'offline_id': instance.offlineId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'original_datetime': instance.originalDatetime.toIso8601String(),
      'previous_hash': instance.previousHash,
    };
