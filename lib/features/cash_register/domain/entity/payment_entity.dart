import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String id;
  final int code;
  final String type;
  final String providerType;
  final String label;
  final int sellSum;
  final int returnSum;
  final int serviceIn;
  final int serviceOut;
  final int cashWithdrawal;
  final int cashWithdrawalCommission;

  const PaymentEntity({
    required this.id,
    required this.code,
    required this.type,
    required this.providerType,
    required this.label,
    required this.sellSum,
    required this.returnSum,
    required this.serviceIn,
    required this.serviceOut,
    required this.cashWithdrawal,
    required this.cashWithdrawalCommission,
  });

  @override
  List<Object> get props {
    return [
      id,
      code,
      type,
      providerType,
      label,
      sellSum,
      returnSum,
      serviceIn,
      serviceOut,
      cashWithdrawal,
      cashWithdrawalCommission,
    ];
  }
}
