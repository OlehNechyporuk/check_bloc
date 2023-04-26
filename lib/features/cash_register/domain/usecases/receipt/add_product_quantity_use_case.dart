import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';
import 'package:dartz/dartz.dart';

class AddProductQuantityUseCase
    extends UseCase<List<ReceiptItemEntity>, AddProductQuantityParams> {
  @override
  Future<Either<Failure, List<ReceiptItemEntity>>> call(
    AddProductQuantityParams params,
  ) async {
    final item = params.items[params.index];
    final current = item.quantity;
    int newAmount = 1;
    if (params.quantity == null) {
      newAmount = 0;
    } else if (params.quantity != 1 && params.quantity != -1) {
      newAmount = params.quantity ?? 1;
    } else {
      newAmount = current + params.quantity!;
    }

    if (newAmount <= 0) {
      newAmount = 1;
    }

    params.items[params.index] =
        params.items[params.index].copyWith(quantity: newAmount);

    return right(params.items);
  }
}

class AddProductQuantityParams {
  final List<ReceiptItemEntity> items;
  final int index;
  final int? quantity;

  const AddProductQuantityParams({
    required this.items,
    required this.index,
    required this.quantity,
  });
}
