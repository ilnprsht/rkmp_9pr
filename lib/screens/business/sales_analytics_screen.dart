import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/business/business_cubit.dart';

class SalesAnalyticsScreen extends StatelessWidget {
  const SalesAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        final snap = state.snapshot;
        return Scaffold(
          appBar: AppBar(title: const Text('Аналитика продаж')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _KpiCard(label: 'Выручка, млн ₽', value: snap.revenue.toStringAsFixed(1)),
                    _KpiCard(label: 'Рост к прошлому месяцу', value: '${snap.growth.toStringAsFixed(1)}%'),
                    _KpiCard(label: 'Активных клиентов', value: snap.activeClients.toString()),
                    _KpiCard(label: 'Активных кампаний', value: snap.activeCampaigns.toString()),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: const [
                      _InsightTile(
                        title: 'Лидеры по конверсии',
                        details: 'Линейка Glow Routine и ароматы niche-сегмента дают 4.2% CR.',
                      ),
                      _InsightTile(
                        title: 'Кросс-селл',
                        details: 'Связка «сыворотка + SPF кушон» приносит +12% среднего чека.',
                      ),
                      _InsightTile(
                        title: 'Причины отмен',
                        details: 'Недостаток оттенков и задержки доставки в ПВЗ Центр.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;

  const _KpiCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  final String title;
  final String details;

  const _InsightTile({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: const Icon(Icons.trending_up),
      title: Text(title),
      subtitle: Text(details),
    );
  }
}
