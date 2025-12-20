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
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: _SearchField(
                    initial: state.searchQuery,
                    onChanged: context.read<ProductsCubit>().setSearchQuery,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: products.isEmpty
                      ? const Center(
                          child:
                              Text('Добавьте товары, которые хотите купить позже.'),
                        )
                      : ListView.separated(
                          itemCount: products.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (_, i) {
                            final product = products[i];
                            return Card(
                              child: ListTile(
                                leading: Image.network(product.imageUrl,
                                    width: 56, fit: BoxFit.cover),
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
                ),
              ],
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
    final query = state.searchQuery.toLowerCase();
    return state.products.where((p) {
      final matchesList = ids.contains(p.id);
      if (!matchesList) return false;
      if (query.isEmpty) return true;
      return p.name.toLowerCase().contains(query) ||
          p.brand.toLowerCase().contains(query);
    }).toList();
  }
}

class _SearchField extends StatelessWidget {
  final String initial;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.initial,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initial);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Поиск в списке покупок',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
