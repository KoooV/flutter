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

class BiToolPage extends StatefulWidget {
  const BiToolPage({super.key});

  @override
  State<BiToolPage> createState() => _BiToolPageState();
}

class _BiToolPageState extends State<BiToolPage> {
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

  static const List<String> imageAssets = [
    'assets/images/bi_1.png',
    'assets/images/bi_2.jpg',
    'assets/images/bi_3.png',
    'assets/images/bi_4.jpg',
    'assets/images/bi_5.png',
  ];

  int _imageIndex = 0;

  void _nextImage() {
    setState(() {
      _imageIndex = (_imageIndex + 1) % imageAssets.length;
    });
  }

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
                          Expanded(
                            flex: 5,
                            child: _OutlinedBox(
                              child: GestureDetector(
                                onTap: _nextImage,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.asset(
                                    imageAssets[_imageIndex],
                                    key: ValueKey('bi_image_$_imageIndex'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            ),
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
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: _nextImage,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Следующая картинка'),
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
