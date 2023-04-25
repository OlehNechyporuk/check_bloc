import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/cash_register/domain/entity/balance_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';

class ShiftEntity extends Equatable {
  final String id;
  final int serial;
  final String status;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final BalanceEntity balance;
  final CashRegisterEntity cashRegister;
  final CashierEntity? cashier;

  const ShiftEntity({
    required this.id,
    required this.serial,
    required this.status,
    required this.openedAt,
    required this.closedAt,
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
      openedAt,
      closedAt,
      createdAt,
      updatedAt,
      balance,
      cashRegister,
      cashier,
    ];
  }
}
