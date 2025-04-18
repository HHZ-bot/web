import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webpig/widgets/app_navbar.dart'; // 确保你已经引入了 AppNavbar 组件
import 'package:webpig/models/theme_model.dart';
import 'package:webpig/widgets/theme_dropdown_selector.dart';
import 'package:webpig/widgets/language_switcher.dart';
import 'package:provider/provider.dart';
import 'package:webpig/providers/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppNavbar(appBarHeight: isMobile ? 55 : 80), // 你的导航栏组件

      endDrawerEnableOpenDragGesture: false, // 禁用默认的左侧拖拽手势
      endDrawer: isMobile ? const AppDrawer() : null, // 仅在移动端显示右侧抽屉
      body: child,
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      width: double.infinity,
      backgroundColor: Color(0xFF0E1823), // 设置整个抽屉背景为黑色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 移除圆角
      ),
      child: Column(
        children: [
          // 自定义的顶部内容，包含 logo 和关闭按钮
          Container(
            color: Color(0xFF0E1823), // 确保顶部背景是黑色
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 让 logo 和关闭按钮分布两边
              children: [
                Row(
                  children: [
                    FlutterLogo(size: 20), // 你可以替换为你自己的 logo
                    SizedBox(width: 8),
                    Text(
                      context.tr("general.title"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // 关闭抽屉
                  },
                ),
              ],
            ),
          ),
          // 底下的菜单项
          _DrawerItem(label: context.tr("home.title"), route: '/'),
          Divider(
            color: Color.fromARGB(255, 47, 48, 49), // 设置线条颜色为黑色
            thickness: 1, // 设置线条厚度
            indent: 0, // 设置起始边距
            endIndent: 0, // 设置结束边距
          ),
          _DrawerItem(label: context.tr("payment.title"), route: '/payments'),
          Divider(
            color: Color.fromARGB(255, 47, 48, 49), // 设置线条颜色为黑色
            thickness: 1, // 设置线条厚度
            indent: 0, // 设置起始边距
            endIndent: 0, // 设置结束边距
          ),
          _DrawerItem(label: context.tr("download.title"), route: '/download'),
          Divider(
            color: Color.fromARGB(255, 47, 48, 49), // 设置线条颜色为黑色
            thickness: 1, // 设置线条厚度
            indent: 0, // 设置起始边距
            endIndent: 0, // 设置结束边距
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const LanguageSwitcher(isblack: true),
              ThemeSwitcher(
                isblack: true,
                currentAppTheme: AppTheme(
                  themeName: "custom",
                  colorTheme: themeProvider.currentColorTheme,
                ),
                onThemeChanged: (newTheme) {
                  themeProvider.changeTheme(newTheme);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final String route;

  const _DrawerItem({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: TextStyle(color: Colors.white)), // 文字颜色设置为白色
      onTap: () {
        Navigator.pop(context); // 关闭抽屉
        context.go(route); // 使用 go_router 导航到相应页面
      },
    );
  }
}
