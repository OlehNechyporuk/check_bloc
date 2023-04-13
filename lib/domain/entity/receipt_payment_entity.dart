import 'package:equatable/equatable.dart';

class ReceiptPaymentEntity extends Equatable {
  final String type;
  final int? value;
  final String label;

  const ReceiptPaymentEntity({
    required this.type,
    required this.value,
    required this.label,
  });

  @override
  List<Object?> get props => [type, value, label];

  ReceiptPaymentEntity copyWith({
    String? type,
    int? value,
    String? label,
  }) {
    return ReceiptPaymentEntity(
      type: type ?? this.type,
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
