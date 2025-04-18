import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webpig/models/theme_model.dart';
import 'package:json_theme/json_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ColorTheme currentColorTheme = ColorTheme.blue;
  ThemeData? currentThemeData;

  static ThemeProvider? _instance;
  static ThemeProvider get instance {
    _instance ??= ThemeProvider._init();
    return _instance!;
  }

  ThemeProvider._init();
  Brightness? brightness;
  Color? primaryColor;
  Color? onPrimaryColor;
  Color? primaryContainerColor;
  Color? onPrimaryContainerColor;
  Color? onSecondaryColor;
  Color? secondaryContainerColor;
  Color? onSecondaryContainerColor;
  Color? tertiaryColor;
  Color? tertiaryContainerColor;
  Color? onTertiaryContainerColor;
  Color? errorColor;
  Color? surfaceColor;
  Color? onSurfaceColor;
  Color? outlineColor;
  Color? outlineVariantColor;
  Color? shadowColor;
  Color? surfaceTintColor;
  Color? dividerColor;
  Color? sprimaryColor;
  Color? disabledColor;
  Color? hintColor;
  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // 获取保存的主题设置
    String? savedColorTheme = prefs.getString('colorTheme');
    String? savedThemeMode = prefs.getString('themeMode');

    // 如果保存了主题设置，就使用保存的设置
    if (savedColorTheme != null && savedThemeMode != null) {
      currentColorTheme =
          ColorTheme.values.firstWhere((e) => e.toString() == savedColorTheme);
      brightness =
          savedThemeMode == 'dark' ? Brightness.dark : Brightness.light;
    }

    await _generateThemeData(); // 生成主题数据
  }

  // 更改颜色和主题模式
  Future<void> changeTheme(AppTheme appTheme) async {
    currentColorTheme = appTheme.colorTheme;

    // 将新的主题设置保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('colorTheme', currentColorTheme.toString());
    prefs.setString(
        'themeMode', brightness == Brightness.dark ? 'dark' : 'light');

    await _generateThemeData(); // 生成新的主题数据
    notifyListeners(); // 通知 UI 更新
  }

  // 生成对应的 ThemeData
  Future<void> _generateThemeData() async {
    String themeStr = await rootBundle.loadString(_getThemeJsonPath());
    Map themeJson = jsonDecode(themeStr);
    currentThemeData = ThemeDecoder.decodeThemeData(themeJson);

    // 提取颜色值并将其赋值给颜色变量
    brightness =
        themeJson['brightness'] == 'light' ? Brightness.light : Brightness.dark;
    // 将主题颜色赋值到主题变量
    _applyThemeColors(themeJson);
  }

  // 应用颜色到主题
  void _applyThemeColors(Map themeJson) {
    primaryColor = _hexToColor(themeJson['colorScheme']['primary']);
    onPrimaryColor = _hexToColor(themeJson['colorScheme']['onPrimary']);
    primaryContainerColor =
        _hexToColor(themeJson['colorScheme']['primaryContainer']);
    onPrimaryContainerColor =
        _hexToColor(themeJson['colorScheme']['onPrimaryContainer']);
    onSecondaryColor = _hexToColor(themeJson['colorScheme']['onSecondary']);
    secondaryContainerColor =
        _hexToColor(themeJson['colorScheme']['secondaryContainer']);
    onSecondaryContainerColor =
        _hexToColor(themeJson['colorScheme']['onSecondaryContainer']);
    tertiaryColor = _hexToColor(themeJson['colorScheme']['tertiary']);
    tertiaryContainerColor =
        _hexToColor(themeJson['colorScheme']['tertiaryContainer']);
    onTertiaryContainerColor =
        _hexToColor(themeJson['colorScheme']['onTertiaryContainer']);
    errorColor = _hexToColor(themeJson['colorScheme']['error']);
    surfaceColor = _hexToColor(themeJson['colorScheme']['surface']);
    onSurfaceColor = _hexToColor(themeJson['colorScheme']['onSurface']);
    outlineColor = _hexToColor(themeJson['colorScheme']['outline']);
    outlineVariantColor =
        _hexToColor(themeJson['colorScheme']['outlineVariant']);
    shadowColor = _hexToColor(themeJson['colorScheme']['shadow']);
    surfaceTintColor = _hexToColor(themeJson['colorScheme']['surfaceTint']);
    dividerColor = _hexToColor(themeJson['dividerColor']);
    sprimaryColor = _hexToColor(themeJson['primaryColor']);
    disabledColor = _hexToColor(themeJson['disabledColor']);
    hintColor = _hexToColor(themeJson['hintColor']);
  }

  // 将十六进制颜色字符串转换为 Color 类型
  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0x')));
  }

  String _getThemeJsonPath() {
    // 根据颜色选择不同的 JSON 文件路径
    String colorPath;
    switch (currentColorTheme) {
      case ColorTheme.greylaw:
        colorPath = "greylaw";
        break;
      case ColorTheme.greyblue:
        colorPath = "greyblue";
        break;
      case ColorTheme.blue:
        colorPath = "blue";
        break;
      case ColorTheme.green:
        colorPath = "green";
        break;
      case ColorTheme.greenmoney:
        colorPath = "greenmoney";
        break;
      case ColorTheme.redwine:
        colorPath = "redwine";
        break;
      case ColorTheme.purple:
        colorPath = "purple";
        break;
      case ColorTheme.gold:
        colorPath = "gold";
        break;
      case ColorTheme.pink:
        colorPath = "pink";
        break;
      case ColorTheme.lime:
        colorPath = "lime";
        break;
    }

    return "assets/themes/$colorPath.json";
  }
}
