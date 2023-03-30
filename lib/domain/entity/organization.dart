import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization extends Equatable {
  final String? id;
  final String? title;
  final String? edrpou;
  @JsonKey(name: 'tax_number')
  final String? taxNumber;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'subscription_exp')
  final DateTime? subscriptionExp;
  @JsonKey(name: 'concord_login')
  final String? concordLogin;
  @JsonKey(name: 'concord_uid')
  final String? concordUid;
  @JsonKey(name: 'receipts_ratelimit_count')
  final int? receiptsRatelimitCount;
  @JsonKey(name: 'receipts_ratelimit_interval')
  final int? receiptsRatelimitInterval;
  @JsonKey(name: 'can_send_sms')
  final bool? canSendSms;
  @JsonKey(name: 'use_seamless_mode')
  final bool? useSeamlessMode;

  const Organization({
    this.id,
    this.title,
    this.edrpou,
    this.taxNumber,
    this.createdAt,
    this.updatedAt,
    this.subscriptionExp,
    this.concordLogin,
    this.concordUid,
    this.receiptsRatelimitCount,
    this.receiptsRatelimitInterval,
    this.canSendSms,
    this.useSeamlessMode,
  });

  @override
  List<Object?> get props => [];

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
}
