import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/good_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';
import 'package:dartz/dartz.dart';

class AddProductToReceiptUseCase
    extends UseCase<List<ReceiptItemEntity>, AddProductToReceiptParams> {
  @override
  Future<Either<Failure, List<ReceiptItemEntity>>> call(
    AddProductToReceiptParams params,
  ) async {
    final newItem = ReceiptItemEntity(
      id: null,
      good: GoodEntity(
        code: params.product.code,
        name: params.product.name,
        barcode: '${params.product.barcode}',
        exciseBarcode: '',
        exciseBarcodes: const [''],
        price: params.price,
        tax: const [0],
        uktzed: '',
      ),
      quantity: 1,
      discounts: const [],
    );

    int find = params.items
        .indexWhere((element) => element.good.code == params.product.code);

    if (find < 0) {
      params.items.add(newItem);
    } else {
      final amount = params.items[find].quantity;

      params.items[find] = params.items[find].copyWith(quantity: amount + 1);
    }

    return right(params.items);
  }
}

class AddProductToReceiptParams {
  final List<ReceiptItemEntity> items;
  final ProductEntity product;
  final double price;

  const AddProductToReceiptParams({
    required this.items,
    required this.product,
    required this.price,
  });
}
