import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/payment_entity.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.code,
    required super.type,
    required super.providerType,
    required super.label,
    required super.sellSum,
    required super.returnSum,
    required super.serviceIn,
    required super.serviceOut,
    required super.cashWithdrawal,
    required super.cashWithdrawalCommission,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
