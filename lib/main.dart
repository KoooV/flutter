import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr2/di/injection_container.dart';
import 'package:pr2/bloc/home/home_bloc.dart';
import 'package:pr2/bloc/theme/theme_cubit.dart';
import 'package:pr2/models/menu_item.dart';
import 'package:pr2/pages/detail_page.dart';
import 'package:pr2/pages/home_page.dart';
import 'package:pr2/pages/loading_page.dart';
import 'package:pr2/pages/login_page.dart';
import 'package:pr2/pages/profile_page.dart';
import 'package:pr2/pages/register_page.dart';
import 'package:pr2/routes.dart';
import 'package:pr2/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем DI-контейнер (база Drift, репозиторий, BLoC, Cubit темы)
  // перед запуском приложения. UI-слой не создаёт эти объекты вручную.
  await configureDependencies();

  runApp(
    BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
      child: const BiToolsApp(),
    ),
  );
}

/// Корневой виджет приложения.
///
/// Тема пересчитывается реактивно из [ThemeCubit] через [BlocBuilder] внутри
/// `MaterialApp.builder`, поэтому переключение режима темы не сбрасывает
/// текущий маршрут навигации.
class BiToolsApp extends StatelessWidget {
  const BiToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BI-инструменты',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // themeMode не используется напрямую для переключения — реальная тема
      // задаётся через Theme-визит в builder (см. ниже), чтобы навигация
      // не сбрасывалась при смене режима.
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.loading,
      routes: {
        AppRoutes.loading: (_) => const LoadingPage(),
        AppRoutes.login: (_) => LoginPage(),
        AppRoutes.register: (_) => RegisterPage(),
        AppRoutes.home: (_) => HomePage(bloc: getIt<HomeBloc>()),
        AppRoutes.profile: (_) => ProfilePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          final item = settings.arguments as MenuItem;
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => DetailPage(item: item),
          );
        }
        return null;
      },
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            final theme =
                themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;
            return Theme(data: theme, child: child!);
          },
        );
      },
    );
  }
}
