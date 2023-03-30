import 'package:check_bloc/domain/entity/shift.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/domain/entity/bonus.dart';
import 'package:check_bloc/domain/entity/discount.dart';
import 'package:check_bloc/domain/entity/receipt_item.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt extends Equatable {
  final String? id;
  final String? type;
  final String? status;
  final List<ReceiptItem>? goods;
  @JsonKey(name: 'total_sum')
  final int? totalSum;
  @JsonKey(name: 'total_payment')
  final int? totalPayment;
  @JsonKey(name: 'total_rest')
  final int? totalRest;
  @JsonKey(name: 'round_sum')
  final int? roundSum;
  @JsonKey(defaultValue: [])
  final List<Discount>? discounts;
  @JsonKey(defaultValue: [])
  final List<Bonus>? bonuses;
  final List<ReceiptPayment>? payments;
  final bool? rounding;
  @JsonKey(name: 'fiscal_code')
  final String? fiscalCode;
  @JsonKey(name: 'fiscal_date')
  final DateTime? fiscalDate;
  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final Shift? shift;

  const Receipt({
    this.id,
    this.type,
    this.status,
    this.goods,
    this.totalSum,
    this.totalPayment,
    this.totalRest,
    this.roundSum,
    this.discounts,
    this.bonuses,
    this.payments,
    this.rounding,
    this.fiscalCode,
    this.fiscalDate,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    this.shift,
  });

  Map<String, double> get info {
    if (goods == null) {
      return {'sum': 0, 'total': 0, 'paid': 0, 'discount': 0};
    }

    double sum = 0;
    double total = 0;
    double discount = 0;

    for (var item in goods!) {
      final price = item.good?.price ?? 0;
      final amount = item.quantity ?? 1;
      sum += price * amount;
      total += amount;
      discount += item.discountSum;
    }

    //check general disount
    final generalDiscounts = discounts ?? [];

    if (generalDiscounts.isNotEmpty) {
      final generalDiscount = generalDiscounts.first.value ?? 0;
      final generalType = generalDiscounts.first.discountMode;

      if (generalType == DiscountType.fixed) {
        discount += generalDiscount * 100;
      } else {
        final generalPercentDiscount =
            ((sum - discount) / 100) * generalDiscount;
        discount += generalPercentDiscount;
      }
    }

    return {
      'sum': sum,
      'total': total,
      'paid': sum - discount,
      'discount': discount,
    };
  }

  String get typeConvert {
    switch (type) {
      case 'SELL':
        return 'Продаж';
      case 'RETURN':
        return 'Повернення';
      case 'SERVICE_IN':
        return 'Службове внесення';
      case 'SERVICE_OUT':
        return 'Службова видача';
      case 'SERVICE_CURRENCY':
        return 'Курс';
      case 'CURRENCY_EXCHANGE':
        return 'Обмін валюти';
      case 'PAWNSHOP':
        return 'Ломбард';
      case 'CASH_WITHDRAWAL':
        return 'Видача готівки';
      default:
        return '';
    }
  }

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      type,
      status,
      goods,
      totalSum,
      totalPayment,
      totalRest,
      roundSum,
      discounts,
      bonuses,
      payments,
      rounding,
      fiscalCode,
      fiscalDate,
      deliveredAt,
      createdAt,
      updatedAt,
      shift,
    ];
  }

  Receipt copyWith({
    String? id,
    String? type,
    String? status,
    List<ReceiptItem>? goods,
    int? totalSum,
    int? totalPayment,
    int? totalRest,
    int? roundSum,
    List<Discount>? discounts,
    List<Bonus>? bonuses,
    List<ReceiptPayment>? payments,
    bool? rounding,
    String? fiscalCode,
    DateTime? fiscalDate,
    DateTime? deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Shift? shift,
  }) {
    return Receipt(
      id: id,
      type: type ?? this.type,
      status: status ?? this.status,
      goods: goods ?? this.goods,
      totalSum: totalSum ?? this.totalSum,
      totalPayment: totalPayment ?? this.totalPayment,
      totalRest: totalRest ?? this.totalRest,
      roundSum: roundSum ?? this.roundSum,
      discounts: discounts ?? this.discounts,
      bonuses: bonuses ?? this.bonuses,
      payments: payments ?? this.payments,
      rounding: rounding ?? this.rounding,
      fiscalCode: fiscalCode ?? this.fiscalCode,
      fiscalDate: fiscalDate ?? this.fiscalDate,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shift: shift ?? this.shift,
    );
  }
}
