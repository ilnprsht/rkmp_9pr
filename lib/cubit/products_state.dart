import 'package:equatable/equatable.dart';
import '../models/product.dart';

class ProductsState extends Equatable {
  final List<Product> products;
  final String? categoryFilter;

  const ProductsState({
    this.products = const [],
    this.categoryFilter,
  });

  List<Product> get filteredProducts {
    if (categoryFilter == null) return products;
    return products.where((p) => p.category == categoryFilter).toList();
  }

  List<Product> get favorites =>
      filteredProducts.where((p) => p.isFavorite).toList();

  ProductsState copyWith({
    List<Product>? products,
    String? categoryFilter,
  }) {
    return ProductsState(
      products: products ?? this.products,
      categoryFilter: categoryFilter ?? this.categoryFilter,
    );
  }

  @override
  List<Object?> get props => [products, categoryFilter];
}
