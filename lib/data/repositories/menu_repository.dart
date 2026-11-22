import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:pr2/data/database/app_database.dart';
import 'package:pr2/models/menu_item.dart';

/// Исходный набор пунктов меню, используемый для первичного заполнения БД.
final List<MenuItem> _seedMenuItems = [
  MenuItem(
    title: 'Дашборды',
    subtitle: 'Интерактивная визуализация данных',
    description:
        'Дашборд объединяет несколько визуализаций на одной странице '
        'для быстрого контроля ключевых показателей.',
    imageAsset: 'assets/images/bi_1.png',
    leadingIcon: Icons.dashboard,
    trailingIcon: Icons.arrow_forward_ios,
  ),
  MenuItem(
    title: 'Отчёты',
    subtitle: 'Создание и планирование отчётов',
    description:
        'Отчёты оформляют данные в виде таблиц и графиков, а также могут '
        'рассылаться по расписанию.',
    imageAsset: 'assets/images/bi_2.jpg',
    leadingIcon: Icons.assessment,
    trailingIcon: Icons.arrow_forward_ios,
  ),
  MenuItem(
    title: 'Источники',
    subtitle: 'Подключение к базам данных',
    description:
        'Power BI подключается к базам данных, файлам Excel, облачным '
        'сервисам и веб-страницам для загрузки исходных данных.',
    imageAsset: 'assets/images/bi_3.png',
    leadingIcon: Icons.storage,
    trailingIcon: Icons.arrow_forward_ios,
  ),
  MenuItem(
    title: 'DAX',
    subtitle: 'Вычисляемые меры и формулы',
    description:
        'DAX — язык формул Power BI для создания вычисляемых столбцов, '
        'мер и таблиц.',
    imageAsset: 'assets/images/bi_4.jpg',
    leadingIcon: Icons.functions,
    trailingIcon: Icons.arrow_forward_ios,
  ),
  MenuItem(
    title: 'Экспорт',
    subtitle: 'Выгрузка в Excel и PDF',
    description:
        'Готовые отчёты и данные можно выгрузить в Excel, PDF или PowerPoint.',
    imageAsset: 'assets/images/bi_5.png',
    leadingIcon: Icons.file_download,
    trailingIcon: Icons.arrow_forward_ios,
  ),
];

/// Репозиторий пунктов/элементов списка, построенный поверх локальной
class MenuRepository {
  MenuRepository(this._database);

  final AppDatabase _database;

  Future<void> seedIfEmpty() async {
    final existing = await _database.select(_database.menuItems).get();
    if (existing.isNotEmpty) return;

    for (final item in _seedMenuItems) {
      await _database.into(_database.menuItems).insert(
            MenuItemsCompanion.insert(
              title: item.title,
              subtitle: item.subtitle,
              description: item.description,
              imagePath: item.imageAsset,
            ),
          );
    }
  }

  Future<List<MenuItem>> getAllMenuItems() async {
    final entities = await _database.select(_database.menuItems).get();
    return entities.map(_toModel).toList();
  }

  Future<MenuItem?> getMenuItemById(int id) async {
    final query = _database.select(_database.menuItems)
      ..where((tbl) => tbl.id.equals(id));
    final items = await query.get();
    if (items.isEmpty) return null;
    return _toModel(items.first);
  }

  Future<int> insertMenuItem(MenuItem item) async {
    return await _database.into(_database.menuItems).insert(
          MenuItemsCompanion.insert(
            title: item.title,
            subtitle: item.subtitle,
            description: item.description,
            imagePath: item.imageAsset,
          ),
        );
  }

  Future<bool> updateMenuItem(MenuItem item) async {
    if (item.id == null) {
      throw ArgumentError('Необходимо указать id пункта для обновления');
    }
    return await _database.update(_database.menuItems).replace(
          MenuItemsCompanion(
            id: Value(item.id!),
            title: Value(item.title),
            subtitle: Value(item.subtitle),
            description: Value(item.description),
            imagePath: Value(item.imageAsset),
          ),
        );
  }

  Future<void> deleteMenuItem(int id) async {
    await _database.customStatement(
      'DELETE FROM menu_items WHERE id = ?',
      [id],
    );
  }

  MenuItem _toModel(MenuItemEntity entity) {
    return MenuItem(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      description: entity.description,
      imageAsset: entity.imagePath,
      leadingIcon: _leadingIconFor(entity.title),
      trailingIcon: Icons.arrow_forward_ios,
    );
  }

  IconData _leadingIconFor(String title) {
    switch (title) {
      case 'Дашборды':
        return Icons.dashboard;
      case 'Отчёты':
        return Icons.assessment;
      case 'Источники':
        return Icons.storage;
      case 'DAX':
        return Icons.functions;
      case 'Экспорт':
        return Icons.file_download;
      default:
        return Icons.list;
    }
  }
}
