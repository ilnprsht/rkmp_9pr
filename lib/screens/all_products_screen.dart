import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/products_cubit.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is! ProductsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<ProductsCubit>();
        final products = state.products;

        return Scaffold(
          appBar: AppBar(title: const Text('Все товары')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryFilterBar(
                  selected: state.category,
                  onChanged: (v) => cubit.setCategoryFilter(v),
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text('Ничего не найдено'))
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (_, i) {
                          final p = products[i];
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('productCreate');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
