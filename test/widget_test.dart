import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pr2/pages/login_page.dart';
import 'package:pr2/pages/register_page.dart';
import 'package:pr2/pages/profile_page.dart';

void main() {
  testWidgets('Login page renders', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    expect(find.text('Добро пожаловать!'), findsOneWidget);
    expect(find.text('Войти'), findsOneWidget);
    expect(find.text('Зарегистрируйтесь'), findsOneWidget);
  });

  testWidgets('Register page renders', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    expect(find.text('Регистрация'), findsOneWidget);
    expect(find.text('Зарегистрироваться'), findsOneWidget);
    expect(find.text('Войти'), findsOneWidget);
  });

  testWidgets('Profile page renders', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    expect(find.text('Профиль'), findsOneWidget);
    expect(find.text('Сохранить'), findsOneWidget);
  });
}
