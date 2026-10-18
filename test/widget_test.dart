import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pr2/main.dart';

void main() {
  testWidgets('BI tool page renders content', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.text('НАЗВАНИЕ ПРИЛОЖЕНИЯ'), findsOneWidget);
    expect(find.text('Microsoft Power BI'), findsOneWidget);
    expect(find.text('Ковалев А.Э., ИКБО-66-23'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    expect(find.byType(Card), findsWidgets);
  });

  testWidgets('Horizontal image list exists', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('Card tap shows SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.text('Дашборды'), findsOneWidget);
    expect(find.text('Экспорт'), findsOneWidget);

    await tester.tap(find.text('Дашборды').first);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Дашборды', skipOffstage: false), findsWidgets);
  });
}
