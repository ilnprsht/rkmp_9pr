import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _DashboardTile(
        title: 'Каталог',
        icon: Icons.list_alt,
        routeName: 'catalog',
        color: Colors.pink.shade100,
      ),
      _DashboardTile(
        title: 'Избранное',
        icon: Icons.favorite,
        routeName: 'favorites',
        color: Colors.red.shade100,
      ),
      _DashboardTile(
        title: 'Добавить товар',
        icon: Icons.add_box,
        routeName: 'newProduct',
        color: Colors.green.shade100,
      ),
      _DashboardTile(
        title: 'План ухода',
        icon: Icons.calendar_today,
        routeName: 'planning',
        color: Colors.blue.shade100,
      ),
      _DashboardTile(
        title: 'Список покупок',
        icon: Icons.shopping_cart_outlined,
        routeName: 'shopping',
        color: Colors.orange.shade100,
      ),
      _DashboardTile(
        title: 'Статистика',
        icon: Icons.insights,
        routeName: 'stats',
        color: Colors.purple.shade100,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог косметики'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('about'),
            icon: const Icon(Icons.info_outline),
            tooltip: 'О приложении',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: items
              .map(
                (item) => GestureDetector(
                  onTap: () => context.pushNamed(item.routeName),
                  child: Card(
                    color: item.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(item.icon, size: 42),
                          const SizedBox(height: 10),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _DashboardTile {
  final String title;
  final IconData icon;
  final String routeName;
  final Color color;

  _DashboardTile({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.color,
  });
}
