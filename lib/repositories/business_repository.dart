import '../models/business_models.dart';

/// Заглушка для поставки бизнес-данных.
class BusinessRepository {
  BusinessSnapshot loadSnapshot() => const BusinessSnapshot(
        revenue: 2.9,
        growth: 18.4,
        activeClients: 1240,
        activeCampaigns: 4,
      );

  List<InventoryItem> loadInventory() => const [
        InventoryItem(
          sku: 'SKU-201',
          title: 'Линейка ухода Glow Routine',
          stock: 24,
          reorderPoint: 18,
          demandIndex: 82,
        ),
        InventoryItem(
          sku: 'SKU-144',
          title: 'Ароматы Good Girl Gone Bad',
          stock: 8,
          reorderPoint: 12,
          demandIndex: 91,
        ),
        InventoryItem(
          sku: 'SKU-310',
          title: 'Кушоны с SPF 50+',
          stock: 64,
          reorderPoint: 25,
          demandIndex: 55,
        ),
      ];

  List<Campaign> loadCampaigns() => const [
        Campaign(
          id: 'CMP-01',
          title: 'Весенняя акция -20%',
          status: CampaignStatus.active,
          conversion: 4.2,
          budgetUsed: 62,
        ),
        Campaign(
          id: 'CMP-02',
          title: 'Ретаргетинг на брошенные корзины',
          status: CampaignStatus.paused,
          conversion: 2.7,
          budgetUsed: 34,
        ),
        Campaign(
          id: 'CMP-03',
          title: 'Лояльность: бонусы за обзоры',
          status: CampaignStatus.draft,
          conversion: 0.0,
          budgetUsed: 0,
        ),
      ];

  List<LoyaltyTier> loadLoyalty() => const [
        LoyaltyTier(
          name: 'Starter',
          members: 540,
          benefits: 'Бесплатная доставка от 3 000₽',
        ),
        LoyaltyTier(
          name: 'Pro',
          members: 320,
          benefits: '5% кешбэк + ранний доступ',
        ),
        LoyaltyTier(
          name: 'Icon',
          members: 86,
          benefits: 'Персональные предложения + private-sale',
        ),
      ];

  List<SupportTicket> loadTickets() => const [
        SupportTicket(
          id: 'REQ-1001',
          topic: 'Обмен оттенка помады',
          channel: 'Чат',
          resolved: false,
        ),
        SupportTicket(
          id: 'REQ-1002',
          topic: 'Вопрос по бонусным баллам',
          channel: 'Email',
          resolved: true,
        ),
        SupportTicket(
          id: 'REQ-1003',
          topic: 'Уточнение состава сыворотки',
          channel: 'Телефон',
          resolved: false,
        ),
      ];
}
