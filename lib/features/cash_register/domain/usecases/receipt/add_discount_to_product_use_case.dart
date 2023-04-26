import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/discount_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';

class AddDiscountToProductUseCase
    extends UseCase<List<ReceiptItemEntity>, AddDiscountToProductParams> {
  @override
  Future<Either<Failure, List<ReceiptItemEntity>>> call(
    AddDiscountToProductParams params,
  ) async {
    if (params.discount <= 0) {
      params.items[params.index] =
          params.items[params.index].copyWith(discounts: []);
      return right(params.items);
    } else {
      if (params.type == DiscountType.percent) {
        final persentDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'PERCENT',
          value: params.discount,
        );

        params.items[params.index] =
            params.items[params.index].copyWith(discounts: [persentDiscount]);
        return right(params.items);
      } else if (params.type == DiscountType.fixed) {
        if ((params.discount) < params.items[params.index].good.price) {
          final cashDiscount = DiscountEntity(
            type: 'DISCOUNT',
            mode: 'CASH',
            value: params.discount,
          );

          params.items[params.index] =
              params.items[params.index].copyWith(discounts: [cashDiscount]);
          return right(params.items);
        }
      }
    }
    return left(Failure('Error'));
  }
}

class AddDiscountToProductParams {
  final List<ReceiptItemEntity> items;
  final int index;
  final DiscountType type;
  final double discount;

  const AddDiscountToProductParams({
    required this.items,
    required this.index,
    required this.type,
    required this.discount,
  });
}
