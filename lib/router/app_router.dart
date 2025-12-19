import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/products_cubit.dart';
import '../models/product.dart';
import '../screens/all_products_screen.dart';
import '../screens/business/business_hub_screen.dart';
import '../screens/business/inventory_overview_screen.dart';
import '../screens/business/loyalty_program_screen.dart';
import '../screens/business/marketing_campaigns_screen.dart';
import '../screens/business/sales_analytics_screen.dart';
import '../screens/business/support_center_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_form_screen.dart';
import 'app_shell.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/catalog',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              AppShell(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/catalog',
                  name: 'catalog',
                  builder: (context, state) => const AllProductsScreen(),
                  routes: [
                    GoRoute(
                      path: 'create',
                      name: 'productCreate',
                      builder: (context, state) => const ProductFormScreen(),
                    ),
                    GoRoute(
                      path: ':id',
                      name: 'productDetail',
                      builder: (context, state) {
                        final product = _resolveProduct(context, state);
                        return ProductDetailScreen(product: product);
                      },
                      routes: [
                        GoRoute(
                          path: 'edit',
                          name: 'productEdit',
                          builder: (context, state) {
                            final product = _resolveProduct(context, state);
                            return ProductFormScreen(editing: product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/favorites',
                  name: 'favorites',
                  builder: (context, state) => const FavoritesScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/business',
                  name: 'business',
                  builder: (context, state) => const BusinessHubScreen(),
                  routes: [
                    GoRoute(
                      path: 'analytics',
                      name: 'analytics',
                      builder: (context, state) => const SalesAnalyticsScreen(),
                    ),
                    GoRoute(
                      path: 'inventory',
                      name: 'inventory',
                      builder: (context, state) => const InventoryOverviewScreen(),
                    ),
                    GoRoute(
                      path: 'campaigns',
                      name: 'campaigns',
                      builder: (context, state) =>
                          const MarketingCampaignsScreen(),
                    ),
                    GoRoute(
                      path: 'loyalty',
                      name: 'loyalty',
                      builder: (context, state) => const LoyaltyProgramScreen(),
                    ),
                    GoRoute(
                      path: 'support',
                      name: 'support',
                      builder: (context, state) => const SupportCenterScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Неизвестный маршрут: ${state.uri.toString()}'),
        ),
      ),
    );
  }

  static Product _resolveProduct(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    if (extra is Product) return extra;
    final id = int.tryParse(state.pathParameters['id'] ?? '');
    final cubit = context.read<ProductsCubit>();
    if (id != null && cubit.state is ProductsLoaded) {
      final loaded = cubit.state as ProductsLoaded;
      return loaded.products.firstWhere(
        (p) => p.id == id,
        orElse: () => loaded.products.first,
      );
    }
    throw Exception('Продукт не найден');
  }
}
