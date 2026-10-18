import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pr2/main.dart';

void main() {
  testWidgets('BI tool page renders content', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.text('BI-ИНСТРУМЕНТЫ'), findsOneWidget);
    expect(find.text('Microsoft Power BI'), findsOneWidget);
    expect(find.text('Ковалев А.Э., ИКБО-66-23'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('Image cycles on button tap and image tap', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.byKey(const ValueKey('bi_image_0')), findsOneWidget);

    await tester.tap(find.text('Следующая картинка'));
    await tester.pump();

    expect(find.byKey(const ValueKey('bi_image_0')), findsNothing);
    expect(find.byKey(const ValueKey('bi_image_1')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('bi_image_1')));
    await tester.pump();

    expect(find.byKey(const ValueKey('bi_image_1')), findsNothing);
    expect(find.byKey(const ValueKey('bi_image_2')), findsOneWidget);
  });
}
