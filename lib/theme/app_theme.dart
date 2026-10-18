import 'package:flutter/material.dart';

class AppTheme {
  static const Color _black = Color(0xFF000000);

  static const Color scaffoldBackground = _black;
  static const Color surface = Color.fromARGB(200, 12, 12, 12);
  static const Color card = Color.fromARGB(150, 22, 22, 22);
  static const Color divider = Color.fromARGB(90, 255, 255, 255);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color.fromARGB(220, 255, 255, 255);
  static const Color textHint = Color.fromARGB(160, 255, 255, 255);
  static const Color textIcon = Color.fromARGB(180, 255, 255, 255);

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: scaffoldBackground,
        cardColor: card,
        dividerColor: divider,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: textSecondary),
          bodyMedium: TextStyle(color: textSecondary),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: textHint),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: surface,
            foregroundColor: textPrimary,
            elevation: 0,
          ),
        ),
      );
}
