import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';

class ProductRepositoryCheckboxImpl extends ProductRepository {
  final SessionDataProvider _sessionDataProvider;
  final CheckboxApiDataProvider _apiDataProvider;

  const ProductRepositoryCheckboxImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int limit = AppConstants.productsLimitPerPage,
    int offset = 0,
    String? searchQuery,
  }) async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiDataProvider.getProudcts(
      key: apiKey,
      limit: limit,
      offest: offset,
      query: searchQuery,
    );
  }
}
