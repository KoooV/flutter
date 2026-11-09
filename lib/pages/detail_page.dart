import 'package:flutter/material.dart';
import 'package:pr2/models/menu_item.dart';
import 'package:pr2/routes.dart';
import 'package:pr2/theme/app_theme.dart';
import 'package:pr2/widgets/app_bottom_nav.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.header,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          item.title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'OpenSansCustom',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.divider, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(item.imageAsset, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              item.description,
              style: const TextStyle(
                fontSize: 18,
                height: 1.4,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentRoute: AppRoutes.detail),
    );
  }
}
