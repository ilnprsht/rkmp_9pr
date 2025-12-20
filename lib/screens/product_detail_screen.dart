import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/products_cubit.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product? product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('Товар не найден')),
      );
    }

    final cubit = context.read<ProductsCubit>();
    final fresh = cubit.state.products
        .firstWhere((p) => p.id == product!.id, orElse: () => product!);

    return Scaffold(
      appBar: AppBar(title: const Text('Информация о товаре')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  fresh.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(fresh.name,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Бренд: ${fresh.brand}'),
            Text('Категория: ${fresh.category}'),
            Text('Объем: ${fresh.volume}'),
            Text('Срок годности: ${fresh.expirationDate}'),
            Text('Рейтинг: ★ ${fresh.rating}'),
            const SizedBox(height: 24),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    fresh.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () => cubit.toggleFavorite(fresh.id),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    context.pushNamed('newProduct', extra: fresh);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    cubit.deleteProduct(fresh.id);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Удалить'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
