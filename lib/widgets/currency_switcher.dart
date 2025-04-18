import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webpig/providers/currency_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class CurrencySwitcher extends StatefulWidget {
  final bool isblack;
  const CurrencySwitcher({super.key, this.isblack = false});

  @override
  State<CurrencySwitcher> createState() => _CurrencySwitcherState();
}

class _CurrencySwitcherState extends State<CurrencySwitcher> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  final List<Map<String, String>> _currencies = [
    {'icon': '\$', 'code': 'USD'},
    {'icon': '¥', 'code': 'CNY'},
    {'icon': '₽', 'code': 'RUB'},
    {'icon': '﷼', 'code': 'IRR'},
    {'icon': '؋', 'code': 'AFN'},
  ];

  void _toggleOverlay() {
    _isOpen ? _removeOverlay() : _showOverlay();
  }

  void _showOverlay() {
    if (!mounted) return;
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) setState(() => _isOpen = true);
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;

    if (_overlayEntry != null) {
      try {
        _overlayEntry!.remove();
      } catch (_) {
        // 安全忽略可能的异常
      }
      _overlayEntry = null;
    }

    super.dispose();
  }

  void _removeOverlay() {
    if (_isDisposed) return;

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  OverlayEntry _buildOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final current = context.read<CurrencyManager>().currentCurrency;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + renderBox.size.height + 4,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, renderBox.size.height + 4),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _currencies.map((currency) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<CurrencyManager>()
                              .updateCurrency(currency['code']!);
                          _removeOverlay();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Text(currency['code']!,
                                  style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Text(currency['icon']!,
                                  style: TextStyle(fontSize: 18)),
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
    final currentCurrency = context.watch<CurrencyManager>().currentCurrency;
    final current = _currencies.firstWhere(
      (e) => e['code'] == currentCurrency,
      orElse: () => _currencies.first,
    );

    return GestureDetector(
      onTap: _toggleOverlay,
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
              const SizedBox(width: 6),
              Text(
                  context.tr('payment.currency') +
                      ' ' +
                      current['icon']! +
                      ' ' +
                      current['code']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isblack ? Colors.white : Color(0xFF0E1823),
                  )),
              Icon(Icons.arrow_drop_down,
                  color: widget.isblack ? Colors.white : Color(0xFF0E1823)),
            ],
          ),
        ),
      ),
    );
  }
}
