import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/data/checkbox/models/tax_model.dart';
import 'package:check_bloc/domain/entity/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  @JsonKey(name: 'taxes')
  final List<TaxModel>? taxesList;
  @JsonKey(name: 'related_goods')
  final List<ProductModel>? products;

  const ProductModel({
    required super.id,
    required super.code,
    required super.name,
    required super.price,
    required super.barcode,
    required super.uktzed,
    required this.taxesList,
    required super.createdAt,
    required super.updatedAt,
    required this.products,
    required super.relatedBarcodes,
  }) : super(
          taxes: taxesList,
          relatedGoods: products,
        );
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
