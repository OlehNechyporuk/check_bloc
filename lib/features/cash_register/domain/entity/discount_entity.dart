import 'package:equatable/equatable.dart';

enum DiscountType { percent, fixed }

class DiscountEntity extends Equatable {
  final String type;
  final String mode;
  final double value;
  final int? taxCode;
  final List<int>? taxCodes;
  final String? name;
  final String? privilege;
  final int? sum;

  const DiscountEntity({
    required this.type,
    required this.mode,
    required this.value,
    this.taxCode,
    this.taxCodes,
    this.name,
    this.privilege,
    this.sum,
  });

  @override
  List<Object?> get props {
    return [
      type,
      mode,
      value,
      taxCode,
      taxCodes,
      name,
      privilege,
      sum,
    ];
  }
}
