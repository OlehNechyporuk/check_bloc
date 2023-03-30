import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Equatable {
  final String? id;
  final int? code;
  final String? type;
  @JsonKey(name: 'provider_type')
  final String? providerType;
  final String? label;
  @JsonKey(name: 'sell_sum')
  final int? sellSum;
  @JsonKey(name: 'return_sum')
  final int? returnSum;
  @JsonKey(name: 'service_in')
  final int? serviceIn;
  @JsonKey(name: 'service_out')
  final int? serviceOut;
  @JsonKey(name: 'cash_withdrawal')
  final int? cashWithdrawal;
  @JsonKey(name: 'cash_withdrawal_commission')
  final int? cashWithdrawalCommission;

  const Payment({
    this.id,
    this.code,
    this.type,
    this.providerType,
    this.label,
    this.sellSum,
    this.returnSum,
    this.serviceIn,
    this.serviceOut,
    this.cashWithdrawal,
    this.cashWithdrawalCommission,
  });

  @override
  List<Object?> get props {
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

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
