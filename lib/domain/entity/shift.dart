import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/domain/entity/balance.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:check_bloc/domain/entity/cashier.dart';
import 'package:check_bloc/domain/entity/tax.dart';
import 'package:check_bloc/domain/entity/transaction.dart';
import 'package:check_bloc/domain/entity/z_report.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift extends Equatable {
  final String? id;
  final int? serial;
  final String? status;
  @JsonKey(name: 'z_report')
  final ZReport? zReport;
  @JsonKey(name: 'opened_at')
  final DateTime? openedAt;
  @JsonKey(name: 'closed_at')
  final DateTime? closedAt;
  @JsonKey(name: 'initial_transaction')
  final Transaction? initialTransaction;
  @JsonKey(name: 'closing_transaction')
  final Transaction? closingTransaction;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final Balance? balance;
  final List<Tax>? taxes;
  @JsonKey(name: 'emergency_close')
  final bool? emergencyClose;
  @JsonKey(name: 'emergency_close_details')
  final String? emergencyCloseDetails;
  final Cashier? cashier;
  @JsonKey(name: 'cash_register')
  final CashRegister? cashRegister;

  const Shift({
    this.id,
    this.serial,
    this.status,
    this.zReport,
    this.openedAt,
    this.closedAt,
    this.initialTransaction,
    this.closingTransaction,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.taxes,
    this.emergencyClose,
    this.emergencyCloseDetails,
    this.cashier,
    this.cashRegister,
  });

  @override
  List<Object?> get props {
    return [
      id,
      serial,
      status,
      zReport,
      openedAt,
      closedAt,
      initialTransaction,
      closingTransaction,
      createdAt,
      updatedAt,
      balance,
      taxes,
      emergencyClose,
      emergencyCloseDetails,
      cashier,
      cashRegister,
    ];
  }

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);
}
