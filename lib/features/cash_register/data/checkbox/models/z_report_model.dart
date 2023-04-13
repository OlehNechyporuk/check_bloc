import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/models/payment_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/tax_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/z_report_entity.dart';

part 'z_report_model.g.dart';

@JsonSerializable()
class ZReportModel extends ZReportEntity {
  @JsonKey(name: 'payments')
  final List<PaymentModel> paymentsModel;
  @JsonKey(name: 'taxes')
  final List<TaxModel> taxesModel;

  const ZReportModel({
    required super.id,
    required super.serial,
    required super.isZReport,
    required this.paymentsModel,
    required this.taxesModel,
    required super.sellReceiptsCount,
    required super.returnReceiptsCount,
    required super.cashWithdrawalReceiptsCount,
    required super.transfersCount,
    required super.transfersSum,
    required super.balance,
    required super.initial,
    required super.createdAt,
    required super.updatedAt,
    required super.discountsSum,
    required super.extraChargeSum,
    required super.transactionFail,
  }) : super(
          payments: paymentsModel,
          taxes: taxesModel,
        );

  factory ZReportModel.fromJson(Map<String, dynamic> json) =>
      _$ZReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZReportModelToJson(this);
}
