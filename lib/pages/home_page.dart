import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/theme_dropdown_selector.dart';
import '../providers/theme_manager.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 背景图（加透明度，让图淡化）
        Opacity(
          opacity: 0.2, // 控制原图透明度
          child: Image.asset(
            'assets/images/home-bg-1.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // 叠加主题色（半透明遮罩）
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context)
              .colorScheme
              .primary
              .withAlpha((0.15 * 255).toInt()), // 可调
        ),

        // 其他内容放这里（比如页面主内容）
      ],
    ));
  }
}
