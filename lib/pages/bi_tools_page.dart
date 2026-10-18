import 'package:flutter/material.dart';
import 'package:pr2/theme/app_theme.dart';

class BiToolsApp extends StatelessWidget {
  const BiToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BI-инструменты',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const BiToolPage(),
    );
  }
}

class BiToolPage extends StatelessWidget {
  const BiToolPage({super.key});

  static const String title = 'НАЗВАНИЕ ПРИЛОЖЕНИЯ';
  static const String softwareName = 'Microsoft Power BI';
  static const String softwareDescription =
      'Power BI — платформа бизнес-аналитики от Microsoft для визуализации '
      'данных и создания интерактивных отчётов и дашбордов.';
  static const String fullName = 'Ковалев А.Э.';
  static const String groupNumber = 'ИКБО-66-23';

  static const List<String> imageAssets = [
    'assets/images/bi_1.png',
    'assets/images/bi_2.jpg',
    'assets/images/bi_3.png',
    'assets/images/bi_4.jpg',
    'assets/images/bi_5.png',
  ];

  static const List<_MenuItem> menuItems = [
    _MenuItem(
      title: 'Дашборды',
      subtitle: 'Интерактивная визуализация данных',
      leadingIcon: Icons.dashboard,
      trailingIcon: Icons.arrow_forward_ios,
    ),
    _MenuItem(
      title: 'Отчёты',
      subtitle: 'Создание и планирование отчётов',
      leadingIcon: Icons.assessment,
      trailingIcon: Icons.arrow_forward_ios,
    ),
    _MenuItem(
      title: 'Источники',
      subtitle: 'Подключение к базам данных',
      leadingIcon: Icons.storage,
      trailingIcon: Icons.arrow_forward_ios,
    ),
    _MenuItem(
      title: 'DAX',
      subtitle: 'Вычисляемые меры и формулы',
      leadingIcon: Icons.functions,
      trailingIcon: Icons.arrow_forward_ios,
    ),
    _MenuItem(
      title: 'Экспорт',
      subtitle: 'Выгрузка в Excel и PDF',
      leadingIcon: Icons.file_download,
      trailingIcon: Icons.arrow_forward_ios,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(text: title),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _OutlinedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          softwareName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _OutlinedBox(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        softwareDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageAssets.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                imageAssets[index],
                                fit: BoxFit.cover,
                                width: 200,
                                height: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return Card(
                            color: AppTheme.card,
                            margin: const EdgeInsets.only(bottom: 10),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: AppTheme.divider,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Icon(
                                item.leadingIcon,
                                color: AppTheme.textIcon,
                                size: 28,
                              ),
                              title: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              subtitle: Text(
                                item.subtitle,
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              trailing: Icon(
                                item.trailingIcon,
                                color: AppTheme.textHint,
                                size: 20,
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: AppTheme.surface,
                                ));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const _OutlinedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.person_outline,
                            size: 32,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/profile');
                            },
                            child: _OutlinedBox(
                              height: 60,
                              child: Center(
                                child: Text(
                                  '$fullName, $groupNumber',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final IconData trailingIcon;
}

class _Header extends StatelessWidget {
  const _Header({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(200, 139, 195, 74),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'OpenSansCustom',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _OutlinedBox extends StatelessWidget {
  const _OutlinedBox({
    this.child,
    this.width,
    this.height,
    this.padding,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.divider, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
