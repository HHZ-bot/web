import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:webpig/providers/screen_until.dart';
import 'package:webpig/providers/theme_manager.dart';
import 'package:webpig/const/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webpig/widgets/down_buttons.dart';
import 'package:webpig/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: supportplatform.length, vsync: this, initialIndex: 0);
    _tabController.index = 0;
    // 监听Tab切换
    /* _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        showPopup();
        print('Tab switched to index: ${_tabController.index}');
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Tab> _buildTabs(bool isMobile) {
    return supportplatform.map((platform) {
      return Tab(
        height: isMobile ? 100 : 80,
        child: isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/icon/${platform.platform}.svg',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(height: 6),
                  Flexible(
                    child: Text(
                      context.tr('${platform.platform}.downloadtab'),
                      style: TextStyle(fontSize: 14, color: Color(0xFF0E1823)),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  )
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/icon/${platform.platform}.svg',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      context.tr('${platform.platform}.downloadtab'),
                      style: TextStyle(fontSize: 20, color: Color(0xFF0E1823)),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenheight =
        MediaQuery.of(context).size.height * 0.9 * (isMobile ? 0.9 : 1);
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // 固定顶部 TabBar
            Container(
              color: isMobile
                  ? Colors.white
                  : Theme.of(context)
                      .colorScheme
                      .primary
                      .withAlpha((0.06 * 255).toInt()),
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                labelPadding: const EdgeInsets.only(left: 0, right: 0),
                dividerColor: Colors.grey.withAlpha((0.1 * 255).toInt()),
                dividerHeight: 5,
                tabs: _buildTabs(isMobile),
                indicatorColor: ThemeProvider.instance.primaryColor,
                labelStyle: TextStyle(
                  fontSize: ScreenUtil.sp(6.5),
                  fontWeight: FontWeight.bold,
                  color: ThemeProvider.instance.surfaceTintColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: ScreenUtil.sp(5),
                ),
              ),
            ),

            // ✅ 中间区域整体滚动（包括 TabBarView 和 Footer）
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: supportplatform.map((platform) {
                  final children = _downloadsoft(
                    context,
                    isMobile,
                    screenwidth,
                    screenheight,
                    platform.platform!,
                    platform.downloadUrl!,
                  );

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ✅ 页面主要内容
                        if (isMobile)
                          Column(children: children)
                        else
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ),
                          ),

                        const SizedBox(height: 40), // 与 Footer 留点间距
                        // ✅ Footer 放在滚动内容底部
                        const SiteFooter(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _downloadsoft(
      BuildContext context,
      bool isMobile,
      double screenwidth,
      double screenheight,
      String platform,
      String downloadurl) {
    return [
      Container(
        width: screenwidth / (isMobile ? 1 : 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: isMobile ? 20 : 100),
              Center(
                  child: Text(
                      context.tr("$platform.downloadtab") +
                          context.tr("general.software"),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primary))),
              SizedBox(height: 20),
              Center(
                  child: Text(context.tr("$platform.downloadcontent"),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Color(0xFF0E1823)))),
              SizedBox(height: 20),
              if (platform == 'ios')
                DownButtons(
                  svgPath: "assets/images/icon/ios.svg", // 使用getSvgPath方法
                  label: context.tr('ios.downloadbutton1'),
                  isFilled: false, // 可根据条件设置
                  onPressed: () async {
                    final url = Uri.parse(downloadurl);
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
                ),
              SizedBox(height: 20),
              if (!isMobile)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (platform == 'ios') SizedBox(height: 20),
                    if (platform == 'ios')
                      Center(
                          child: Text(context.tr("ios.downloadcontent1"),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Color(0xFF0E1823)))),
                    SizedBox(height: 20),
                    DownButtons(
                      svgPath:
                          "assets/images/icon/$platform${platform == 'linux' ? 'kong' : ''}.svg", // 使用getSvgPath方法
                      label: context.tr('$platform.downloadbutton'),
                      isFilled: true, // 可根据条件设置
                      onPressed: () async {
                        final url = Uri.parse(downloadurl);
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
                    ),
                    SizedBox(height: 20),
                    if (platform == 'android' || platform == 'macos')
                      DownButtons(
                        svgPath:
                            "assets/images/icon/$platform-appstore.svg", // 使用getSvgPath方法
                        label: context.tr('$platform.downloadbutton1'),
                        isFilled: true, // 可根据条件设
                        onPressed: () async {
                          final url = Uri.parse(downloadurl);
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
                      ),
                  ],
                ),
              if (!isMobile) SizedBox(height: 20),
            ]),
      ),
      Image.asset(
        'assets/images/$platform-app.png',
        width: screenwidth * (isMobile ? 0.8 : 0.4), // 设置宽度为屏幕宽度
        //height: screenheight * 0.6, // 高度是宽度的一半，保持2:1比例
        fit: BoxFit.fill, // 填充并保持比例
      ),
      if (isMobile) SizedBox(height: 20),
      if (isMobile)
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (platform == 'ios')
              Center(
                  child: Text(context.tr("ios.downloadcontent1"),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Color(0xFF0E1823)))),
            SizedBox(height: 20),
            DownButtons(
              svgPath: "assets/images/icon/$platform.svg", // 使用getSvgPath方法
              label: context.tr('$platform.downloadbutton'),
              isFilled: true, // 可根据条件设置
              onPressed: () async {
                final url = Uri.parse(downloadurl);
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
            ),
            SizedBox(height: 20),
            if (platform == 'android' || platform == 'macos')
              DownButtons(
                svgPath:
                    "assets/images/icon/$platform-appstore.svg", // 使用getSvgPath方法
                label: context.tr('$platform.downloadbutton1'),
                isFilled: true, // 可根据条件设置
                onPressed: () async {
                  final url = Uri.parse(downloadurl);
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
              ),
          ],
        ),
    ];
  }
}
