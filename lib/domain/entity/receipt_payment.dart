// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/data/checkbox/repository/payment_repository_impl.dart';

part 'receipt_payment.g.dart';

@JsonSerializable()
class ReceiptPayment extends Equatable {
  final String? type;
  final int? value;
  final String? label;

  const ReceiptPayment({
    this.type,
    this.value,
    this.label,
  });

  PaymentType get convertStringToEnum {
    if (type == 'CASH') {
      return PaymentType.cash;
    } else if (type == 'CARD') {
      return PaymentType.card;
    } else {
      return PaymentType.cashless;
    }
  }

  String get convertEnumToString {
    if (convertStringToEnum == PaymentType.cash) {
      return 'CASH';
    } else if (convertStringToEnum == PaymentType.card) {
      return 'CARD';
    } else {
      return 'CASHLESS';
    }
  }

  @override
  List<Object?> get props => [type, value, label];

  @override
  get stringify => true;

  factory ReceiptPayment.fromJson(Map<String, dynamic> json) =>
      _$ReceiptPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptPaymentToJson(this);
}
