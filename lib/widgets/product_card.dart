import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onToggleFavorite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onToggleFavorite,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            if ((product.imageUrl ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl!,
                  height: 500,
                  width: 500,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox(
                    height: 220,
                    child: Center(child: Icon(Icons.broken_image, size: 48)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Остальная информация
            Text('Бренд: ${product.brand}'),
            Text('Категория: ${product.category}'),
            Text('Объём: ${product.volume}'),
            Text('Срок годности: ${product.expirationDate}'),
            Text('Рейтинг: ★ ${product.rating.toStringAsFixed(1)}'),
            const Divider(height: 24),

            // Кнопки действий
            Row(
              children: [
                IconButton(
                  tooltip: 'Избранное',
                  icon: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: onToggleFavorite,
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onDelete,
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
