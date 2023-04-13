import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/cash_register/domain/entity/payment_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/tax_entity.dart';

class ZReportEntity extends Equatable {
  final String id;
  final int serial;
  final bool isZReport;
  final List<PaymentEntity> payments;
  final List<TaxEntity> taxes;
  final int sellReceiptsCount;
  final int returnReceiptsCount;
  final int cashWithdrawalReceiptsCount;
  final int transfersCount;
  final int transfersSum;
  final int balance;
  final int initial;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int discountsSum;
  final int extraChargeSum;
  final bool transactionFail;

  const ZReportEntity({
    required this.id,
    required this.serial,
    required this.isZReport,
    required this.payments,
    required this.taxes,
    required this.sellReceiptsCount,
    required this.returnReceiptsCount,
    required this.cashWithdrawalReceiptsCount,
    required this.transfersCount,
    required this.transfersSum,
    required this.balance,
    required this.initial,
    required this.createdAt,
    required this.updatedAt,
    required this.discountsSum,
    required this.extraChargeSum,
    required this.transactionFail,
  });

  @override
  List<Object> get props {
    return [
      id,
      serial,
      isZReport,
      payments,
      taxes,
      sellReceiptsCount,
      returnReceiptsCount,
      cashWithdrawalReceiptsCount,
      transfersCount,
      transfersSum,
      balance,
      initial,
      createdAt,
      updatedAt,
      discountsSum,
      extraChargeSum,
      transactionFail,
    ];
  }
}
