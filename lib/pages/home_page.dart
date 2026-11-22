import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr2/bloc/home/home_bloc.dart';
import 'package:pr2/bloc/home/home_event.dart';
import 'package:pr2/bloc/home/home_state.dart';
import 'package:pr2/di/injection_container.dart';
import 'package:pr2/models/menu_item.dart';
import 'package:pr2/routes.dart';
import 'package:pr2/theme/app_theme.dart';
import 'package:pr2/widgets/app_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.bloc});

  /// BLoC домашней страницы. Если не передан явно, берётся из DI-контейнера.
  final HomeBloc? bloc;

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

  @override
  Widget build(BuildContext context) {
    final homeBloc = bloc ?? getIt<HomeBloc>();
    return BlocProvider(
      create: (_) => homeBloc..add(const LoadMenuItems()),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        Widget body;

        if (state is HomeLoaded) {
          body = _buildContent(context, state.items);
        } else if (state is HomeError) {
          body = _buildError(context, state.message);
        } else {
          // HomeInitial и HomeLoading — отображаем индикатор загрузки.
          body = const _Loading();
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                _Header(text: HomePage.title),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          HomePage.softwareName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        SizedBox(height: _itemGap(context)),
                        Text(
                          HomePage.softwareDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(height: _gap(context)),
                        Row(
                          children: [
                            for (final asset in HomePage.imageAssets) ...[
                              Expanded(child: _ImageBox(asset: asset)),
                              if (asset != HomePage.imageAssets.last)
                                SizedBox(width: _itemGap(context) / 2),
                            ],
                          ],
                        ),
                        SizedBox(height: _gap(context)),
                        body,
                        SizedBox(height: _gap(context)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.profile);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 32,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                              SizedBox(width: 16),
                              Text(
                                '${HomePage.fullName}, ${HomePage.groupNumber}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
      },
    );
  }

  Widget _buildContent(BuildContext context, List<MenuItem> items) {
    final isWide =
        MediaQuery.sizeOf(context).width > HomePage.wideLayoutWidth;
    final itemGap = _itemGap(context);

    if (isWide) {
      return _buildGrid(items, itemGap);
    }
    return _buildList(items, itemGap);
  }

  Widget _buildList(List<MenuItem> items, double itemGap) {
    return Column(
      children: [
        for (final item in items)
          Padding(
            padding: EdgeInsets.only(bottom: itemGap),
            child: _MenuCard(item: item),
          ),
      ],
    );
  }

  Widget _buildGrid(List<MenuItem> items, double itemGap) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: itemGap,
        mainAxisSpacing: itemGap,
        mainAxisExtent: 56,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _MenuCard(item: items[index]);
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(const LoadMenuItems());
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }

  double _gap(BuildContext context) {
    return _isDesktopOrWeb() ? 24.0 : 16.0;
  }

  double _itemGap(BuildContext context) {
    return _gap(context) / 2;
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
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
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.5),
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
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        trailing: Icon(
          item.trailingIcon,
          color: Theme.of(context).textTheme.bodyMedium?.color,
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
    final appBarTheme = Theme.of(context).appBarTheme;
    return Container(
      width: double.infinity,
      color: appBarTheme.backgroundColor ?? AppTheme.header,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'OpenSansCustom',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: appBarTheme.foregroundColor ?? Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
