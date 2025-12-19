import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/business_models.dart';
import '../../repositories/business_repository.dart';

part 'business_state.dart';

class BusinessCubit extends Cubit<BusinessState> {
  BusinessCubit(this._repository) : super(const BusinessState.initial());

  final BusinessRepository _repository;

  void load() {
    emit(
      BusinessState(
        snapshot: _repository.loadSnapshot(),
        inventory: _repository.loadInventory(),
        campaigns: _repository.loadCampaigns(),
        loyalty: _repository.loadLoyalty(),
        tickets: _repository.loadTickets(),
      ),
    );
  }

  void resolveTicket(String id) {
    final updatedTickets = state.tickets
        .map((t) => t.id == id ? t.copyWith(resolved: true) : t)
        .toList();
    emit(state.copyWith(tickets: updatedTickets));
  }

  void toggleCampaign(String id) {
    final updated = state.campaigns.map((c) {
      if (c.id != id) return c;
      final nextStatus = switch (c.status) {
        CampaignStatus.active => CampaignStatus.paused,
        CampaignStatus.paused => CampaignStatus.active,
        CampaignStatus.draft => CampaignStatus.active,
      };
      return c.copyWith(status: nextStatus);
    }).toList();

    emit(
      state.copyWith(
        campaigns: updated,
        snapshot: state.snapshot
            .copyWith(activeCampaigns: updated.where((c) => c.status == CampaignStatus.active).length),
      ),
    );
  }

  void restock(String sku, int amount) {
    final updatedInventory = state.inventory.map((i) {
      if (i.sku != sku) return i;
      return i.copyWith(stock: i.stock + amount);
    }).toList();
    emit(state.copyWith(inventory: updatedInventory));
  }
}
