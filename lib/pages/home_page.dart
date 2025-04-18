import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:webpig/widgets/down_buttons.dart';
import 'package:webpig/widgets/footer.dart';
import 'package:webpig/widgets/pig_link.dart';
import 'package:webpig/providers/log.dart';

final _log = Log.withTag('HomePage');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  //final Logger _logger = Logger('HomePage');
  @override
  void initState() {
    super.initState();

    // 创建动画控制器
    _controller = AnimationController(
      duration: Duration(seconds: 4), // 总动画时长为4秒
      vsync: this,
    );

    // 使用TweenSequence来定义动画序列
    scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0), // 第一步：保持原样 1秒
        weight: 0.6,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.9), // 第二步：变大
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.9, end: 1.03), // 第三步：变小
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.03, end: 1.0), // 第三步：变小
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0), // 第四步：恢复原样 1秒
        weight: 0.6,
      ),
    ]).animate(_controller);

    // 启动动画
    _controller.repeat(reverse: false); // 不反向循环，让动画按顺序播放
    _log.info('App started');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenheight =
        MediaQuery.of(context).size.height * 0.9 * (isMobile ? 0.9 : 1);
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          // 背景图层
                          Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              'assets/images/home-bg-1.png',
                              width: screenwidth,
                              height: screenheight * (isMobile ? 2 : 1),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // 主内容层
                          isMobile
                              // 移动端使用 Column 布局
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _context1(context, isMobile,
                                      screenwidth, screenheight),
                                )
                              // 非移动端使用 Row 布局
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _context1(context, isMobile,
                                      screenwidth, screenheight),
                                ),
                        ],
                      ),
                      // 传递动画给 _context2
                      _context2(context, isMobile, screenwidth, screenheight,
                          scaleAnimation),
                      //  _context3(context),
                      SiteFooter()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建控件
  List<Widget> _context1(BuildContext context, bool isMobile,
      double screenwidth, double screenheight) {
    return [
      Container(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withAlpha((0.15 * 255).toInt()),
        width: screenwidth / (isMobile ? 1 : 2),
        height: screenheight,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: isMobile ? 50 : 100),
              Center(
                  child: Text(context.tr("general.title"),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: Color(0xFF0E1823)))),
              SizedBox(height: 20),
              Center(
                  child: Text(context.tr("home.adtitle5"),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: Color(0xFF0E1823)))),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.speed,
                          color: Theme.of(context).colorScheme.primary,
                          size: 25),
                      SizedBox(width: 6),
                      Text(
                        context.tr("home.adtitle6"), // 高速
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                          color: Color(0xFF0E1823),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.security,
                          color: Theme.of(context).colorScheme.primary,
                          size: 25),
                      SizedBox(width: 6),
                      Text(
                        context.tr("home.adtitle7"), // 安全
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                          color: Color(0xFF0E1823),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified,
                          color: Theme.of(context).colorScheme.primary,
                          size: 25),
                      SizedBox(width: 6),
                      Text(
                        context.tr("home.adtitle8"), // 稳定
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                          color: Color(0xFF0E1823),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: PlatformGridView(),
              ),
            ]),
      ),
      Container(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withAlpha((0.15 * 255).toInt()),
        width: screenwidth / (isMobile ? 1 : 2),
        height: screenheight,
        child: PigLink(),
      ),
    ];
  }

  // 传入动画的 _context2
  Widget _context2(BuildContext context, bool isMobile, double screenwidth,
      double screenheight, Animation<double> scaleAnimation) {
    // 背景图的高度，宽高比为2:1
    double bgHeight = screenwidth / (isMobile ? 1 : 1.8);

    return Container(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withAlpha((0.08 * 255).toInt()),
        width: screenwidth, // 设置宽度为屏幕宽度

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0), // 上下留白 10.0
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 40,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w900,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: context.tr("home.adtitle1"),
                      style: TextStyle(
                        color: Color(0xFF0E1823),
                      ),
                    ),
                    TextSpan(
                      text: context.tr("home.adtitle2"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha((0.1 * 255).toInt()), // 给这部分文字添加背景色
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                // 背景图（动画效果：缩放，宽高比为2:1）
                AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: scaleAnimation.value, // 根据动画值缩放
                      child: child,
                    );
                  },
                  child: Opacity(
                    opacity: 1,
                    child: Image.asset(
                      isMobile
                          ? 'assets/images/home-bg-3.webp'
                          : 'assets/images/home-bg-2.webp',
                      width: screenwidth, // 设置宽度为屏幕宽度
                      height: bgHeight, // 高度是宽度的一半，保持2:1比例
                      fit: BoxFit.cover, // 填充并保持比例
                    ),
                  ),
                ),
                // Logo图标（定位到背景图片的中心）
                Positioned(
                  left: (screenwidth - 200) / 2, // 居中计算：背景图宽度减去 logo 宽度的一半
                  top: (bgHeight - 200) / 2, // 居中计算：背景图高度减去 logo 高度的一半
                  child: Image.asset(
                    'assets/images/logocenter.webp',
                    width: 200, // 设置 logo 的宽度
                    height: 200, // 设置 logo 的高度
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0), // 上下留白 10.0
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: context.tr("home.adtitle3"),
                      style: TextStyle(
                        color: Color(0xFF0E1823),
                      ),
                    ),
                    TextSpan(
                      text: context.tr("home.adtitle4"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha((0.1 * 255).toInt()), // 给这部分文字添加背景色
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
