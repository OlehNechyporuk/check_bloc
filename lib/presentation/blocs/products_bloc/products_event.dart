part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoadedEvent extends ProductsEvent {}

class ProductsSearchEvent extends ProductsEvent {
  final String? query;
  const ProductsSearchEvent(this.query);
}

class ProductsSearchLoadedEvent extends ProductsEvent {
  final List<ProductEntity> products;
  const ProductsSearchLoadedEvent(this.products);
}

class ProductsLoadMoreEvent extends ProductsEvent {}
