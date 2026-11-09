import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageAsset,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  final String title;
  final String subtitle;
  final String description;
  final String imageAsset;
  final IconData leadingIcon;
  final IconData trailingIcon;
}
