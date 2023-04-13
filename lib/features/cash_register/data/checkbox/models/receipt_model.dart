import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/models/bonus_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/discount_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/receipt_item_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/receipt_payment_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';

part 'receipt_model.g.dart';

@JsonSerializable()
class ReceiptModel extends ReceiptEntity {
  @JsonKey(name: 'goods', defaultValue: [])
  final List<ReceiptItemModel> receiptItems;
  @JsonKey(name: 'discounts', defaultValue: [])
  final List<DiscountModel> discountsModel;
  @JsonKey(name: 'bonuses', defaultValue: [])
  final List<BonusModel> bonusesModel;
  @JsonKey(name: 'payments', defaultValue: [])
  final List<ReceiptPaymentModel> paymentsModel;

  const ReceiptModel({
    required super.id,
    required super.type,
    required super.status,
    required this.receiptItems,
    required super.totalSum,
    required super.totalPayment,
    required super.totalRest,
    required super.roundSum,
    required this.discountsModel,
    required this.bonusesModel,
    required this.paymentsModel,
    required super.rounding,
    required super.fiscalCode,
    required super.fiscalDate,
    required super.deliveredAt,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          goods: receiptItems,
          discounts: discountsModel,
          bonuses: bonusesModel,
          payments: paymentsModel,
        );
  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);
}
