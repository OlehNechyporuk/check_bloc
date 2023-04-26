import 'package:equatable/equatable.dart';

class GoodEntity extends Equatable {
  final String code;
  final String name;
  final String? barcode;
  final String? exciseBarcode;
  final List<String>? exciseBarcodes;
  final double price;
  final List<int>? tax;
  final String? uktzed;

  const GoodEntity({
    required this.code,
    required this.name,
    required this.barcode,
    required this.exciseBarcode,
    required this.exciseBarcodes,
    required this.price,
    required this.tax,
    required this.uktzed,
  });

  @override
  List<Object?> get props {
    return [
      code,
      name,
      barcode,
      exciseBarcode,
      exciseBarcodes,
      price,
      tax,
      uktzed,
    ];
  }
}
