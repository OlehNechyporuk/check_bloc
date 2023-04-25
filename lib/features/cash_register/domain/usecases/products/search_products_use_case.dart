import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class SearchProductsUseCase
    extends UseCase<List<ProductEntity>, SearchProductsParams> {
  final ProductRepository _productRepository;

  const SearchProductsUseCase(this._productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    SearchProductsParams params,
  ) async {
    return await _productRepository.getProducts(searchQuery: params.query);
  }
}

class SearchProductsParams {
  final String query;

  SearchProductsParams(this.query);
}
