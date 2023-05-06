// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) => ShiftModel(
      id: json['id'] as String,
      serial: json['serial'] as int,
      status: json['status'] as String,
      zReportModel: json['z_report'] == null
          ? null
          : ReportModel.fromJson(json['z_report'] as Map<String, dynamic>),
      openedAt: json['opened_at'] == null
          ? null
          : DateTime.parse(json['opened_at'] as String),
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      initialTransactionModel: json['initial_transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['initial_transaction'] as Map<String, dynamic>),
      closeTransactionModel: json['closing_transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['closing_transaction'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      balanceModel:
          BalanceModel.fromJson(json['balance'] as Map<String, dynamic>),
      cashRegisterModel: CashRegisterModel.fromJson(
          json['cash_register'] as Map<String, dynamic>),
      cashierModel: json['cashier'] == null
          ? null
          : CashierModel.fromJson(json['cashier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShiftModelToJson(ShiftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'status': instance.status,
      'opened_at': instance.openedAt?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'z_report': instance.zReportModel,
      'balance': instance.balanceModel,
      'cash_register': instance.cashRegisterModel,
      'cashier': instance.cashierModel,
      'initial_transaction': instance.initialTransactionModel,
      'closing_transaction': instance.closeTransactionModel,
    };
