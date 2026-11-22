import 'package:flutter/material.dart';

/// Кастомные темы приложения (светлая и тёмная).
///
/// Каждая задаёт цвета фона экранов, AppBar, основного текста, карточек,
/// иконок, а также стиль [ElevatedButton] (фон, текст, форма).
class AppTheme {
  // =========================================================================
  // Светлая тема
  // =========================================================================
  static const Color lightScaffoldBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF2F2F2);
  static const Color lightCard = Colors.white;
  static const Color lightDivider = Color(0x99E0E0E0);

  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextHint = Color(0xFFBDBDBD);
  static const Color lightTextIcon = Color(0xFF9E9E9E);

  static const Color lightHeader = Color(0xFF8BC34A);
  static const Color lightNavBar = Color(0xFFF1F8E9);

  static const Color lightButtonBackground = Color(0xFF8BC34A);
  static const Color lightButtonForeground = Colors.white;

  // =========================================================================
  // Тёмная тема
  // =========================================================================
  static const Color _black = Color(0xFF000000);

  static const Color darkScaffoldBackground = _black;
  static const Color darkSurface = Color.fromARGB(200, 12, 12, 12);
  static const Color darkCard = Color.fromARGB(150, 22, 22, 22);
  static const Color darkDivider = Color.fromARGB(90, 255, 255, 255);

  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color.fromARGB(220, 255, 255, 255);
  static const Color darkTextHint = Color.fromARGB(160, 255, 255, 255);
  static const Color darkTextIcon = Color.fromARGB(180, 255, 255, 255);

  static const Color darkHeader = Color.fromARGB(200, 139, 195, 74);
  static const Color darkNavBar = Color(0xFFD9FBB0);

  static const Color darkButtonBackground = Color.fromARGB(200, 12, 12, 12);
  static const Color darkButtonForeground = Colors.white;

  // =========================================================================
  // Общие (временно совпадают с тёмными — для обратной совместимости со
  // старыми страницами, которые ещё ссылаются на AppTheme.*)
  // =========================================================================
  static const Color scaffoldBackground = darkScaffoldBackground;
  static const Color surface = darkSurface;
  static const Color card = darkCard;
  static const Color divider = darkDivider;

  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;
  static const Color textHint = darkTextHint;
  static const Color textIcon = darkTextIcon;

  static const Color header = darkHeader;
  static const Color navBar = darkNavBar;

  // -------------------------------------------------------------------------
  // Светлая ThemeData
  // -------------------------------------------------------------------------
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightScaffoldBackground,
        cardColor: lightCard,
        dividerColor: lightDivider,

        // Основной текст.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: lightTextPrimary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: lightTextPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: lightTextPrimary),
          bodyMedium: TextStyle(color: lightTextSecondary),
        ),

        // Цвета иконок.
        iconTheme: const IconThemeData(color: lightTextIcon),

        // AppBar.
        appBarTheme: AppBarTheme(
          backgroundColor: lightHeader,
          foregroundColor: lightTextPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: lightTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Input.
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: lightTextHint),
        ),

        // ElevatedButton: фон, текст, форма.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightButtonBackground,
            foregroundColor: lightButtonForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        // Навигационная панель (BottomNav) — через собственное свойство.
      );

  // -------------------------------------------------------------------------
  // Тёмная ThemeData
  // -------------------------------------------------------------------------
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkScaffoldBackground,
        cardColor: darkCard,
        dividerColor: darkDivider,

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: darkTextPrimary),
          bodyMedium: TextStyle(color: darkTextSecondary),
        ),

        iconTheme: const IconThemeData(color: darkTextIcon),

        appBarTheme: const AppBarTheme(
          backgroundColor: darkHeader,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: darkTextHint),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkButtonBackground,
            foregroundColor: darkButtonForeground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
}
