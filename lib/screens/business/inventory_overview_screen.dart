import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/business/business_cubit.dart';
import '../../models/business_models.dart';

class InventoryOverviewScreen extends StatelessWidget {
  const InventoryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Запасы и поставки')),
          body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.inventory.length,
            itemBuilder: (_, i) {
              final item = state.inventory[i];
              final isAlert = item.stock <= item.reorderPoint;
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(
                    'Остаток: ${item.stock} • Точка дозаказа: ${item.reorderPoint} • Спрос: ${item.demandIndex}%',
                  ),
                  leading: Icon(
                    isAlert ? Icons.error_outline : Icons.check_circle_outline,
                    color: isAlert ? Colors.redAccent : Colors.green,
                  ),
                  trailing: TextButton(
                    onPressed: () => context.read<BusinessCubit>().restock(item.sku, 12),
                    child: const Text('Дозаказ +12'),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
