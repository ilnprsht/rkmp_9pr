import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onEdit;
  final VoidCallback? onOpen;

  const ProductTile({
    super.key,
    required this.product,
    this.onDelete,
    this.onToggleFavorite,
    this.onEdit,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        onTap: onOpen, // <-- теперь onOpen работает
        leading: Image.network(product.imageUrl, width: 56, fit: BoxFit.cover),
        title: Text(product.name),
        subtitle: Text('${product.brand} • ${product.category}'),
        trailing: Wrap(
          spacing: 6,
          children: [
            IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.pinkAccent,
              ),
              onPressed: onToggleFavorite,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
