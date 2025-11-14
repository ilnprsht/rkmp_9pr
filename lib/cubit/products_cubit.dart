import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final List<Product> _products = [];
  String? _categoryFilter;

  void loadInitial() {
    _products.addAll([
      Product(
        id: 1,
        name: 'MACximal Matte Lipstick Russian Red',
        brand: 'MAC',
        category: 'Декоративная',
        volume: '3.5 г',
        expirationDate: '08.2027',
        rating: 4.7,
        isFavorite: false,
        imageUrl: 'https://ir.ozone.ru/s3/multimedia-1-i/c1000/7038468774.jpg',
      ),
      Product(
        id: 2,
        name: 'Good Girl Gone Bad',
        brand: 'Killian',
        category: 'Парфюмерия',
        volume: '50 мл',
        expirationDate: '12.2028',
        rating: 5.0,
        isFavorite: true,
        imageUrl:
        'https://www.letu.ru/common/img/pim/2025/10/EX_b9aa478d-31f8-495d-a424-e05b3952beae.jpg',
      ),
      Product(
        id: 3,
        name: 'Galac Niacin 2.0 essence',
        brand: 'Ma:Nyo',
        category: 'Уходовая',
        volume: '30 мл',
        expirationDate: '05.2026',
        rating: 4.7,
        isFavorite: false,
        imageUrl:
        'https://premiumkorea.ru/upload/iblock/761/5572191dc9b1v7dfxm5omuknp15jiuc1.jpg',
      ),
      Product(
        id: 4,
        name: 'Advanced Night Repair',
        brand: 'Estée Lauder',
        category: 'Уходовая',
        volume: '30 мл',
        expirationDate: '03.2027',
        rating: 4.7,
        isFavorite: false,
        imageUrl: 'https://ir.ozone.ru/s3/multimedia-m/c1000/6641622850.jpg',
      ),
      Product(
        id: 5,
        name: 'Crystal Tint 01 Vintage Apple',
        brand: 'Clio',
        category: 'Декоративная',
        volume: '3.4 г',
        expirationDate: '10.2028',
        rating: 4.9,
        isFavorite: false,
        imageUrl:
        'https://pcdn.goldapple.ru/p/p/19000197603/imgmain.jpg',
      ),
    ]);
    emit(ProductsLoaded(List.from(_products), _categoryFilter));
  }

  void addProduct(Product product) {
    _products.add(product);
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) _products[index] = product;
    emit(ProductsLoaded(_filtered(), _categoryFilter));
  }

  void deleteProduct(int id) {
    _products.removeWhere((p) => p.id == id);
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
