import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/products_cubit.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/product_tile.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (!state.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<ProductsCubit>();
        final products = state.filteredProducts;

        return Scaffold(
          appBar: AppBar(title: const Text('Все товары')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryFilterBar(
                  selected: state.categoryFilter,
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('newProduct');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
