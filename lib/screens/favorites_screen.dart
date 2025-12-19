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
                            onToggleFavorite: () => cubit.toggleFavorite(p.id),
                            onDelete: () => cubit.deleteProduct(p.id),
                            onEdit: () => context.pushNamed(
                              'productEdit',
                              pathParameters: {'id': p.id.toString()},
                              extra: p,
                            ),
                            onOpen: () => context.pushNamed(
                              'productDetail',
                              pathParameters: {'id': p.id.toString()},
                              extra: p,
                            ),
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
