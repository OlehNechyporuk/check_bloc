// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'good.g.dart';

@JsonSerializable()
class Good extends Equatable {
  final String? code;
  final String? name;
  final String? barcode;
  @JsonKey(name: 'excise_barcode')
  final String? exciseBarcode;
  @JsonKey(name: 'excise_barcodes')
  final List<String>? exciseBarcodes;
  final String? header;
  final String? footer;
  final double? price;
  final List<int>? tax;
  final String? uktzed;
  const Good({
    this.code,
    this.name,
    this.barcode,
    this.exciseBarcode,
    this.exciseBarcodes,
    this.header,
    this.footer,
    this.price,
    this.tax,
    this.uktzed,
  });

  @override
  List<Object?> get props {
    return [
      code,
      name,
      barcode,
      exciseBarcode,
      exciseBarcodes,
      header,
      footer,
      price,
      tax,
      uktzed,
    ];
  }

  factory Good.fromJson(Map<String, dynamic> json) => _$GoodFromJson(json);

  Map<String, dynamic> toJson() => _$GoodToJson(this);
}
