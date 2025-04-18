import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui; // 添加 `as ui` 别名
import 'providers/theme_manager.dart';
import 'providers/main_layout.dart';
import 'pages/home_page.dart';
import 'pages/payments_page.dart';
import 'pages/download_page.dart';
import 'pages/ios_help.dart';
import 'generated/codegen_loader.g.dart';
import 'package:webpig/providers/currency_manager.dart';
import 'package:webpig/providers/log.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final themeProvider = ThemeProvider.instance;
  await themeProvider.initializeTheme();
  Log.init(level: Level.ALL);

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'), // 英语
      Locale('zh', 'CN'), // 中文
      Locale('ru', 'RU'), // 俄语
      Locale('ps', 'AF'), // 普什图语
      Locale('fa', 'IR'), // 波斯语
    ],
    path: 'assets/translations',
    assetLoader: CodegenLoader(),
    fallbackLocale: const Locale('en', 'US'),
    saveLocale: true,
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<CurrencyManager>(
          create: (_) => CurrencyManager(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => MainLayout(child: child),
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomePage()),
            GoRoute(
                path: '/payments',
                builder: (context, state) => const PaymentsPage()),
            GoRoute(
                path: '/download',
                builder: (context, state) => const DownloadPage()),
            GoRoute(
                path: '/ioshelp',
                builder: (context, state) => const HelpPageApp()),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Flutter WebApp',
      theme: themeProvider.currentThemeData, // 绑定当前的主题
      themeMode: themeProvider.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      builder: (context, child) {
        // 包裹 Directionality 来强制设置文本方向
        return Directionality(
          textDirection: ui.TextDirection.ltr, // 强制从左到右
          child: child!,
        );
      },
    );
  }
}
