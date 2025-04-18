import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/currency_manager.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatefulWidget {
  final bool isup;
  final bool isblack;
  const LanguageSwitcher({super.key, this.isup = true, this.isblack = false});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  final List<Map<String, String>> _languages = [
    {'flag': '🇺🇸', 'label': 'English', 'locale': 'en', 'country': 'US'},
    {'flag': '🇨🇳', 'label': '中文', 'locale': 'zh', 'country': 'CN'},
    {'flag': '🇷🇺', 'label': 'Русский', 'locale': 'ru', 'country': 'RU'},
    {'flag': '🇵🇰', 'label': 'پښتو', 'locale': 'ps', 'country': 'AF'},
    {'flag': '🇮🇷', 'label': 'فارسی', 'locale': 'fa', 'country': 'IR'},
  ];

  Map<String, String> get currentLang {
    final locale = context.locale;
    return _languages.firstWhere(
      (lang) => lang['locale'] == locale.languageCode,
      orElse: () => _languages.first,
    );
  }

  void _toggleOverlay() {
    if (_isOpen) {
      if (mounted) {
        _removeOverlay();
      }
    } else {
      if (mounted) {
        _showOverlay();
      }
    }
  }

  void _showOverlay() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) {
      setState(() => _isOpen = true);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  @override
  void dispose() {
    // 确保仅在需要时清理资源
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  OverlayEntry _buildOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 👇 点击外部关闭
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _removeOverlay(); // 关闭弹窗
              },
              behavior: HitTestBehavior.translucent,
              child: Container(), // 必须有个child才响应点击
            ),
          ),

          // 👇 语言选择弹窗内容
          Positioned(
            left: offset.dx,
            top: widget.isup
                ? offset.dy + renderBox.size.height + 4
                : offset.dy - (_languages.length * 44 + 8), // 👈 向上偏移
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: widget.isup
                  ? Offset(0, renderBox.size.height + 4)
                  : Offset(
                      0, -(_languages.length * 44 + 8).toDouble()), // 👈 向上偏移
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _languages.map((lang) {
                      return InkWell(
                        onTap: () {
                          context.setLocale(
                              Locale(lang['locale']!, lang['country']!));
                          context
                              .read<CurrencyManager>()
                              .setCurrencyBasedOnLocale(
                                  Locale(lang['locale']!, lang['country']!));
                          _removeOverlay();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            children: [
                              Text(lang['flag']!,
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 8),
                              Text(lang['label']!,
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOverlay, // 点击时打开或关闭弹窗
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(currentLang['flag']!, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(currentLang['label']!,
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          widget.isblack ? Colors.white : Color(0xFF0E1823))),
              Icon(Icons.arrow_drop_down,
                  color: widget.isblack ? Colors.white : Color(0xFF0E1823)),
            ],
          ),
        ),
      ),
    );
  }
}
