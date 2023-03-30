import 'package:check_bloc/domain/entity/tax.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String? id;
  final String? code;
  final String? name;
  final double? price;
  final String? barcode;
  final String? uktzed;
  final List<Tax>? taxes;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'related_goods')
  final List<Product>? relatedGoods;
  @JsonKey(name: 'related_barcodes')
  final String? relatedBarcodes;

  const Product({
    this.id,
    this.code,
    this.name,
    this.price,
    this.barcode,
    this.uktzed,
    this.taxes,
    this.createdAt,
    this.updatedAt,
    this.relatedGoods,
    this.relatedBarcodes,
  });

  Product copyWith({
    String? id,
    String? code,
    String? name,
    double? price,
    String? barcode,
    String? uktzed,
    List<Tax>? taxes,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Product>? relatedGoods,
    String? relatedBarcodes,
  }) {
    return Product(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      price: price ?? this.price,
      barcode: barcode ?? this.barcode,
      uktzed: uktzed ?? this.uktzed,
      taxes: taxes ?? this.taxes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relatedGoods: relatedGoods ?? this.relatedGoods,
      relatedBarcodes: relatedBarcodes ?? this.relatedBarcodes,
    );
  }

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

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
