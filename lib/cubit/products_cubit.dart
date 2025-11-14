import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(const ProductsState()) {
    loadInitial();
  }

  void loadInitial() {
    final data = [
      Product(
        id: 1,
        name: 'MACximal Matte Lipstick Russian Red',
        brand: 'MAC',
        category: 'Декоративная',
        volume: '3.5 г',
        expirationDate: '08.2027',
        rating: 4.7,
        isFavorite: false,
        imageUrl:
        'https://ir.ozone.ru/s3/multimedia-1-i/c1000/7038468774.jpg',
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
    ];
    emit(state.copyWith(products: data));
  }

  void addProduct(Product p) {
    final updated = List<Product>.from(state.products)..add(p);
    emit(state.copyWith(products: updated));
  }

  void updateProduct(Product p) {
    final updated = state.products.map((e) => e.id == p.id ? p : e).toList();
    emit(state.copyWith(products: updated));
  }

  void deleteProduct(int id) {
    final updated = state.products.where((e) => e.id != id).toList();
    emit(state.copyWith(products: updated));
  }

  void toggleFavorite(int id) {
    final updated = state.products.map((p) {
      if (p.id == id) return p.copyWith(isFavorite: !p.isFavorite);
      return p;
    }).toList();
    emit(state.copyWith(products: updated));
  }

  void setCategoryFilter(String? filter) {
    emit(state.copyWith(categoryFilter: filter));
  }
}
