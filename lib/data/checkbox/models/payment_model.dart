import 'package:check_bloc/domain/entity/payment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

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
