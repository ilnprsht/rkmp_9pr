import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/business/business_cubit.dart';

class LoyaltyProgramScreen extends StatelessWidget {
  const LoyaltyProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Программа лояльности')),
          body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.loyalty.length,
            itemBuilder: (_, i) {
              final tier = state.loyalty[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('${tier.name} • ${tier.members} участников'),
                  subtitle: Text(tier.benefits),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
