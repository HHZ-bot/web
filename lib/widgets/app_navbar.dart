import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/theme_manager.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import '../widgets/theme_dropdown_selector.dart';
import '../widgets/language_switcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const/consts.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight; // 新增一个参数来传递高度

  const AppNavbar({super.key, this.appBarHeight = 80.0}); // 默认高度为 80

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight); // 使用传入的高度

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
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
            const SizedBox(
              width: 30,
              height: 30,
              child: FlutterLogo(),
            ),
            const SizedBox(width: 8),
            Text(
              context.tr("general.title"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E1823),
              ),
            ),
            const SizedBox(width: 8),
            ThemeSwitcher(
              currentAppTheme: AppTheme(
                themeName: "custom",
                colorTheme: themeProvider.currentColorTheme,
              ),
              onThemeChanged: (newTheme) {
                themeProvider.changeTheme(newTheme);
              },
            ),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  _NavButton(label: context.tr("home.title"), route: '/'),
                  SizedBox(width: 40),
                  _NavButton(
                      label: context.tr("payment.title"), route: '/payments'),
                  SizedBox(width: 40),
                  _NavButton(
                      label: context.tr("download.title"), route: '/download'),
                  _NavButton(label: ' iOS帮助', route: '/ioshelp'),
                  SizedBox(width: 40),
                  const LanguageSwitcher(),
                  if (telegramlink != '')
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(telegramlink);
                        if (await launcher.canLaunchUrl(url)) {
                          await launcher.launchUrl(
                            url,
                            mode: launcher.LaunchMode
                                .externalApplication, // 或 LaunchMode.platformDefault
                          );
                        } else {
                          print('无法打开链接: $url');
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon/telegram.svg',
                            colorFilter: ColorFilter.mode(
                              const Color(0xFF0E1823),
                              BlendMode.srcIn,
                            ),
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
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
