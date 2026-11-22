import 'package:pr2/models/menu_item.dart';
import 'package:flutter/material.dart';

/// Локальная коллекция данных для домашней страницы.
/// Внешний слой данных не подключается, поэтому данные хранятся в памяти.
final List<MenuItem> menuItems = [
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
