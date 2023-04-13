import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/cash_register/domain/entity/bonus_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/discount_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';

class ReceiptEntity extends Equatable {
  final String? id;
  final String type;
  final String status;
  final List<ReceiptItemEntity> goods;
  final int totalSum;
  final int totalPayment;
  final int totalRest;
  final int roundSum;
  final List<DiscountEntity> discounts;
  final List<BonusEntity> bonuses;
  final List<ReceiptPaymentEntity> payments;
  final bool rounding;
  final String? fiscalCode;
  final DateTime? fiscalDate;
  final DateTime? deliveredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReceiptEntity({
    required this.id,
    required this.type,
    required this.status,
    required this.goods,
    required this.totalSum,
    required this.totalPayment,
    required this.totalRest,
    required this.roundSum,
    required this.discounts,
    required this.bonuses,
    required this.payments,
    required this.rounding,
    required this.fiscalCode,
    required this.fiscalDate,
    required this.deliveredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  const ReceiptEntity.empty()
      : id = null,
        type = '',
        status = '',
        goods = const [],
        totalSum = 0,
        totalPayment = 0,
        totalRest = 0,
        roundSum = 0,
        discounts = const [],
        bonuses = const [],
        payments = const [
          ReceiptPaymentEntity(
            label: 'Готівка',
            type: 'CASH',
            value: null,
          ),
        ],
        rounding = true,
        fiscalCode = null,
        fiscalDate = null,
        deliveredAt = null,
        createdAt = null,
        updatedAt = null;

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
    ];
  }

  ReceiptEntity copyWith({
    String? id,
    String? type,
    String? status,
    List<ReceiptItemEntity>? goods,
    int? totalSum,
    int? totalPayment,
    int? totalRest,
    int? roundSum,
    List<DiscountEntity>? discounts,
    List<BonusEntity>? bonuses,
    List<ReceiptPaymentEntity>? payments,
    bool? rounding,
    String? fiscalCode,
    DateTime? fiscalDate,
    DateTime? deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReceiptEntity(
      id: id ?? this.id,
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
    );
  }
}
