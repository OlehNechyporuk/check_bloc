// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shift _$ShiftFromJson(Map<String, dynamic> json) => Shift(
      id: json['id'] as String?,
      serial: json['serial'] as int?,
      status: json['status'] as String?,
      zReport: json['z_report'] == null
          ? null
          : ZReport.fromJson(json['z_report'] as Map<String, dynamic>),
      openedAt: json['opened_at'] == null
          ? null
          : DateTime.parse(json['opened_at'] as String),
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      initialTransaction: json['initial_transaction'] == null
          ? null
          : Transaction.fromJson(
              json['initial_transaction'] as Map<String, dynamic>),
      closingTransaction: json['closing_transaction'] == null
          ? null
          : Transaction.fromJson(
              json['closing_transaction'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      balance: json['balance'] == null
          ? null
          : Balance.fromJson(json['balance'] as Map<String, dynamic>),
      taxes: (json['taxes'] as List<dynamic>?)
          ?.map((e) => Tax.fromJson(e as Map<String, dynamic>))
          .toList(),
      emergencyClose: json['emergency_close'] as bool?,
      emergencyCloseDetails: json['emergency_close_details'] as String?,
      cashier: json['cashier'] == null
          ? null
          : Cashier.fromJson(json['cashier'] as Map<String, dynamic>),
      cashRegister: json['cash_register'] == null
          ? null
          : CashRegister.fromJson(
              json['cash_register'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShiftToJson(Shift instance) => <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'status': instance.status,
      'z_report': instance.zReport,
      'opened_at': instance.openedAt?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
      'initial_transaction': instance.initialTransaction,
      'closing_transaction': instance.closingTransaction,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'balance': instance.balance,
      'taxes': instance.taxes,
      'emergency_close': instance.emergencyClose,
      'emergency_close_details': instance.emergencyCloseDetails,
      'cashier': instance.cashier,
      'cash_register': instance.cashRegister,
    };
