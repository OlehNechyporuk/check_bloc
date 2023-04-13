import 'package:equatable/equatable.dart';

import 'package:check_bloc/domain/entity/tax_entity.dart';

class ProductEntity extends Equatable {
  final String id;
  final String code;
  final String name;
  final double price;
  final String? barcode;
  final String? uktzed;
  final List<TaxEntity>? taxes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductEntity>? relatedGoods;
  final String? relatedBarcodes;

  const ProductEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
    required this.barcode,
    required this.uktzed,
    required this.taxes,
    required this.createdAt,
    required this.updatedAt,
    required this.relatedGoods,
    required this.relatedBarcodes,
  });

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      price,
      barcode,
      uktzed,
      taxes,
      createdAt,
      updatedAt,
      relatedGoods,
      relatedBarcodes,
    ];
  }
}
