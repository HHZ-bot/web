import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CurrencyManager with ChangeNotifier {
  String currentCurrency = 'USD';
  Map<String, double> exchangeRates = {
    'CNY': 7.2,
    'RUB': 98.5,
    'IRR': 42350,
    'AFN': 42350,
    'USD': 1.0,
  };

  void updateCurrency(String currency) {
    currentCurrency = currency;
    notifyListeners();
  }

  CurrencyManager() {
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    const apiUrl = 'https://api.exchangerate-api.com/v4/latest/USD';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // 打印出从API获取的原始数据

        exchangeRates = {
          'CNY': (data['rates']['CNY'] ?? 7.2).toDouble(),
          'RUB': (data['rates']['RUB'] ?? 98.5).toDouble(),
          'IRR': (data['rates']['IRR'] ?? 42350).toDouble(),
          'AFN': (data['rates']['AFN'] ?? 42350).toDouble(),
          'USD': 1.0,
        };
        print('存储的汇率数据: $exchangeRates');
        notifyListeners();
      }
    } catch (e) {
      print('请求汇率失败: $e');
    }
  }

  double calculatePrice(double amountInUSD) {
    return amountInUSD * (exchangeRates[currentCurrency] ?? 1.0);
  }

  String getCurrencySymbol() {
    switch (currentCurrency) {
      case 'CNY':
        return '￥';
      case 'RUB':
        return '₽';
      case 'IRR':
        return '﷼';
      case 'AFN':
        return '؋';
      default:
        return '\$';
    }
  }

// 根据当前语言设置默认币种
  void setCurrencyBasedOnLocale(Locale locale) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 在小部件树构建完成后更新币种
      switch (locale.languageCode) {
        case 'zh':
          currentCurrency = 'CNY'; // 中文显示人民币
          break;
        case 'ru':
          currentCurrency = 'RUB'; // 俄文显示卢布
          break;
        case 'fa':
          currentCurrency = 'IRR'; // 波斯文显示伊朗里亚尔
          break;
        case 'ps':
          currentCurrency = 'AFN'; // 阿富汗货币（阿富汗语）
          break;
        case 'en':
        default:
          currentCurrency = 'USD'; // 英文默认美元
          break;
      }
      notifyListeners(); // 更新状态
    });
  }
}
