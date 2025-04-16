import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../const/consts.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class DownButtons extends StatelessWidget {
  final String svgPath;
  final String label;
  final bool isFilled;
  final VoidCallback onPressed;
  final bool alignCenter; // 👈 新增参数，控制内容是否居中

  const DownButtons({
    super.key,
    required this.svgPath,
    required this.label,
    required this.isFilled,
    required this.onPressed,
    this.alignCenter = true, // 默认居中
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            gradient: isFilled
                ? LinearGradient(
                    colors: [
                      ThemeProvider.instance.primaryColor!,
                      ThemeProvider.instance.surfaceTintColor!,
                      ThemeProvider.instance.primaryColor!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isFilled ? null : Colors.transparent,
            border: isFilled
                ? null
                : Border.all(
                    color: const Color(0xFF0E1823),
                    width: 1,
                  ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize:
                alignCenter ? MainAxisSize.min : MainAxisSize.max, // 👈 关键
            mainAxisAlignment: alignCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.start, // 👈 关键
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(
                  isFilled ? Colors.white : const Color(0xFF0E1823),
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                overflow: TextOverflow.clip,
                softWrap: false,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  color: isFilled ? Colors.white : const Color(0xFF0E1823),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlatformGridView extends StatelessWidget {
  const PlatformGridView({super.key});

  // 根据平台返回对应的SVG路径
  String getSvgPath(String platform) {
    switch (platform) {
      case 'macos':
        return 'assets/images/icon/macos.svg';
      case 'windows':
        return 'assets/images/icon/windows.svg';
      case 'linux':
        return 'assets/images/icon/linuxkong.svg';
      case 'android':
        return 'assets/images/icon/android.svg';
      case 'ios':
        return 'assets/images/icon/ios.svg';
      default:
        return 'assets/images/icon/ios.svg'; // 默认路径
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 每行显示2个元素
        crossAxisSpacing: 3, // 列间距
        mainAxisSpacing: 3, // 行间距
        childAspectRatio: 3, // 控制每个项目的宽高比例
      ),
      itemCount: supportplatform.length,
      itemBuilder: (context, index) {
        final platform = supportplatform[index];

        return DownButtons(
          svgPath: getSvgPath(platform.platform!), // 使用getSvgPath方法
          label: context.tr('home.down${platform.platform!}'),
          isFilled: true, // 可根据条件设置
          alignCenter: false,
          onPressed: () async {
            final url = Uri.parse(platform.downloadUrl!);
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
        );
      },
    );
  }
}
