import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../models/product.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  Future<void> _addItem(BuildContext context) async {
    final cubit = context.read<ProductsCubit>();
    final products = cubit.state.products;

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, i) {
            final p = products[i];
            final inList = cubit.state.shoppingList
                .any((item) => item.productId == p.id);
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(p.imageUrl)),
              title: Text(p.name),
              subtitle: Text(p.brand),
              trailing: inList
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Icon(Icons.add_shopping_cart),
              onTap: () {
                cubit.addToShoppingList(p.id);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список покупок')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = _shoppingProducts(state);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: products.isEmpty
                ? const Center(
                    child: Text('Добавьте товары, которые хотите купить позже.'),
                  )
                : ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final product = products[i];
                      return Card(
                        child: ListTile(
                          leading: Image.network(product.imageUrl, width: 56, fit: BoxFit.cover),
                          title: Text(product.name),
                          subtitle: Text(product.brand),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => context
                                .read<ProductsCubit>()
                                .removeFromShoppingList(product.id),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addItem(context),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Добавить'),
      ),
    );
  }

  List<Product> _shoppingProducts(ProductsState state) {
    final ids = state.shoppingList.map((e) => e.productId).toSet();
    return state.products.where((p) => ids.contains(p.id)).toList();
  }
}
