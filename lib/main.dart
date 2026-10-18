import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BiToolsApp());
}

class BiToolsApp extends StatelessWidget {
  const BiToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BI-инструменты',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8BC34A)),
        scaffoldBackgroundColor: Colors.white,
      ),
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
                        style: TextStyle(fontSize: 14, height: 1.4),
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
                            margin: const EdgeInsets.only(bottom: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Icon(
                                item.leadingIcon,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                              title: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(item.subtitle),
                              trailing: Icon(
                                item.trailingIcon,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(item.title),
                                  duration: const Duration(seconds: 2),
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
                          child: Icon(Icons.person_outline, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _OutlinedBox(
                            height: 60,
                            child: Center(
                              child: Text(
                                '$fullName, $groupNumber',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
      color: const Color(0xFF8BC34A),
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
        border: Border.all(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
