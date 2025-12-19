import 'package:equatable/equatable.dart';

class BusinessSnapshot extends Equatable {
  final double revenue;
  final double growth;
  final int activeClients;
  final int activeCampaigns;

  const BusinessSnapshot({
    required this.revenue,
    required this.growth,
    required this.activeClients,
    required this.activeCampaigns,
  });

  const BusinessSnapshot.empty()
      : revenue = 0,
        growth = 0,
        activeClients = 0,
        activeCampaigns = 0;

  BusinessSnapshot copyWith({
    double? revenue,
    double? growth,
    int? activeClients,
    int? activeCampaigns,
  }) {
    return BusinessSnapshot(
      revenue: revenue ?? this.revenue,
      growth: growth ?? this.growth,
      activeClients: activeClients ?? this.activeClients,
      activeCampaigns: activeCampaigns ?? this.activeCampaigns,
    );
  }

  @override
  List<Object?> get props => [revenue, growth, activeClients, activeCampaigns];
}

class InventoryItem extends Equatable {
  final String sku;
  final String title;
  final int stock;
  final int reorderPoint;
  final int demandIndex;

  const InventoryItem({
    required this.sku,
    required this.title,
    required this.stock,
    required this.reorderPoint,
    required this.demandIndex,
  });

  InventoryItem copyWith({
    String? sku,
    String? title,
    int? stock,
    int? reorderPoint,
    int? demandIndex,
  }) {
    return InventoryItem(
      sku: sku ?? this.sku,
      title: title ?? this.title,
      stock: stock ?? this.stock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      demandIndex: demandIndex ?? this.demandIndex,
    );
  }

  @override
  List<Object?> get props => [sku, title, stock, reorderPoint, demandIndex];
}

enum CampaignStatus { draft, active, paused }

class Campaign extends Equatable {
  final String id;
  final String title;
  final CampaignStatus status;
  final double conversion;
  final double budgetUsed;

  const Campaign({
    required this.id,
    required this.title,
    required this.status,
    required this.conversion,
    required this.budgetUsed,
  });

  Campaign copyWith({
    String? id,
    String? title,
    CampaignStatus? status,
    double? conversion,
    double? budgetUsed,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      conversion: conversion ?? this.conversion,
      budgetUsed: budgetUsed ?? this.budgetUsed,
    );
  }

  @override
  List<Object?> get props => [id, title, status, conversion, budgetUsed];
}

class LoyaltyTier extends Equatable {
  final String name;
  final int members;
  final String benefits;

  const LoyaltyTier({
    required this.name,
    required this.members,
    required this.benefits,
  });

  LoyaltyTier copyWith({
    String? name,
    int? members,
    String? benefits,
  }) {
    return LoyaltyTier(
      name: name ?? this.name,
      members: members ?? this.members,
      benefits: benefits ?? this.benefits,
    );
  }

  @override
  List<Object?> get props => [name, members, benefits];
}

class SupportTicket extends Equatable {
  final String id;
  final String topic;
  final String channel;
  final bool resolved;

  const SupportTicket({
    required this.id,
    required this.topic,
    required this.channel,
    required this.resolved,
  });

  SupportTicket copyWith({
    String? id,
    String? topic,
    String? channel,
    bool? resolved,
  }) {
    return SupportTicket(
      id: id ?? this.id,
      topic: topic ?? this.topic,
      channel: channel ?? this.channel,
      resolved: resolved ?? this.resolved,
    );
  }

  @override
  List<Object?> get props => [id, topic, channel, resolved];
}
