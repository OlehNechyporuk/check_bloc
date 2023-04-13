import 'package:check_bloc/data/checkbox/models/balance_model.dart';
import 'package:check_bloc/data/checkbox/models/cash_register_model.dart';
import 'package:check_bloc/data/checkbox/models/cashier_model.dart';
import 'package:check_bloc/domain/entity/shift_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_model.g.dart';

@JsonSerializable()
class ShiftModel extends ShiftEntity {
  @JsonKey(name: 'balance')
  final BalanceModel balanceModel;
  @JsonKey(name: 'cash_register')
  final CashRegisterModel cashRegisterModel;
  @JsonKey(name: 'cashier')
  final CashierModel? cashierModel;

  const ShiftModel({
    required super.id,
    required super.serial,
    required super.status,
    required super.openedAt,
    required super.closedAt,
    required super.createdAt,
    required super.updatedAt,
    required this.balanceModel,
    required this.cashRegisterModel,
    required this.cashierModel,
  }) : super(
          balance: balanceModel,
          cashRegister: cashRegisterModel,
          cashier: cashierModel,
        );

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftModelToJson(this);
}
