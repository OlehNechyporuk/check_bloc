import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/product.dart';
import 'package:check_bloc/domain/repository/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;
  Timer? _timer;

  ProductsBloc(this._productRepository)
      : super(const ProductsState([], false)) {
    on<ProductsLoadedEvent>(_loadProducts);
    on<ProductsSearchEvent>(_searchProducts);
    on<ProductsLoadMoreEvent>(_loadMoreProducts);
    on<ProductsSearchLoadedEvent>((event, emit) {
      emit(state.copyWith(products: event.products, showLoadMoreButton: false));
    });
  }

  _loadProducts(ProductsLoadedEvent event, emit) async {
    final products = await _productRepository.getProducts();

    final showLoadMoreButton = products.isNotEmpty;

    emit(
      state.copyWith(
        products: products,
        showLoadMoreButton: showLoadMoreButton,
      ),
    );
  }

  _searchProducts(ProductsSearchEvent event, emit) async {
    final query = event.query?.trim();

    if (query != null && query.isNotEmpty) {
      if (_timer != null) {
        _timer?.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 300), () async {
        final products =
            await _productRepository.getProducts(searchQuery: query);
        add(ProductsSearchLoadedEvent(products));
      });
    } else {
      add(ProductsLoadedEvent());
    }
  }

  _loadMoreProducts(ProductsLoadMoreEvent event, emit) async {
    final offset = state.products.length;

    final nextPageProducts =
        await _productRepository.getProducts(offset: offset);

    if (nextPageProducts.isEmpty) {
      emit(state.copyWith(showLoadMoreButton: false));
    } else {
      final List<Product> products = [];

      products.addAll(state.products);
      products.addAll(nextPageProducts);
      emit(state.copyWith(products: products));
    }
  }
}
