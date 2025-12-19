import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/business/business_cubit.dart';
import '../../models/business_models.dart';

class MarketingCampaignsScreen extends StatelessWidget {
  const MarketingCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Маркетинговые кампании')),
          body: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.campaigns.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final campaign = state.campaigns[i];
              return Card(
                child: ListTile(
                  title: Text(campaign.title),
                  subtitle: Text(
                    'Конверсия: ${campaign.conversion.toStringAsFixed(1)}% • Бюджет: ${campaign.budgetUsed.toStringAsFixed(0)}% использовано',
                  ),
                  trailing: _StatusBadge(status: campaign.status),
                  onTap: () => context.read<BusinessCubit>().toggleCampaign(campaign.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final CampaignStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      CampaignStatus.active => ('Активна', Colors.green),
      CampaignStatus.paused => ('Пауза', Colors.orange),
      CampaignStatus.draft => ('Черновик', Colors.grey),
    };
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.12),
      labelStyle: TextStyle(color: color.shade700),
    );
  }
}
