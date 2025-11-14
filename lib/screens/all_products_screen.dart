import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Все товары')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          final items = state.filteredProducts;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryFilterBar(
                  selected: state.categoryFilter,
                  onChanged: cubit.setCategoryFilter,
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text('Каталог пуст'))
                    : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final p = items[i];
                    return ProductTile(
                      product: p,
                      onDelete: () => cubit.deleteProduct(p.id),
                      onToggleFavorite: () => cubit.toggleFavorite(p.id),
                      onEdit: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductFormScreen(editing: p),
                        ),
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProductFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
