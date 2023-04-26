import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/discount_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';

class AddReceiptDiscountUseCase
    extends UseCase<ReceiptEntity, AddReceiptDiscountParams> {
  @override
  Future<Either<Failure, ReceiptEntity>> call(
    AddReceiptDiscountParams params,
  ) async {
    if (params.discount <= 0) {
      final result = params.receipt.copyWith(discounts: []);

      return right(result);
    } else {
      if (params.type == DiscountType.percent) {
        final persentDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'PERCENT',
          value: params.discount,
        );
        final result = params.receipt.copyWith(discounts: [persentDiscount]);

        return right(result);
      } else if (params.type == DiscountType.fixed) {
        final cashDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'CASH',
          value: params.discount,
        );

        final result = params.receipt.copyWith(discounts: [cashDiscount]);

        return right(result);
      }
    }
    return left(Failure('Error'));
  }
}

class AddReceiptDiscountParams {
  final ReceiptEntity receipt;
  final DiscountType type;
  final double discount;

  const AddReceiptDiscountParams({
    required this.receipt,
    required this.type,
    required this.discount,
  });
}
