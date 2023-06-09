import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';

part 'receipt_payment_model.g.dart';

@JsonSerializable()
class ReceiptPaymentModel extends ReceiptPaymentEntity {
  const ReceiptPaymentModel({
    required super.type,
    required super.value,
    required super.label,
  });

  factory ReceiptPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptPaymentModelToJson(this);
}
