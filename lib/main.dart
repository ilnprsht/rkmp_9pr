import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/business/business_cubit.dart';
import 'cubit/products_cubit.dart';
import 'repositories/business_repository.dart';
import 'repositories/products_repository.dart';
import 'router/app_router.dart';

void main() {
  final router = AppRouter.createRouter();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ProductsRepository()),
        RepositoryProvider(create: (_) => BusinessRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductsCubit(context.read<ProductsRepository>())..loadInitial(),
          ),
          BlocProvider(
            create: (context) =>
                BusinessCubit(context.read<BusinessRepository>())..load(),
          ),
        ],
        child: MyApp(router: router),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Каталог косметики',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
