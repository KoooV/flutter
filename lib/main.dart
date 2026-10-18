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

  static const String title = 'BI-ИНСТРУМЕНТЫ';
  static const String softwareName = 'Microsoft Power BI';
  static const String softwareDescription =
      'Power BI — платформа бизнес-аналитики от Microsoft для визуализации '
      'данных и создания интерактивных отчётов и дашбордов.';
  static const List<String> features = [
    'Интерактивные дашборды и отчёты',
    'Подключение к 100+ источникам данных',
    'Язык вычисляемых мер DAX',
    'Обновление данных в реальном времени',
  ];
  static const String fullName = 'Ковалев А.Э.';
  static const String groupNumber = 'ИКБО-66-23';

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
                  children: [
                    const _OutlinedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mouse, size: 20),
                          SizedBox(width: 8),
                          Text(
                            softwareName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Expanded(
                            flex: 5,
                            child: _OutlinedBox(child: _ImagePlaceholder()),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 4,
                            child: _OutlinedBox(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < features.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        '${i + 1}. ${features[i]}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.asset(
        'assets/images/power_bi.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_chart_outlined,
              size: 64,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              'Картинка',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ],
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
