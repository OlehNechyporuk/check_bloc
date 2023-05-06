import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/transaction_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/cash_register/domain/entity/balance_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';

class ShiftEntity extends Equatable {
  final String id;
  final int serial;
  final String status;
  final ReportEntity? zReport;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final TransactionEntity? initialTransaction;
  final TransactionEntity? closingTransaction;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final BalanceEntity balance;
  final CashRegisterEntity cashRegister;
  final CashierEntity? cashier;

  const ShiftEntity({
    required this.id,
    required this.serial,
    required this.status,
    required this.zReport,
    required this.openedAt,
    required this.closedAt,
    required this.initialTransaction,
    required this.closingTransaction,
    required this.createdAt,
    required this.updatedAt,
    required this.balance,
    required this.cashRegister,
    required this.cashier,
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
      cashRegister,
      cashier,
    ];
  }
}
