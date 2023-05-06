import 'package:check_bloc/features/cash_register/data/checkbox/models/report_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/models/balance_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/cash_register_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/cashier_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';

part 'shift_model.g.dart';

@JsonSerializable()
class ShiftModel extends ShiftEntity {
  @JsonKey(name: 'z_report')
  final ReportModel? zReportModel;
  @JsonKey(name: 'balance')
  final BalanceModel balanceModel;
  @JsonKey(name: 'cash_register')
  final CashRegisterModel cashRegisterModel;
  @JsonKey(name: 'cashier')
  final CashierModel? cashierModel;
  @JsonKey(name: 'initial_transaction')
  final TransactionModel? initialTransactionModel;
  @JsonKey(name: 'closing_transaction')
  final TransactionModel? closeTransactionModel;

  const ShiftModel({
    required super.id,
    required super.serial,
    required super.status,
    required this.zReportModel,
    required super.openedAt,
    required super.closedAt,
    required this.initialTransactionModel,
    required this.closeTransactionModel,
    required super.createdAt,
    required super.updatedAt,
    required this.balanceModel,
    required this.cashRegisterModel,
    required this.cashierModel,
  }) : super(
          zReport: zReportModel,
          initialTransaction: initialTransactionModel,
          closingTransaction: closeTransactionModel,
          balance: balanceModel,
          cashRegister: cashRegisterModel,
          cashier: cashierModel,
        );

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftModelToJson(this);
}
