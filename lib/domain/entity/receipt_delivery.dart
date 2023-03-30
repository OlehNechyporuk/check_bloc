// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_delivery.g.dart';

@JsonSerializable()
class ReceiptDelivery extends Equatable {
  final String? email;
  final List<String>? emails;
  final String? phone;

  const ReceiptDelivery({
    this.email,
    this.emails,
    this.phone,
  });

  @override
  List<Object?> get props => [email, emails, phone];

  factory ReceiptDelivery.fromJson(Map<String, dynamic> json) =>
      _$ReceiptDeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptDeliveryToJson(this);
}
