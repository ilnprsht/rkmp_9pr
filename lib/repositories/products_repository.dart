import '../models/product.dart';

/// In-memory хранилище товаров.
///
/// Repository инкапсулирует данные и упрощает DI — его можно заменить
/// на API/БД без переписывания Cubit.
class ProductsRepository {
  final List<Product> _products = [
    const Product(
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
    const Product(
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
    const Product(
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
    const Product(
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
    const Product(
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

  List<Product> loadProducts() => List.unmodifiable(_products);

  void save(Product product) {
    _products.add(product);
  }

  void update(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  void delete(int id) {
    _products.removeWhere((p) => p.id == id);
  }
}
