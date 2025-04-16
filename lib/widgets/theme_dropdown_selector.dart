import 'package:flutter/material.dart';
import '/models/theme_model.dart';
import 'package:easy_localization/easy_localization.dart';

const Color goldColor = Color(0xFF8F4E00);
const Color greylawcolor = Color(0xFF006684);
const Color greybluecolor = Color(0xFF0B61A4);
const Color pinkcolor = Color(0xFFCE5B78);
const Color redwinecolor = Color(0xFFAF2B3D);
const Color purplecolor = Color(0xFF6750A4);
const Color greenmoneycolor = Color(0xFF006D40);

class ThemeSwitcher extends StatefulWidget {
  final bool isblack;
  final AppTheme currentAppTheme;
  final ValueChanged<AppTheme> onThemeChanged;

  const ThemeSwitcher({
    super.key,
    this.isblack = false,
    required this.currentAppTheme,
    required this.onThemeChanged,
  });

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  List<ColorTheme> get _colorThemes => ColorTheme.values;

  Color _getColor(ColorTheme colorTheme) {
    switch (colorTheme) {
      case ColorTheme.greylaw:
        return greylawcolor;
      case ColorTheme.greyblue:
        return greybluecolor;
      case ColorTheme.blue:
        return Colors.blue;
      case ColorTheme.green:
        return Colors.green;
      case ColorTheme.greenmoney:
        return greenmoneycolor;
      case ColorTheme.redwine:
        return redwinecolor;
      case ColorTheme.purple:
        return purplecolor;
      case ColorTheme.gold:
        return goldColor;
      case ColorTheme.pink:
        return pinkcolor;
      case ColorTheme.lime:
        return Colors.lime;
      default:
        return Colors.black;
    }
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
    Overlay.of(context)?.insert(_overlayEntry!);
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

  OverlayEntry _buildOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height + 4, // 下拉框位置
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, renderBox.size.height + 4), // 向下偏移一些
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _colorThemes.map((color) {
                  return InkWell(
                    onTap: () {
                      widget.onThemeChanged(AppTheme(
                        themeName: widget.currentAppTheme.themeName,
                        colorTheme: color,
                      ));
                      _removeOverlay();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _getColor(color), // 颜色
                              shape: BoxShape.circle, // 设置为圆形
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.tr(
                                'general.${color.toString().split('.').last.toLowerCase()}'),
                            style: const TextStyle(fontSize: 14),
                          ),
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
    );
  }

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOverlay, // 点击时打开或关闭弹窗
      child: MouseRegion(
        onExit: (_) {
          // 这里不再关闭弹窗，只有点击时才会关闭
        },
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // 增大点击区域
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: _getColor(widget.currentAppTheme.colorTheme),
                      shape: BoxShape.circle, // 设置为圆形
                    )),
                const SizedBox(width: 6),
                Text(
                  context.tr(
                      'general.${widget.currentAppTheme.colorTheme.toString().split('.').last.toLowerCase()}'),
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.isblack ? Colors.white : Color(0xFF0E1823)),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: widget.isblack ? Colors.white : Color(0xFF0E1823),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
