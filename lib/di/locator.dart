import 'package:get_it/get_it.dart';
import '../cubit/products_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  if (getIt.isRegistered<ProductsCubit>()) return;

  getIt.registerLazySingleton<ProductsCubit>(() => ProductsCubit()..loadInitial());
}
