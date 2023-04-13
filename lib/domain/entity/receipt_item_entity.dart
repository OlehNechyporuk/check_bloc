// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:check_bloc/domain/entity/discount_entity.dart';
import 'package:check_bloc/domain/entity/good_entity.dart';

class ReceiptItemEntity extends Equatable {
  final int? id;
  final GoodEntity good;
  final int quantity;
  final List<DiscountEntity>? discounts;

  const ReceiptItemEntity({
    required this.id,
    required this.good,
    required this.quantity,
    required this.discounts,
  });

  @override
  List<Object?> get props => [id, good, quantity, discounts];

  ReceiptItemEntity copyWith({
    int? id,
    GoodEntity? good,
    int? quantity,
    List<DiscountEntity>? discounts,
  }) {
    return ReceiptItemEntity(
      id: id ?? this.id,
      good: good ?? this.good,
      quantity: quantity ?? this.quantity,
      discounts: discounts ?? this.discounts,
    );
  }
}
