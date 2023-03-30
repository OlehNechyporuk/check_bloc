// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<Product> products;
  final bool showLoadMoreButton;

  const ProductsState(this.products, this.showLoadMoreButton);

  @override
  List<Object> get props => [products, showLoadMoreButton];

  ProductsState copyWith({
    List<Product>? products,
    bool? showLoadMoreButton = true,
  }) {
    return ProductsState(
      products ?? this.products,
      showLoadMoreButton ?? this.showLoadMoreButton,
    );
  }
}
