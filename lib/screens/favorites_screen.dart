import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          final favs = state.favorites;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CategoryFilterBar(
                  selected: state.categoryFilter,
                  onChanged: cubit.setCategoryFilter,
                ),
              ),
              Expanded(
                child: favs.isEmpty
                    ? const Center(child: Text('Нет избранных товаров'))
                    : ListView.builder(
                  itemCount: favs.length,
                  itemBuilder: (_, i) {
                    final p = favs[i];
                    return ProductTile(
                      product: p,
                      onDelete: () => cubit.deleteProduct(p.id),
                      onToggleFavorite: () => cubit.toggleFavorite(p.id),
                      onEdit: null,
                      onOpen: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: p),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
