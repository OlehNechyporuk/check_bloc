import 'package:check_bloc/domain/entity/good_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'good_model.g.dart';

@JsonSerializable()
class GoodModel extends GoodEntity {
  const GoodModel({
    required super.code,
    required super.name,
    required super.barcode,
    required super.exciseBarcode,
    required super.exciseBarcodes,
    required super.price,
    required super.tax,
    required super.uktzed,
  });

  factory GoodModel.fromJson(Map<String, dynamic> json) =>
      _$GoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoodModelToJson(this);
}
