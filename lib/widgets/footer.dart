import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webpig/const/consts.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:webpig/widgets/language_switcher.dart';
import 'package:webpig/widgets/handleinter_action.dart';
import 'package:webpig/providers/theme_manager.dart';
import 'package:webpig/models/theme_model.dart';
import 'package:webpig/widgets/theme_dropdown_selector.dart';
import 'package:provider/provider.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(0),
      color: const Color(0xFF0E1823), // 深色背景

      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogoAndDescription(context, screenwidth),
                _buildLinkColumn(context, screenwidth),
              ],
            ),
          if (isMobile)
            Column(
              children: [
                _buildLogoAndDescription(context, screenwidth),
                const SizedBox(height: 20),
                if ((screenwidth < 700))
                  Container(
                      height: 1.3, width: screenwidth, color: Colors.white24),
                _buildLinkColumn(context, screenwidth),
                const SizedBox(height: 20),
              ],
            ),
          Text(
            context.tr('footer.footest'),
            style:
                TextStyle(color: Colors.white.withAlpha((0.7 * 255).toInt())),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildLogoAndDescription(BuildContext context, double screenwidth) {
    // 固定列宽，这里我们设置每列为屏幕宽度的四分之一
    double columnWidth = screenwidth / ((screenwidth < 700) ? 1 : 5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: columnWidth,
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: FlutterLogo(),
                  ),
                  Text(
                    context.tr('general.title'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        if ((screenwidth >= 700))
          Container(height: 1.3, width: columnWidth, color: Colors.white24),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: (screenwidth < 700) ? 28 : 35,
          child: Text(
            context.tr('footer.welcome1'),
            style: TextStyle(
              letterSpacing: (screenwidth < 700) ? 2 : 0,
              color: (screenwidth < 700)
                  ? Colors.white.withAlpha((0.7 * 255).toInt())
                  : Colors.white,
              fontSize: (screenwidth < 700) ? 13 : 16,
            ),
          ),
        ),
        SizedBox(
          height: (screenwidth < 700) ? 28 : 35,
          child: Text(
            context.tr('footer.welcome2'),
            style: TextStyle(
              letterSpacing: (screenwidth < 700) ? 2 : 0,
              color: (screenwidth < 700)
                  ? Colors.white.withAlpha((0.7 * 255).toInt())
                  : Colors.white,
              fontSize: (screenwidth < 700) ? 13 : 16,
            ),
          ),
        ),
        SizedBox(
          height: (screenwidth < 700) ? 28 : 35,
          child: Text(
            context.tr('footer.welcome3'),
            style: TextStyle(
              letterSpacing: (screenwidth < 700) ? 2 : 0,
              color: (screenwidth < 700)
                  ? Colors.white.withAlpha((0.7 * 255).toInt())
                  : Colors.white,
              fontSize: (screenwidth < 700) ? 13 : 16,
            ),
          ),
        ),
        SizedBox(
          height: (screenwidth < 700) ? 28 : 35,
          child: Text(
            context.tr('footer.welcome4'),
            style: TextStyle(
              letterSpacing: (screenwidth < 700) ? 2 : 0,
              color: (screenwidth < 700)
                  ? Colors.white.withAlpha((0.7 * 255).toInt())
                  : Colors.white,
              fontSize: (screenwidth < 700) ? 13 : 16,
            ),
          ),
        ),
        if (telegramlink != '') SizedBox(height: 10),
        if (telegramlink != '')
          SizedBox(
            height: 35,
            child: InkWell(
              onTap: () async {
                final link = telegramlink;
                if (link == '') {
                } else {
                  if (link.trim().startsWith('jump_')) {
                    // 处理 Flutter 内部跳转
                    handleInternalAction(link, context);
                  } else {
                    launcher.launchUrl(Uri.parse(link));
                  }
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/icon/telegram.svg',
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 244, 246, 247),
                      BlendMode.srcIn,
                    ),
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLinkColumn(BuildContext context, double screenwidth) {
    // 固定列宽，这里我们设置每列为屏幕宽度的四分之一
    double columnWidth = screenwidth / 5;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: (screenwidth < 700) ? 55 : 70,
          child: // 渲染表头
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var header in footerheaderTitles)
                Container(
                  width: columnWidth,
                  alignment: Alignment.center,
                  child: Text(
                    context.tr('footer.$header'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 分隔线
        if ((screenwidth >= 700))
          Container(
              height: 1.3,
              width: columnWidth * ((screenwidth < 700) ? 5 : 4),
              color: Colors.white24),
        if ((screenwidth >= 700)) SizedBox(height: 10),
        // 渲染每一行的数据
        for (int i = 0; i < footerlist.length; i++)
          SizedBox(
              height: (screenwidth < 700) ? 28 : 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int j = 0; j < footerlist[i].length; j++)
                    Container(
                      width: columnWidth,
                      alignment: Alignment.center,
                      child: (footerlist[i][j]['text']!.isNotEmpty &&
                              (!['ios', 'android', 'windows', 'macos', 'linux']
                                      .contains(footerlist[i][j]['text']!) ||
                                  supportplatform.any((p) =>
                                      p.platform == footerlist[i][j]['text']!)))
                          ? GestureDetector(
                              onTap: () async {
                                if (footerlist[i][j]['link']!.isNotEmpty) {
                                  final link = footerlist[i][j]['link']!;
                                  if (link.trim().startsWith('jump_')) {
                                    // 处理 Flutter 内部跳转
                                    handleInternalAction(link, context);
                                  } else {
                                    launcher.launchUrl(Uri.parse(link));
                                  }
                                }
                              },
                              child: Text(
                                context
                                    .tr('footer.${footerlist[i][j]['text']!}'),
                                style: TextStyle(
                                  color: (screenwidth < 700)
                                      ? Colors.white
                                          .withAlpha((0.7 * 255).toInt())
                                      : Colors.white,
                                  fontSize: (screenwidth < 700) ? 13 : 16,
                                ),
                              ),
                            )
                          : SizedBox.shrink(), // 如果没有文本，显示为空
                    ),
                ],
              )),

        // 语言切换器和其它内容
        const SizedBox(height: 20),
        Container(
            width: columnWidth * 3.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSwitcher(
                  isblack: true,
                  isup: false,
                  currentAppTheme: AppTheme(
                    themeName: "custom",
                    colorTheme: themeProvider.currentColorTheme,
                  ),
                  onThemeChanged: (newTheme) {
                    themeProvider.changeTheme(newTheme);
                  },
                ),
                const SizedBox(width: 60),
                LanguageSwitcher(
                  isup: false,
                  isblack: true,
                ),
              ],
            )),
      ],
    );
  }
}
