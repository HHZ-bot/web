import 'dart:math';

import 'package:flutter/widgets.dart';

class ScreenUtil {
  static double _pixelRatio = 1.0;
  static double _pixelPP = 1.0;
  static double _screenwidth = 360;
  static double _screenheight = 640;
  static double designwidth = 360;
  static double designhight = 640;

  // 初始化方法
  static void init() {
    // 使用 PlatformDispatcher 获取设备的 devicePixelRatio
    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;

    // 获取设备的 pixel ratio
    _pixelRatio = platformDispatcher.views.first.devicePixelRatio;
    _screenwidth = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;
    _screenheight = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.height;
    _pixelPP = min(
      _screenwidth / (_pixelRatio * designwidth),
      _screenheight / (_pixelRatio * designhight),
    );
  }

  // 获取屏幕适配的字体大小（基于分辨率）
  static double sp(double size) {
    return (_pixelRatio * _pixelPP <= 2.4)
        ? size * 2.4
        : (_pixelRatio * _pixelPP <= 3.6)
            ? size * _pixelRatio * _pixelPP
            : (_pixelRatio * _pixelPP <= 4)
                ? size * _pixelRatio * _pixelPP
                : size * _pixelRatio * _pixelPP * 1.2;
  }

  static double containsp(double size) {
    return (_pixelRatio * _pixelPP <= 2.4)
        ? size * 2.4 * 1.3
        : (_pixelRatio * _pixelPP <= 3.2)
            ? size * _pixelRatio * _pixelPP * 1.1
            : size * _pixelRatio * _pixelPP;
  }

  static double offsetsp(double size) {
    return (_pixelRatio * _pixelPP <= 2)
        ? size * 5
        : (_pixelRatio * _pixelPP <= 2.4)
            ? size * 6.7
            : (_pixelRatio * _pixelPP <= 3.2)
                ? size * 5.7
                : (_pixelRatio * _pixelPP <= 3.6)
                    ? size * 4
                    : (_pixelRatio * _pixelPP <= 4)
                        ? size * 4
                        : size * 1;
  }
  // 获取屏幕的分辨率

  static double getPixelRatio() {
    return _pixelRatio;
  }

  static double getPixelPP() {
    return _pixelPP;
  }

  static double getscreenwidth() {
    return _screenwidth;
  }

  static double getscreenheight() {
    return _screenheight;
  }

  static double getPR() {
    return _pixelPP * _pixelRatio;
  }
}
