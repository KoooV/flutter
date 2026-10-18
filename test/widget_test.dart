import 'package:flutter_test/flutter_test.dart';

import 'package:pr2/main.dart';

void main() {
  testWidgets('BI tool page renders content', (WidgetTester tester) async {
    await tester.pumpWidget(const BiToolsApp());

    expect(find.text('BI-ИНСТРУМЕНТЫ'), findsOneWidget);
    expect(find.text('Microsoft Power BI'), findsOneWidget);
    expect(find.text('Ковалев А.Э., ИКБО-66-23'), findsOneWidget);
  });
}
