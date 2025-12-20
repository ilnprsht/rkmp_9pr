import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          final total = state.products.length;
          final favorites = state.products.where((p) => p.isFavorite).length;
          final categories = <String, int>{
            'Уходовая': 0,
            'Декоративная': 0,
            'Парфюмерия': 0,
          };
          for (final p in state.products) {
            categories[p.category] = (categories[p.category] ?? 0) + 1;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatCard(
                  title: 'Всего продуктов',
                  value: '$total',
                  color: Colors.pink.shade100,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Избранные',
                  value: '$favorites',
                  color: Colors.red.shade100,
                ),
                const SizedBox(height: 24),
                Text(
                  'По категориям',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...categories.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(child: Text(e.key)),
                        Chip(
                          label: Text(e.value.toString()),
                          backgroundColor: Colors.blue.shade50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
