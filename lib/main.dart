import 'package:flutter/material.dart';
import 'package:pr2/di/injection_container.dart';
import 'package:pr2/bloc/home/home_bloc.dart';
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

  // Инициализируем DI-контейнер (база Drift, репозиторий, BLoC)
  // перед запуском приложения. UI-слой не создаёт эти объекты вручную.
  await configureDependencies();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BI-инструменты',
      theme: AppTheme.dark,
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
    ),
  );
}
