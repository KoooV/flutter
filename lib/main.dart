import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pr2/pages/login_page.dart';
import 'package:pr2/pages/register_page.dart';
import 'package:pr2/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasAccount = prefs.getBool('has_account') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BI-инструменты',
      initialRoute: hasAccount ? '/login' : '/register',
      routes: {
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/profile': (_) => ProfilePage(),
      },
    ),
  );
}
