// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cashier _$CashierFromJson(Map<String, dynamic> json) => Cashier(
      id: json['id'] as String?,
      fullName: json['full_name'] as String?,
      nin: json['nin'] as String?,
      keyId: json['key_id'] as String?,
      signatureType: json['signature_type'] as String?,
      permissions: (json['permissions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      certificateEnd: json['certificate_end'] == null
          ? null
          : DateTime.parse(json['certificate_end'] as String),
      blocked: json['blocked'] as String?,
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashierToJson(Cashier instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'nin': instance.nin,
      'key_id': instance.keyId,
      'signature_type': instance.signatureType,
      'permissions': instance.permissions,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'certificate_end': instance.certificateEnd?.toIso8601String(),
      'blocked': instance.blocked,
      'organization': instance.organization,
    };
