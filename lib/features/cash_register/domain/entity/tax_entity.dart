import 'package:equatable/equatable.dart';

class TaxEntity extends Equatable {
  final String id;
  final String code;
  final String label;
  final String symbol;
  final double rate;
  final double extraRate;
  final bool included;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool noVat;
  final String advancedCode;

  const TaxEntity({
    required this.id,
    required this.code,
    required this.label,
    required this.symbol,
    required this.rate,
    required this.extraRate,
    required this.included,
    required this.createdAt,
    required this.updatedAt,
    required this.noVat,
    required this.advancedCode,
  });

  @override
  List<Object> get props {
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
}
