import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/product_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/entity/product_entity.dart';
import 'package:check_bloc/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository {
  final SessionDataProvider _sessionDataProvider;
  final ProductApiDataProvider _apiDataProvider;

  const ProductRepositoryImpl(this._sessionDataProvider, this._apiDataProvider);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int limit = AppConstants.productsLimitPerPage,
    int offset = 0,
    String? searchQuery,
  }) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) throw 'Empty api key';

    return _apiDataProvider.getProudcts(
      key: apiKey,
      limit: limit,
      offest: offset,
      query: searchQuery,
    );
  }
}
