part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final String? category;

  const ProductsLoaded(this.products, this.category);

  @override
  List<Object?> get props => [products, category];
}
