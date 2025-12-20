import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';

class CarePlanScreen extends StatelessWidget {
  const CarePlanScreen({super.key});

  Future<void> _pickProduct(BuildContext context, String day) async {
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
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(p.imageUrl),
              ),
              title: Text(p.name),
              subtitle: Text(p.brand),
              trailing: const Icon(Icons.add_circle_outline),
              onTap: () {
                cubit.addToCarePlan(day, p.id);
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
      appBar: AppBar(title: const Text('Планирование ухода')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.carePlan.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final entry = state.carePlan[i];
              final products = context.read<ProductsCubit>().productsByIds(entry.productIds);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            entry.day,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _pickProduct(context, entry.day),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (products.isEmpty)
                        const Text('Пока пусто. Добавьте продукты на этот день.'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: products
                            .map(
                              (p) => Chip(
                                label: Text(p.name),
                                onDeleted: () => context
                                    .read<ProductsCubit>()
                                    .removeFromCarePlan(entry.day, p.id),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
