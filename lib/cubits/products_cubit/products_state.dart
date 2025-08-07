part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

final class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  const ProductsLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

final class ProductsFailed extends ProductsState {
  @override
  List<Object> get props => [];
}
