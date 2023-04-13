import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  const ProductRepository();

  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int limit,
    int offset,
    String? searchQuery,
  });
}
