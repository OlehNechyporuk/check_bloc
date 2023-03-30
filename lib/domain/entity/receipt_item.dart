import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/domain/entity/discount.dart';
import 'package:check_bloc/domain/entity/good.dart';

part 'receipt_item.g.dart';

@JsonSerializable()
class ReceiptItem extends Equatable {
  final int? id;
  final Good? good;
  @JsonKey(toJson: updateQility)
  final int? quantity;
  final List<Discount>? discounts;

  const ReceiptItem({
    this.id,
    this.good,
    this.quantity,
    this.discounts,
  });

  static updateQility(int? val) {
    if (val == null) return null;

    return val * 1000;
  }

  double get total {
    if (good == null) return 0;
    final price = good?.price;
    if (price == null || quantity == null) return 0;

    double total = price * (quantity ?? 1);
    final listDiscounts = discounts;

    if (listDiscounts != null) {
      if (listDiscounts.isNotEmpty) {
        final discount = listDiscounts.first.value;
        final mode = listDiscounts.first.discountMode;

        if (discount != null) {
          if (mode == DiscountType.fixed) {
            final dis = discount * 100;
            total -= dis * (quantity ?? 1);
          } else if (mode == DiscountType.percent) {
            final dis = (price / 100) * (discount * (quantity ?? 1));
            total -= dis;
          }
        }
      }
    }

    return total;
  }

  double get discountSum {
    if (good == null) return 0;
    final price = good?.price;
    if (price == null || quantity == null) return 0;

    final listDiscounts = discounts;

    if (listDiscounts != null) {
      if (listDiscounts.isNotEmpty) {
        final discount = listDiscounts.first.value;
        final mode = listDiscounts.first.discountMode;

        if (discount != null) {
          if (mode == DiscountType.fixed) {
            final dis = discount;
            return (dis.toDouble() * 100) * (quantity ?? 1);
          } else if (mode == DiscountType.percent) {
            final dis = (price / 100) * (discount * (quantity ?? 1));
            return dis;
          }
        }
      }
    }

    return 0;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      good,
      quantity,
      discounts,
    ];
  }

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptItemToJson(this);

  ReceiptItem copyWith({
    int? id,
    Good? good,
    int? quantity,
    List<Discount>? discounts,
  }) {
    return ReceiptItem(
      id: id ?? this.id,
      good: good ?? this.good,
      quantity: quantity ?? this.quantity,
      discounts: discounts ?? this.discounts,
    );
  }
}
