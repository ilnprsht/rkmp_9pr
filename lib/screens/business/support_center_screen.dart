import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/business/business_cubit.dart';
import '../../models/business_models.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Сервис и поддержка')),
          body: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.tickets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final ticket = state.tickets[i];
              return Card(
                child: ListTile(
                  leading: Icon(
                    ticket.resolved ? Icons.check_circle : Icons.pending_actions,
                    color: ticket.resolved ? Colors.green : Colors.orange,
                  ),
                  title: Text(ticket.topic),
                  subtitle: Text('Канал: ${ticket.channel} • №${ticket.id}'),
                  trailing: ticket.resolved
                      ? const Text('Закрыто')
                      : TextButton(
                          onPressed: () => context.read<BusinessCubit>().resolveTicket(ticket.id),
                          child: const Text('Закрыть'),
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
