// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashierModel _$CashierModelFromJson(Map<String, dynamic> json) => CashierModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      nin: json['nin'] as String,
      keyId: json['key_id'] as String,
      signatureType: json['signature_type'] as String,
      permissions: Map<String, bool>.from(json['permissions'] as Map),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      certificateEnd: json['certificate_end'] == null
          ? null
          : DateTime.parse(json['certificate_end'] as String),
      blocked: json['blocked'] as String?,
      organizationModel: json['organization'] == null
          ? null
          : OrganaizationModel.fromJson(
              json['organization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashierModelToJson(CashierModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'nin': instance.nin,
      'key_id': instance.keyId,
      'signature_type': instance.signatureType,
      'permissions': instance.permissions,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'certificate_end': instance.certificateEnd?.toIso8601String(),
      'blocked': instance.blocked,
      'organization': instance.organizationModel,
    };
