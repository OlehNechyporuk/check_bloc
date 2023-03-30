// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: json['id'] as String?,
      title: json['title'] as String?,
      edrpou: json['edrpou'] as String?,
      taxNumber: json['tax_number'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      subscriptionExp: json['subscription_exp'] == null
          ? null
          : DateTime.parse(json['subscription_exp'] as String),
      concordLogin: json['concord_login'] as String?,
      concordUid: json['concord_uid'] as String?,
      receiptsRatelimitCount: json['receipts_ratelimit_count'] as int?,
      receiptsRatelimitInterval: json['receipts_ratelimit_interval'] as int?,
      canSendSms: json['can_send_sms'] as bool?,
      useSeamlessMode: json['use_seamless_mode'] as bool?,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'edrpou': instance.edrpou,
      'tax_number': instance.taxNumber,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'subscription_exp': instance.subscriptionExp?.toIso8601String(),
      'concord_login': instance.concordLogin,
      'concord_uid': instance.concordUid,
      'receipts_ratelimit_count': instance.receiptsRatelimitCount,
      'receipts_ratelimit_interval': instance.receiptsRatelimitInterval,
      'can_send_sms': instance.canSendSms,
      'use_seamless_mode': instance.useSeamlessMode,
    };
