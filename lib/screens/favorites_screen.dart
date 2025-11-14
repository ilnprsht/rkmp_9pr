import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is! ProductsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<ProductsCubit>();
        final items = cubit.favorites();

        return Scaffold(
          appBar: AppBar(title: const Text('Избранное')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryFilterBar(
                  selected: state.category,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductFormScreen(editing: p),
                          ),
                        );
                      },
                      onOpen: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: p),
                          ),
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
