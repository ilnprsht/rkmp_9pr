part of 'business_cubit.dart';

class BusinessState extends Equatable {
  final BusinessSnapshot snapshot;
  final List<InventoryItem> inventory;
  final List<Campaign> campaigns;
  final List<LoyaltyTier> loyalty;
  final List<SupportTicket> tickets;

  const BusinessState({
    required this.snapshot,
    required this.inventory,
    required this.campaigns,
    required this.loyalty,
    required this.tickets,
  });

  const BusinessState.initial()
      : snapshot = const BusinessSnapshot.empty(),
        inventory = const [],
        campaigns = const [],
        loyalty = const [],
        tickets = const [];

  BusinessState copyWith({
    BusinessSnapshot? snapshot,
    List<InventoryItem>? inventory,
    List<Campaign>? campaigns,
    List<LoyaltyTier>? loyalty,
    List<SupportTicket>? tickets,
  }) {
    return BusinessState(
      snapshot: snapshot ?? this.snapshot,
      inventory: inventory ?? this.inventory,
      campaigns: campaigns ?? this.campaigns,
      loyalty: loyalty ?? this.loyalty,
      tickets: tickets ?? this.tickets,
    );
  }

  @override
  List<Object?> get props => [snapshot, inventory, campaigns, loyalty, tickets];
}
