import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/business/business_cubit.dart';

class BusinessHubScreen extends StatelessWidget {
  const BusinessHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        final snapshot = state.snapshot;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Бизнес-центр'),
            actions: [
              IconButton(
                tooltip: 'Обновить данные',
                onPressed: context.read<BusinessCubit>().load,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Управление состоянием',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Используем Cubit (flutter_bloc) — он остаётся простым, но покрывает обновления '
                        'каталога и бизнес-метрик без лишнего boilerplate. Если объём данных вырастет, '
                        'можно заменить репозитории на API и сохранить архитектуру.',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _StatChip(
                            label: 'Выручка, млн ₽',
                            value: snapshot.revenue.toStringAsFixed(1),
                          ),
                          _StatChip(
                            label: 'Рост, %',
                            value: snapshot.growth.toStringAsFixed(1),
                          ),
                          _StatChip(
                            label: 'Клиентов',
                            value: snapshot.activeClients.toString(),
                          ),
                          _StatChip(
                            label: 'Активных кампаний',
                            value: snapshot.activeCampaigns.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _HubButton(
                icon: Icons.bar_chart,
                title: 'Аналитика продаж',
                subtitle: 'Сводка KPI и динамика роста',
                onTap: () => context.pushNamed('analytics'),
              ),
              _HubButton(
                icon: Icons.inventory_2_outlined,
                title: 'Запасы и поставки',
                subtitle: 'Контроль складских остатков и точек дозаказа',
                onTap: () => context.pushNamed('inventory'),
              ),
              _HubButton(
                icon: Icons.campaign_outlined,
                title: 'Маркетинговые кампании',
                subtitle: 'Управление статусами и конверсиями',
                onTap: () => context.pushNamed('campaigns'),
              ),
              _HubButton(
                icon: Icons.workspace_premium_outlined,
                title: 'Программа лояльности',
                subtitle: 'Метрики вовлечённости по уровням',
                onTap: () => context.pushNamed('loyalty'),
              ),
              _HubButton(
                icon: Icons.support_agent,
                title: 'Сервис и поддержка',
                subtitle: 'Скорость закрытия заявок и каналы',
                onTap: () => context.pushNamed('support'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HubButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HubButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
