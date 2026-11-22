import 'package:drift/drift.dart';

/// Таблица пунктов/элементов списка (BI-инструменты).
@DataClassName('MenuItemEntity')
class MenuItems extends Table {
  @override
  String get tableName => 'menu_items';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get subtitle => text().withLength(min: 1, max: 200)();
  TextColumn get description => text()();
  TextColumn get imagePath => text()();
}
