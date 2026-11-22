import 'package:get_it/get_it.dart';
import 'package:pr2/bloc/theme/theme_cubit.dart';
import 'package:pr2/data/database/app_database.dart';
import 'package:pr2/data/repositories/menu_repository.dart';
import 'package:pr2/bloc/home/home_bloc.dart';

/// Глобальный экземпляр DI-контейнера GetIt.
final getIt = GetIt.instance;

/// Инициализирует зависимости приложения
Future<void> configureDependencies() async {
  final database = await AppDatabase.create();
  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepository(getIt<AppDatabase>()),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<MenuRepository>()),
  );

  // Cubit управления темой — один на всё приложение (ленивый синглтон).
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  await getIt<MenuRepository>().seedIfEmpty();
}

/// Освобождает ресурсы DI-контейнера
Future<void> dispose() async {
  try {
    await getIt<AppDatabase>().close();
  } finally {
    getIt.reset();
  }
}
