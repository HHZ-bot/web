import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/theme_manager.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import '../widgets/theme_dropdown_selector.dart';
import '../widgets/language_switcher.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight; // 新增一个参数来传递高度

  const AppNavbar({super.key, this.appBarHeight = 80.0}); // 默认高度为 80

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight); // 使用传入的高度

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      backgroundColor: isMobile
          ? Colors.white
          : Theme.of(context)
              .colorScheme
              .primary
              .withAlpha((0.06 * 255).toInt()),
      toolbarHeight: appBarHeight, // 使用传入的高度
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: appBarHeight, // 使用传入的高度
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FlutterLogo(),
            const SizedBox(width: 8),
            Text(
              context.tr("general.title"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E1823),
              ),
            ),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  _NavButton(label: context.tr("home.title"), route: '/'),
                  _NavButton(
                      label: context.tr("payment.title"), route: '/payments'),
                  _NavButton(
                      label: context.tr("download.title"), route: '/download'),
                  const LanguageSwitcher(),
                  ThemeSwitcher(
                    currentAppTheme: AppTheme(
                      themeName: "custom",
                      colorTheme: themeProvider.currentColorTheme,
                    ),
                    onThemeChanged: (newTheme) {
                      themeProvider.changeTheme(newTheme);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final String route;

  const _NavButton({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(route),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0E1823),
        ),
      ),
    );
  }
}
