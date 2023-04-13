import 'package:equatable/equatable.dart';

class OrganizationEntity extends Equatable {
  final String id;
  final String title;
  final String edrpou;
  final String taxNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? subscriptionExp;
  final String? concordLogin;
  final String? concordUid;
  final int receiptsRatelimitCount;
  final int receiptsRatelimitInterval;
  final bool? canSendSms;
  final bool? useSeamlessMode;

  const OrganizationEntity({
    required this.id,
    required this.title,
    required this.edrpou,
    required this.taxNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriptionExp,
    required this.concordLogin,
    required this.concordUid,
    required this.receiptsRatelimitCount,
    required this.receiptsRatelimitInterval,
    required this.canSendSms,
    required this.useSeamlessMode,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      edrpou,
      taxNumber,
      createdAt,
      updatedAt,
      subscriptionExp,
      concordLogin,
      concordUid,
      receiptsRatelimitCount,
      receiptsRatelimitInterval,
      canSendSms,
      useSeamlessMode,
    ];
  }
}
