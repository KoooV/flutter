import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageAsset,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  /// Идентификационный номер пункта в базе данных (может быть `null` для
  /// объектов, ещё не сохранённых в БД).
  final int? id;
  final String title;
  final String subtitle;
  final String description;
  final String imageAsset;
  final IconData leadingIcon;
  final IconData trailingIcon;
}
