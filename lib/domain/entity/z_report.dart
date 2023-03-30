// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/domain/entity/payment.dart';
import 'package:check_bloc/domain/entity/tax.dart';

part 'z_report.g.dart';

@JsonSerializable()
class ZReport extends Equatable {
  final String? id;
  final int? serial;
  @JsonKey(name: 'is_z_report')
  final bool? isZReport;
  final List<Payment>? payments;
  final List<Tax>? taxes;
  @JsonKey(name: 'sell_receipts_count')
  final int? sellReceiptsCount;
  @JsonKey(name: 'return_receipts_count')
  final int? returnReceiptsCount;
  @JsonKey(name: 'cash_withdrawal_receipts_count')
  final int? cashWithdrawalReceiptsCount;
  @JsonKey(name: 'transfers_count')
  final int? transfersCount;
  @JsonKey(name: 'transfers_sum')
  final int? transfersSum;
  final int? balance;
  final int? initial;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'discounts_sum')
  final int? discountsSum;
  @JsonKey(name: 'extra_charge_sum')
  final int? extraChargeSum;
  @JsonKey(name: 'transaction_fail')
  final bool? transactionFail;

  const ZReport({
    this.id,
    this.serial,
    this.isZReport,
    this.payments,
    this.taxes,
    this.sellReceiptsCount,
    this.returnReceiptsCount,
    this.cashWithdrawalReceiptsCount,
    this.transfersCount,
    this.transfersSum,
    this.balance,
    this.initial,
    this.createdAt,
    this.updatedAt,
    this.discountsSum,
    this.extraChargeSum,
    this.transactionFail,
  });

  @override
  List<Object?> get props {
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

  factory ZReport.fromJson(Map<String, dynamic> json) =>
      _$ZReportFromJson(json);
}
