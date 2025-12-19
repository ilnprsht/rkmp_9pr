import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/product.dart';
import '../repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repository) : super(ProductsInitial());

  final ProductsRepository _repository;
  final List<Product> _products = [];
  String? _categoryFilter;

  void loadInitial() {
    _products.addAll(_repository.loadProducts());
    emit(ProductsLoaded(List.from(_products), _categoryFilter));
  }

  void addProduct(Product product) {
    _products.add(product);
    _repository.save(product);
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) _products[index] = product;
    _repository.update(product);
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  void deleteProduct(int id) {
    _products.removeWhere((p) => p.id == id);
    _repository.delete(id);
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  void toggleFavorite(int id) {
    final i = _products.indexWhere((p) => p.id == id);
    if (i != -1) {
      final p = _products[i];
      _products[i] = p.copyWith(isFavorite: !p.isFavorite);
      emit(ProductsLoaded(_filtered(), _categoryFilter));
    }
  }

  void setCategoryFilter(String? category) {
    _categoryFilter = category;
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  List<Product> _filtered() {
    if (_categoryFilter == null) return List.from(_products);
    return _products
        .where((p) => p.category == _categoryFilter)
        .toList();
  }

  List<Product> favorites() =>
      _filtered().where((p) => p.isFavorite).toList();
}
