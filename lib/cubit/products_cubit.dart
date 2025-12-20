import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/care_plan_entry.dart';
import '../models/product.dart';
import '../models/shopping_item.dart';

class ProductsState extends Equatable {
  static const _sentinel = Object();
  final List<Product> products;
  final String? categoryFilter;
  final String searchQuery;
  final List<CarePlanEntry> carePlan;
  final List<ShoppingItem> shoppingList;
  final bool isInitialized;

  const ProductsState({
    this.products = const [],
    this.categoryFilter,
    this.searchQuery = '',
    this.carePlan = const [],
    this.shoppingList = const [],
    this.isInitialized = false,
  });

  ProductsState copyWith({
    List<Product>? products,
    Object? categoryFilter = _sentinel,
    String? searchQuery,
    List<CarePlanEntry>? carePlan,
    List<ShoppingItem>? shoppingList,
    bool? isInitialized,
  }) {
    return ProductsState(
      products: products ?? this.products,
      categoryFilter: categoryFilter == _sentinel
          ? this.categoryFilter
          : categoryFilter as String?,
      searchQuery: searchQuery ?? this.searchQuery,
      carePlan: carePlan ?? this.carePlan,
      shoppingList: shoppingList ?? this.shoppingList,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  List<Product> get filteredProducts {
    Iterable<Product> result = products;
    if (categoryFilter != null) {
      result = result.where((p) => p.category == categoryFilter);
    }
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      result = result.where(
        (p) =>
            p.name.toLowerCase().contains(q) ||
            p.brand.toLowerCase().contains(q),
      );
    }
    return UnmodifiableListView(result);
  }

  @override
  List<Object?> get props =>
      [
        products,
        categoryFilter,
        searchQuery,
        carePlan,
        shoppingList,
        isInitialized
      ];
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(const ProductsState());

  void loadInitial() {
    const initialProducts = [
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
        imageUrl: 'https://pcdn.goldapple.ru/p/p/19000197603/imgmain.jpg',
      ),
    ];

    emit(
      state.copyWith(
        products: initialProducts,
        isInitialized: true,
        carePlan: _defaultCarePlan(),
      ),
    );
  }

  void addProduct(Product product) {
    final updated = List<Product>.from(state.products)..add(product);
    emit(state.copyWith(products: updated));
  }

  void updateProduct(Product product) {
    final updated = state.products.map((p) {
      if (p.id == product.id) return product;
      return p;
    }).toList();
    emit(state.copyWith(products: updated));
  }

  void deleteProduct(int id) {
    final updatedProducts =
        state.products.where((p) => p.id != id).toList(growable: false);

    final updatedPlan = state.carePlan
        .map(
          (e) => e.copyWith(
            productIds: e.productIds.where((pid) => pid != id).toList(),
          ),
        )
        .toList();
    final updatedShopping =
        state.shoppingList.where((item) => item.productId != id).toList();

    emit(
      state.copyWith(
        products: updatedProducts,
        carePlan: updatedPlan,
        shoppingList: updatedShopping,
      ),
    );
  }

  void toggleFavorite(int id) {
    final updated = state.products.map((p) {
      if (p.id == id) {
        return p.copyWith(isFavorite: !p.isFavorite);
      }
      return p;
    }).toList();
    emit(state.copyWith(products: updated));
  }

  void setCategoryFilter(String? category) {
    emit(state.copyWith(categoryFilter: category));
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<Product> favorites() {
    final filtered = state.filteredProducts;
    return filtered.where((p) => p.isFavorite).toList(growable: false);
  }

  void addToCarePlan(String day, int productId) {
    final updated = state.carePlan.map((entry) {
      if (entry.day == day) {
        final unique = {...entry.productIds, productId}.toList();
        return entry.copyWith(productIds: unique);
      }
      return entry;
    }).toList();
    emit(state.copyWith(carePlan: updated));
  }

  void removeFromCarePlan(String day, int productId) {
    final updated = state.carePlan.map((entry) {
      if (entry.day == day) {
        return entry.copyWith(
          productIds: entry.productIds.where((id) => id != productId).toList(),
        );
      }
      return entry;
    }).toList();
    emit(state.copyWith(carePlan: updated));
  }

  void addToShoppingList(int productId) {
    final exists = state.shoppingList.any((i) => i.productId == productId);
    if (exists) return;
    final updated = [
      ...state.shoppingList,
      ShoppingItem(productId: productId, isAdded: true),
    ];
    emit(state.copyWith(shoppingList: updated));
  }

  void removeFromShoppingList(int productId) {
    final updated =
        state.shoppingList.where((i) => i.productId != productId).toList();
    emit(state.copyWith(shoppingList: updated));
  }

  Product? findById(int id) {
    try {
      return state.products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Product> productsByIds(List<int> ids) {
    final idSet = ids.toSet();
    return state.products.where((p) => idSet.contains(p.id)).toList();
  }

  static List<CarePlanEntry> _defaultCarePlan() {
    const days = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
      'Воскресенье',
    ];
    return days.map((d) => CarePlanEntry(day: d, productIds: const [])).toList();
  }
}
