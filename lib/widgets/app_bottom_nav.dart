import 'package:flutter/material.dart';
import 'package:pr2/routes.dart';
import 'package:pr2/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentRoute});

  final String currentRoute;

  void _navigate(BuildContext context, String route) {
    if (currentRoute == route) return;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.navBar,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 32,
                color: Colors.black,
                icon: Icon(
                  currentRoute == AppRoutes.home
                      ? Icons.home
                      : Icons.home_outlined,
                ),
                onPressed: () => _navigate(context, AppRoutes.home),
              ),
              IconButton(
                iconSize: 32,
                color: Colors.black,
                icon: Icon(
                  currentRoute == AppRoutes.profile
                      ? Icons.person
                      : Icons.person_outline,
                ),
                onPressed: () => _navigate(context, AppRoutes.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
