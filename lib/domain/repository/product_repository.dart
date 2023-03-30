import 'package:check_bloc/domain/entity/product.dart';

abstract class ProductRepository {
  const ProductRepository();
  Future<List<Product>> getProducts({
    int limit,
    int offset,
    String? searchQuery,
  });
}
