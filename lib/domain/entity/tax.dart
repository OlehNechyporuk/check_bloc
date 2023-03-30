// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tax.g.dart';

@JsonSerializable()
class Tax extends Equatable {
  final String? id;
  final String? code;
  final String? label;
  final String? symbol;
  final double? rate;
  @JsonKey(name: 'extra_rate')
  final double? extraRate;
  final bool? included;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'no_vat')
  final bool? noVat;
  @JsonKey(name: 'advanced_code')
  final String? advancedCode;

  const Tax({
    this.id,
    this.code,
    this.label,
    this.symbol,
    this.rate,
    this.extraRate,
    this.included,
    this.createdAt,
    this.updatedAt,
    this.noVat,
    this.advancedCode,
  });

  @override
  List<Object?> get props {
    return [
      id,
      code,
      label,
      symbol,
      rate,
      extraRate,
      included,
      createdAt,
      updatedAt,
      noVat,
      advancedCode,
    ];
  }

  Tax copyWith({
    String? id,
    String? code,
    String? label,
    String? symbol,
    double? rate,
    double? extraRate,
    bool? included,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? noVat,
    String? advancedCode,
  }) {
    return Tax(
      id: id ?? this.id,
      code: code ?? this.code,
      label: label ?? this.label,
      symbol: symbol ?? this.symbol,
      rate: rate ?? this.rate,
      extraRate: extraRate ?? this.extraRate,
      included: included ?? this.included,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      noVat: noVat ?? this.noVat,
      advancedCode: advancedCode ?? this.advancedCode,
    );
  }

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
}
