import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../cubit/products_cubit.dart';
import '../models/product.dart';
import '../screens/about_screen.dart';
import '../screens/all_products_screen.dart';
import '../screens/care_plan_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_form_screen.dart';
import '../screens/shopping_list_screen.dart';
import '../screens/stats_screen.dart';

GoRouter createRouter(ProductsCubit cubit) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (_, __) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'catalog',
            name: 'catalog',
            builder: (_, __) => const AllProductsScreen(),
          ),
          GoRoute(
            path: 'favorites',
            name: 'favorites',
            builder: (_, __) => const FavoritesScreen(),
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (_, __) => const AboutScreen(),
          ),
          GoRoute(
            path: 'planning',
            name: 'planning',
            builder: (_, __) => const CarePlanScreen(),
          ),
          GoRoute(
            path: 'shopping',
            name: 'shopping',
            builder: (_, __) => const ShoppingListScreen(),
          ),
          GoRoute(
            path: 'stats',
            name: 'stats',
            builder: (_, __) => const StatsScreen(),
          ),
          GoRoute(
            path: 'product/new',
            name: 'newProduct',
            builder: (_, state) {
              final editing = state.extra;
              return ProductFormScreen(
                editing: editing is Product ? editing : null,
              );
            },
          ),
          GoRoute(
            path: 'product/:id',
            name: 'productDetails',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              final product =
                  id != null ? cubit.findById(id) : null;
              return ProductDetailScreen(product: product);
            },
          ),
        ],
      ),
    ],
  );
}
