import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pr2/models/menu_item.dart';
import 'package:pr2/routes.dart';
import 'package:pr2/theme/app_theme.dart';
import 'package:pr2/widgets/app_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String title = 'BI';
  static const String softwareName = 'Microsoft Power BI';
  static const String softwareDescription =
      'Power BI — платформа бизнес-аналитики от Microsoft для визуализации '
      'данных и создания интерактивных отчётов и дашбордов.';
  static const String fullName = 'Ковалев А.Э.';
  static const String groupNumber = 'ИКБО-66-23';
  static const double wideLayoutWidth = 600;

  static const List<String> imageAssets = [
    'assets/images/bi_1.png',
    'assets/images/bi_2.jpg',
  ];

  static const List<MenuItem> menuItems = [
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

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > wideLayoutWidth;
    final gap = _isDesktopOrWeb() ? 24.0 : 16.0;
    final itemGap = gap / 2;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(text: title),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      softwareName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: itemGap),
                    const Text(
                      softwareDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: gap),
                    Row(
                      children: [
                        for (final asset in imageAssets) ...[
                          Expanded(child: _ImageBox(asset: asset)),
                          if (asset != imageAssets.last) SizedBox(width: itemGap),
                        ],
                      ],
                    ),
                    SizedBox(height: gap),
                    isWide ? _buildGrid(itemGap) : _buildList(itemGap),
                    SizedBox(height: gap),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.profile);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 32,
                            color: AppTheme.textPrimary,
                          ),
                          SizedBox(width: 16),
                          Text(
                            '$fullName, $groupNumber',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentRoute: AppRoutes.home),
    );
  }

  Widget _buildList(double itemGap) {
    return Column(
      children: [
        for (final item in menuItems)
          Padding(
            padding: EdgeInsets.only(bottom: itemGap),
            child: _MenuCard(item: item),
          ),
      ],
    );
  }

  Widget _buildGrid(double itemGap) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: itemGap,
        mainAxisSpacing: itemGap,
        mainAxisExtent: 56,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _MenuCard(item: menuItems[index]);
      },
    );
  }
}

bool _isDesktopOrWeb() {
  return kIsWeb ||
      {
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      }.contains(defaultTargetPlatform);
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.divider, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.card,
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: AppTheme.divider,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        trailing: Icon(
          item.trailingIcon,
          color: AppTheme.textHint,
          size: 16,
        ),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.detail, arguments: item);
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.header,
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
