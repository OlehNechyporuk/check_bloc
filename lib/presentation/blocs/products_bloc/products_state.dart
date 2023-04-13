part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<ProductEntity> products;
  final bool showLoadMoreButton;
  final String? errorText;
  final BlocStateStatus status;

  const ProductsState({
    required this.products,
    required this.showLoadMoreButton,
    required this.errorText,
    required this.status,
  });

  const ProductsState.empty()
      : products = const [],
        showLoadMoreButton = false,
        errorText = null,
        status = BlocStateStatus.initial;

  @override
  List<Object> get props => [products, showLoadMoreButton, status];

  ProductsState copyWith({
    List<ProductEntity>? products,
    bool? showLoadMoreButton = true,
    String? errorText,
    BlocStateStatus? status,
  }) {
    return ProductsState(
      products: products ?? this.products,
      showLoadMoreButton: showLoadMoreButton ?? this.showLoadMoreButton,
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
    );
  }
}
