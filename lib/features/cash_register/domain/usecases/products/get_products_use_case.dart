import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';

class GetProductsUseCase extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository _productRepository;

  const GetProductsUseCase(this._productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await _productRepository.getProducts();
  }
}
