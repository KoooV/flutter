import 'package:flutter/material.dart';
import 'package:pr2/theme/app_theme.dart';
import 'package:pr2/pages/login_page.dart';
import 'package:pr2/pages/register_page.dart';
import 'package:pr2/pages/bi_tools_page.dart';
import 'package:pr2/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BI-инструменты',
      theme: AppTheme.dark,
      initialRoute: '/register',
      routes: {
        '/': (_) => const BiToolsApp(),
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/profile': (_) => ProfilePage(),
      },
    ),
  );
}
