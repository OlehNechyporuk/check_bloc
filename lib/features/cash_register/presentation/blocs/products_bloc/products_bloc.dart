import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/products/get_products_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/products/load_more_products_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/products/search_products_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final LoadMoreProductsUseCase _loadMoreProductsUseCase;

  ProductsBloc(
    this._getProductsUseCase,
    this._searchProductsUseCase,
    this._loadMoreProductsUseCase,
  ) : super(const ProductsState.empty()) {
    on<ProductsLoadedEvent>(_loadProducts);
    on<ProductsSearchEvent>(_searchProducts);
    on<ProductsLoadMoreEvent>(_loadMoreProducts);
  }

  _loadProducts(ProductsLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getProductsUseCase(NoParams());

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
      final result = await _searchProductsUseCase(SearchProductsParams(query));

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

    final result =
        await _loadMoreProductsUseCase(LoadMoreProductsParams(offset));

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
