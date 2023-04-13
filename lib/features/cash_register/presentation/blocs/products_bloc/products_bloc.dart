import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;

  ProductsBloc(this._productRepository) : super(const ProductsState.empty()) {
    on<ProductsLoadedEvent>(_loadProducts);
    on<ProductsSearchEvent>(_searchProducts);
    on<ProductsLoadMoreEvent>(_loadMoreProducts);
  }

  _loadProducts(ProductsLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _productRepository.getProducts();
    result.fold(
      (error) => {
        emit(
          state.copyWith(
            errorText: error.toString(),
            showLoadMoreButton: false,
            status: BlocStateStatus.failure,
          ),
        ),
      },
      (products) {
        emit(
          state.copyWith(
            products: products,
            showLoadMoreButton: products.isNotEmpty,
            status: BlocStateStatus.success,
          ),
        );
      },
    );
  }

  _searchProducts(ProductsSearchEvent event, emit) async {
    final query = event.query?.trim();

    if (query != null && query.isNotEmpty) {
      final result = await _productRepository.getProducts(searchQuery: query);

      result.fold(
        (error) => {
          emit(
            state.copyWith(
              errorText: error.toString(),
              showLoadMoreButton: false,
              status: BlocStateStatus.failure,
            ),
          ),
        },
        (products) {
          emit(
            state.copyWith(
              products: products,
              showLoadMoreButton: false,
              status: BlocStateStatus.success,
            ),
          );
        },
      );
    } else {
      add(ProductsLoadedEvent());
    }
  }

  _loadMoreProducts(ProductsLoadMoreEvent event, emit) async {
    final offset = state.products.length;

    final result = await _productRepository.getProducts(offset: offset);

    result.fold(
      (error) => {
        emit(
          state.copyWith(
            showLoadMoreButton: false,
            status: BlocStateStatus.failure,
            errorText: error.message,
          ),
        )
      },
      (products) {
        if (products.isEmpty) {
          emit(
            state.copyWith(
              showLoadMoreButton: false,
              status: BlocStateStatus.failure,
            ),
          );
        } else {
          emit(
            state.copyWith(
              products: [...state.products, ...products],
              status: BlocStateStatus.success,
              showLoadMoreButton: true,
            ),
          );
        }
      },
    );
  }
}
