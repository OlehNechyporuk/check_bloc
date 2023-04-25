import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';

class LoadMoreProductsUseCase
    extends UseCase<List<ProductEntity>, LoadMoreProductsParams> {
  final ProductRepository _productRepository;

  const LoadMoreProductsUseCase(this._productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    LoadMoreProductsParams params,
  ) async {
    return await _productRepository.getProducts(offset: params.offset);
  }
}

class LoadMoreProductsParams {
  final int offset;

  LoadMoreProductsParams(this.offset);
}
