import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  const ProductRepository();

  Future<Either<Failure, List<Product>>> getProducts({
    int limit,
    int offset,
    String? searchQuery,
  });
}
