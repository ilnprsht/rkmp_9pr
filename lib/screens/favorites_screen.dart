import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/products_cubit.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (!state.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<ProductsCubit>();
        final items = cubit.favorites();

        return Scaffold(
          appBar: AppBar(title: const Text('Избранное')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: _SearchField(
                  initial: state.searchQuery,
                  onChanged: cubit.setSearchQuery,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryFilterBar(
                  selected: state.categoryFilter,
                  onChanged: cubit.setCategoryFilter,
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text('Нет избранных товаров'))
                    : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final p = items[i];
                    return ProductTile(
                      product: p,
                      onToggleFavorite: () =>
                          cubit.toggleFavorite(p.id),
                      onDelete: () => cubit.deleteProduct(p.id),
                      onEdit: () {
                        context.pushNamed(
                          'newProduct',
                          extra: p,
                        );
                      },
                      onOpen: () {
                        context.pushNamed(
                          'productDetails',
                          pathParameters: {'id': '${p.id}'},
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
        hintText: 'Поиск в избранном',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
