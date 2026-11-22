import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pr2/data/database/menu_items_table.dart';

part 'app_database.g.dart';

/// Экземпляр локальной базы данных Drift (Singleton).
@DriftDatabase(tables: [MenuItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(super.e);

  static AppDatabase? _instance;

  /// Создаёт (при необходимости) файл базы данных и применяет схему.
  ///
  /// При первом запуске таблицы создаются автоматически через [migrationStrategy].
  static Future<AppDatabase> create() async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'pr2_app.sqlite'));
    _instance = AppDatabase._internal(NativeDatabase.createInBackground(file));
    return _instance!;
  }

  static AppDatabase get instance {
    if (_instance == null) {
      throw StateError(
        'AppDatabase ещё не инициализирован. '
        'Сначала вызовите AppDatabase.create() в точке входа приложения.',
      );
    }
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
      );
}
