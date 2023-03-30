// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount.g.dart';

enum DiscountType { percent, fixed }

@JsonSerializable()
class Discount extends Equatable {
  final String? type;
  final String? mode;
  final double? value;
  @JsonKey(name: 'tax_code')
  final int? taxCode;
  @JsonKey(name: 'tax_codes')
  final List<int>? taxCodes;
  final String? name;
  final String? privilege;
  final int? sum;

  const Discount({
    this.type,
    this.mode,
    this.value,
    this.taxCode,
    this.taxCodes,
    this.name,
    this.privilege,
    this.sum,
  });

  DiscountType get discountMode {
    if (mode == 'PERCENT') {
      return DiscountType.percent;
    }
    return DiscountType.fixed;
  }

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

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);

  Discount copyWith({
    String? type,
    String? mode,
    double? value,
    int? taxCode,
    List<int>? taxCodes,
    String? name,
    String? privilege,
    int? sum,
  }) {
    return Discount(
      type: type ?? this.type,
      mode: mode ?? this.mode,
      value: value ?? this.value,
      taxCode: taxCode ?? this.taxCode,
      taxCodes: taxCodes ?? this.taxCodes,
      name: name ?? this.name,
      privilege: privilege ?? this.privilege,
      sum: sum ?? this.sum,
    );
  }
}
