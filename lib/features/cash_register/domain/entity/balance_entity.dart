import 'package:equatable/equatable.dart';

abstract class BalanceEntity extends Equatable {
  final int initial;
  final int balance;
  final int cashSales;
  final int cardSales;
  final int? discountsSum;
  final int? extraChargeSum;
  final int cashReturns;
  final int cardReturns;
  final int serviceIn;
  final int serviceOut;
  final DateTime? updatedAt;

  const BalanceEntity({
    required this.initial,
    required this.balance,
    required this.cashSales,
    required this.cardSales,
    required this.discountsSum,
    required this.extraChargeSum,
    required this.cashReturns,
    required this.cardReturns,
    required this.serviceIn,
    required this.serviceOut,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      initial,
      balance,
      cashSales,
      cardSales,
      discountsSum,
      extraChargeSum,
      cashReturns,
      cardReturns,
      serviceIn,
      serviceOut,
      updatedAt,
    ];
  }
}
