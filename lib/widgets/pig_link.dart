import 'package:flutter/material.dart';
import '../providers/theme_manager.dart';
import '../providers/screen_until.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/global_timer_manager.dart';

class PigLink extends StatefulWidget {
  const PigLink({super.key});

  @override
  PigLinkState createState() => PigLinkState();
}

class PigLinkState extends State<PigLink> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GlassesWithEyesPage(
              leftEye: ShareandsignCircleButton(
                text: context.tr(
                  'home.signin',
                ),
                icon: Icons.edit_calendar_outlined,
                rotationAngle: 0,
                gradient: LinearGradient(
                  colors: [
                    ThemeProvider.instance.surfaceTintColor!
                        .withAlpha((0.5 * 255).toInt()),
                    ThemeProvider.instance.onPrimaryContainerColor!
                        .withAlpha((0.5 * 255).toInt()),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
                onPressed: () async {},
              ),
              rightEye: ShareandsignCircleButton(
                text: context.tr('home.share'),
                icon: Icons.share,
                rotationAngle: 0,
                gradient: LinearGradient(
                  colors: [
                    ThemeProvider.instance.surfaceTintColor!
                        .withAlpha((0.5 * 255).toInt()), // 渐变颜色
                    ThemeProvider.instance.onPrimaryContainerColor!
                        .withAlpha((0.5 * 255).toInt()),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
                onPressed: () {},
              ),
            ),
            ConnectionButton(
              //isLoading: true,
              onTap: null,
              enabled: false,
              isConnected: true,
              isconnecting: false,
              label: '',
              buttonColor: ThemeProvider.instance.surfaceTintColor!,
            )
          ],
        ),
      ),
    );
  }
}

class GlassesPainter extends CustomPainter {
  const GlassesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 画眼镜框和镜片的相关设置
    Paint paint = Paint()
      ..color = ThemeProvider.instance.surfaceTintColor! // 设置眼镜框的颜色
      ..style = PaintingStyle.stroke // 设置绘制为边框线条
      ..strokeWidth = 0.8; // 设置线条宽度

    // 计算眼镜框的宽度和高度占比
    double frameWidth = size.width * 0.35; // 设置眼镜框宽度占总宽度的比例
    double frameHeight = size.height * 0.32; // 设置眼镜框高度占总高度的比例

    // 设置左眼镜片的中心点位置
    double centerX1 = size.width * 0.25; // 左镜片的X轴中心位置
    double centerY1 = size.height / 2; // 左镜片的Y轴中心位置

    // 设置右眼镜片的中心点位置
    double centerX2 = size.width * 0.75; // 右镜片的X轴中心位置
    double centerY2 = size.height / 2; // 右镜片的Y轴中心位置

    // 画眼镜的耳柄（镜框两侧的挂耳部分）
    paint.strokeWidth = 6; // 设置耳柄线条宽度
    canvas.drawLine(
      Offset(centerX1 - frameWidth / 2 - 0.8, centerY1), // 左侧耳柄起点
      Offset(centerX1 - frameWidth, centerY1), // 左侧耳柄终点
      paint,
    );

    canvas.drawLine(
      Offset(centerX2 + frameWidth / 2 + 0.8, centerY2), // 右侧耳柄起点
      Offset(centerX2 + frameWidth, centerY2), // 右侧耳柄终点
      paint,
    );

    // 创建左侧眼镜片的路径
    Path path1 = Path()
      ..moveTo(centerX1 - frameWidth / 2, centerY1 - frameHeight / 2)
      ..quadraticBezierTo(
          centerX1,
          centerY1 - frameHeight * 0.55, // 上边向外弯曲
          centerX1 + frameWidth / 2,
          centerY1 - frameHeight / 2)
      ..quadraticBezierTo(
          centerX1 + frameWidth * 0.6,
          centerY1, // 右侧向外弯曲
          centerX1 + frameWidth / 2,
          centerY1 + frameHeight / 2)
      ..quadraticBezierTo(
          centerX1,
          centerY1 + frameHeight * 1.1, // 下边最大弯曲，向内
          centerX1 - frameWidth / 2,
          centerY1 + frameHeight / 2)
      ..quadraticBezierTo(
          centerX1 - frameWidth * 0.6,
          centerY1, // 左侧向外弯曲
          centerX1 - frameWidth / 2,
          centerY1 - frameHeight / 2)
      ..close(); // 关闭路径

    // 同样的处理方式应用到第二个眼镜片
    Path path2 = Path()
      ..moveTo(centerX2 - frameWidth / 2, centerY2 - frameHeight / 2)
      ..quadraticBezierTo(
          centerX2,
          centerY2 - frameHeight * 0.55, // 上边向外弯曲
          centerX2 + frameWidth / 2,
          centerY2 - frameHeight / 2)
      ..quadraticBezierTo(
          centerX2 + frameWidth * 0.6,
          centerY2, // 右侧向外弯曲
          centerX2 + frameWidth / 2,
          centerY2 + frameHeight / 2)
      ..quadraticBezierTo(
          centerX2,
          centerY2 + frameHeight * 1.1, // 下边最大弯曲，向内
          centerX2 - frameWidth / 2,
          centerY2 + frameHeight / 2)
      ..quadraticBezierTo(
          centerX2 - frameWidth * 0.6,
          centerY2, // 左侧向外弯曲
          centerX2 - frameWidth / 2,
          centerY2 - frameHeight / 2)
      ..close(); // 关闭路径

    // 画左眼镜框
    canvas.drawPath(path1, paint);

    // 画右眼镜框
    canvas.drawPath(path2, paint);

    // 创建眼镜片渐变色（镜片内部颜色）
    Paint lensPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          ThemeProvider.instance.surfaceTintColor!
              .withAlpha((0.9 * 255).toInt()), // 眼镜片的渐变颜色
          ThemeProvider.instance.onPrimaryContainerColor!
              .withAlpha((0.8 * 255).toInt()), // 透明度调整的颜色
        ],
        radius: 0.8, // 渐变的半径
        center: Alignment.center, // 渐变中心
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2), // 渐变中心位置
          width: size.width, // 渐变宽度
          height: size.height, // 渐变高度
        ),
      );

    // 绘制左眼镜片（渐变效果）
    canvas.drawPath(path1, lensPaint);

    // 绘制右眼镜片（渐变效果）
    canvas.drawPath(path2, lensPaint);

    // 画眼镜架：连接两个镜框的线条
    paint.strokeWidth = 3.5; // 设置较小的线条宽度
    paint.color = ThemeProvider.instance.surfaceTintColor!; // 连接线的颜色
    canvas.drawLine(
      Offset(centerX1 + frameWidth / 2 + 0.6, centerY1), // 左镜框右端
      Offset(centerX2 - frameWidth / 2 - 0.6, centerY2), // 右镜框左端
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class GlassesWithEyesPage extends StatefulWidget {
  final Widget leftEye; // 左眼控件
  final Widget rightEye; // 右眼控件

  const GlassesWithEyesPage({
    super.key,
    required this.leftEye,
    required this.rightEye,
  });

  @override
  GlassesWithEyesPageState createState() => GlassesWithEyesPageState();
}

class GlassesWithEyesPageState extends State<GlassesWithEyesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100), // 动画周期缩短为 500ms
      vsync: this,
    );

    _animation = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(0.01, 0)) // 设置晃动范围
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true); // 让眼球轻微晃动
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700; // 手机端

    return SizedBox(
      height: ScreenUtil.sp(100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                size: Size(
                    isMobile
                        ? MediaQuery.of(context).size.width
                        : ScreenUtil.sp(140),
                    ScreenUtil.sp(95)),
                painter: const GlassesPainter(),
              ),
              // 左眼球
              Positioned(
                  left: isMobile
                      ? MediaQuery.of(context).size.width /
                          ScreenUtil.sp(100) *
                          ScreenUtil.sp(18)

                      ///MediaQuery.of(context).size.width * 0.35 * 0.45
                      : ScreenUtil.sp(20),
                  top: ScreenUtil.sp(36),
                  child: RepaintBoundary(
                    child: SlideTransition(
                      position: _animation,
                      child: widget.leftEye,
                    ),
                  )),
              // 右眼球
              Positioned(
                  right: isMobile
                      ? MediaQuery.of(context).size.width /
                          ScreenUtil.sp(100) *
                          ScreenUtil.sp(18)
                      : ScreenUtil.sp(20),
                  top: ScreenUtil.sp(36),
                  child: RepaintBoundary(
                    child: SlideTransition(
                      position: _animation,
                      child: widget.rightEye,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class ShareandsignCircleButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double rotationAngle; // 增加旋转角度参数

  const ShareandsignCircleButton({
    super.key,
    required this.text,
    required this.icon,
    required this.gradient,
    required this.onPressed,
    this.rotationAngle = 0.0, // 默认角度为 0 度
  });

  @override
  ShareandsignCircleButtonState createState() =>
      ShareandsignCircleButtonState();
}

class ShareandsignCircleButtonState extends State<ShareandsignCircleButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (mounted) {
      (() {
        _isPressed = true;
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
      widget.onPressed();
    }
  }

  void _onTapCancel() {
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.rotationAngle, // 应用旋转角度
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          width: ScreenUtil.sp(30), // 调整宽度让按钮更接近半圆形
          height: ScreenUtil.sp(30), // 高度决定半圆高度
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenUtil.sp(60)),
              topRight: Radius.circular(ScreenUtil.sp(60)),
              bottomLeft: Radius.circular(ScreenUtil.sp(60)),
              bottomRight: Radius.circular(ScreenUtil.sp(60)),
            ),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.white.withAlpha((0.3 * 255).toInt()),
                      offset: const Offset(4, 4),
                      blurRadius: ScreenUtil.sp(8),
                    ),
                  ],
          ),
          child: Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: Colors.white, size: ScreenUtil.sp(8)),
                SizedBox(width: ScreenUtil.sp(1)),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: ScreenUtil.sp(5),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1, // 限制为一行显示
                  overflow: TextOverflow.ellipsis, // 超过一行的文本使用省略号
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({
    super.key,
    this.onTap,
    required this.enabled,
    required this.label,
    required this.buttonColor,
    this.isConnected = false,
    this.isconnecting = false,
  });

  final VoidCallback? onTap;
  final bool enabled;
  final bool isConnected;
  final bool isconnecting;
  final String label;
  final Color buttonColor;

  @override
  ConnectionButtonState createState() => ConnectionButtonState();
}

class ConnectionButtonState extends State<ConnectionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 每次抖动的持续时间
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          // 动画完成后停止并开始下一次随机抖动
          _startRandomShake();
        }
      });

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(_random.nextDouble() * 0.02, _random.nextDouble() * 0.02),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startRandomShake(); // 开始第一个随机抖动

    // 使用全局定时器管理器添加定时任务，定期触发抖动
    GlobalTimerManager.shared.addRepeatingTask(
      'shakeTask',
      Duration(seconds: 2 + _random.nextInt(4)), // 每隔 2 到 6 秒触发一次
      _triggerShake, // 抖动的回调函数
    );
  }

  // 随机触发一次抖动，执行2-3次快速抖动
// 改进后的动画控制触发逻辑
  void _triggerShake() {
    if (!mounted) return; // 确保组件仍然存在

    // 防止在动画运行时重复启动动画
    if (_controller.isAnimating) return;

    // 每次触发时执行 2-3 次快速抖动
    _controller.repeat(
      reverse: true,
      period: const Duration(milliseconds: 100),
    );

    // 每次抖动时执行 2-3 次快速动画
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.stop(); // 停止抖动动画
        _startRandomShake(); // 准备下一次随机抖动
      }
    });

    // 第二次抖动
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted && !_controller.isAnimating) {
        _controller.repeat(
          reverse: true,
          period: const Duration(milliseconds: 100),
        );
      }
    });

    // 第三次抖动
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && !_controller.isAnimating) {
        _controller.repeat(
          reverse: true,
          period: const Duration(milliseconds: 100),
        );
      }
    });

    // 设置停顿时间，避免连续触发
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.stop(); // 完成抖动后停止动画
      }
    });
  }

  // 开始一个新的随机抖动，随机化抖动的时长和幅度
  void _startRandomShake() {
    if (!mounted) return;
    // 随机设置抖动的持续时间和幅度
    _controller.duration =
        Duration(milliseconds: 100 + _random.nextInt(200)); // 随机抖动持续时间
    _animation = Tween<Offset>(
      begin: const Offset(0.06, 0.02),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    // 在 widget 被销毁时，释放动画控制器
    _controller.dispose(); // 释放 AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          button: true,
          enabled: false,
          label: widget.label,
          child: Stack(alignment: Alignment.center, children: [
            // 主按钮内容
            Container(
                // 外部的大圆圈，稍大于猪鼻子部分
                width: ScreenUtil.sp(70), // 外部圆圈的宽度
                height: ScreenUtil.sp(70), // 外部圆圈的高度
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ThemeProvider.instance.surfaceTintColor!
                          .withAlpha((0.3 * 255).toInt()), // 阴影颜色
                      blurRadius: ScreenUtil.sp(6), // 阴影模糊半径
                      offset:
                          Offset(ScreenUtil.sp(5), ScreenUtil.sp(1)), // 阴影偏移
                    ),
                  ],
                ),
                child: Center(
                    child: RepaintBoundary(
                  child: SlideTransition(
                    position: _animation,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: ScreenUtil.sp(3),
                            color: ThemeProvider.instance.surfaceTintColor!
                                .withAlpha((0.2 * 255).toInt()),
                            offset: Offset(
                                ScreenUtil.sp(5), ScreenUtil.sp(1)), // 阴影偏移
                          ),
                        ],
                      ),
                      width: ScreenUtil.sp(65),
                      height: ScreenUtil.sp(65),
                      child: Material(
                        key: const ValueKey("home_connection_button"),
                        shape: const CircleBorder(),
                        color: widget.isConnected
                            ? ThemeProvider.instance.secondaryContainerColor
                            : Colors.white,
                        child: InkWell(
                          onTap: widget.onTap,
                          child: Padding(
                            padding: const EdgeInsets.all(36),
                            child: TweenAnimationBuilder(
                              tween: ColorTween(end: widget.buttonColor),
                              duration: const Duration(milliseconds: 250),
                              builder: (context, value, child) {
                                return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RepaintBoundary(
                                        child: FlashingButton(
                                          shouldFlash: widget.isconnecting ||
                                              widget.isConnected, // 是否开启闪烁
                                          intervalSeconds: 0, // 闪烁前延迟时间
                                          gradient: LinearGradient(
                                            colors: [
                                              (widget.isconnecting ||
                                                      widget.isConnected)
                                                  ? ThemeProvider.instance
                                                      .surfaceTintColor!
                                                  : const Color.fromARGB(255,
                                                      117, 105, 105), // 渐变颜色
                                              (widget.isconnecting ||
                                                      widget.isConnected)
                                                  ? ThemeProvider.instance
                                                      .onPrimaryContainerColor!
                                                  : const Color(0xFFF5F5F5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          lightGradient: LinearGradient(
                                            colors: [
                                              widget.isConnected
                                                  ? ThemeProvider.instance
                                                      .surfaceTintColor!
                                                      .withAlpha(
                                                          (0.8 * 255).toInt())
                                                  : const Color.fromARGB(
                                                      255, 117, 105, 105),
                                              widget.isConnected
                                                  ? ThemeProvider.instance
                                                      .onPrimaryContainerColor!
                                                      .withAlpha(
                                                          (0.8 * 255).toInt())
                                                  : const Color(0xFFF5F5F5)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: ScreenUtil.sp(4)),
                                      RepaintBoundary(
                                        child: FlashingButton(
                                          shouldFlash: widget.isconnecting ||
                                              widget.isConnected, // 是否开启闪烁
                                          intervalSeconds: widget.isconnecting
                                              ? 1
                                              : 0, // 闪烁前延迟时间
                                          gradient: LinearGradient(
                                            colors: [
                                              (widget.isconnecting ||
                                                      widget.isConnected)
                                                  ? ThemeProvider.instance
                                                      .surfaceTintColor!
                                                  : const Color.fromARGB(255,
                                                      117, 105, 105), // 渐变颜色
                                              (widget.isconnecting ||
                                                      widget.isConnected)
                                                  ? ThemeProvider.instance
                                                      .onPrimaryContainerColor!
                                                  : const Color(0xFFF5F5F5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          lightGradient: LinearGradient(
                                            colors: [
                                              widget.isConnected
                                                  ? ThemeProvider.instance
                                                      .surfaceTintColor!
                                                      .withAlpha(
                                                          (0.8 * 255).toInt())
                                                  : const Color.fromARGB(
                                                      255, 117, 105, 105),
                                              widget.isConnected
                                                  ? ThemeProvider.instance
                                                      .onPrimaryContainerColor!
                                                      .withAlpha(
                                                          (0.8 * 255).toInt())
                                                  : const Color(0xFFF5F5F5)
                                            ],
                                          ),
                                        ),
                                      )
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ).animate(target: widget.enabled ? 0 : 1).blurXY(end: 1),
                    )
                        .animate(target: widget.enabled ? 0 : 1)
                        .scaleXY(end: .88, curve: Curves.easeIn),
                  ),
                )))
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        ExcludeSemantics(
          child: AnimatedText(
            widget.label,
            style: TextStyle(fontSize: ScreenUtil.sp(7)),
          ),
        ),
      ],
    );
  }
}

class FlashingButton extends StatefulWidget {
  final bool shouldFlash;
  final int intervalSeconds; // 延迟时间
  final Gradient gradient; // 按钮的主渐变颜色
  final Gradient lightGradient; // 闪烁的浅色渐变

  const FlashingButton({
    super.key,
    required this.shouldFlash,
    required this.intervalSeconds,
    required this.gradient,
    required this.lightGradient,
  });

  @override
  FlashingButtonState createState() => FlashingButtonState();
}

class FlashingButtonState extends State<FlashingButton> {
  bool _isVisible = true; // 控制按钮的显示状态
  bool _shouldContinueFlashing = true; // 新增变量用于控制闪烁状态

  @override
  void initState() {
    super.initState();
    if (widget.shouldFlash) {
      _startFlashing();
    }
  }

  void _startFlashing() async {
    if (widget.intervalSeconds > 0) {
      await Future.delayed(Duration(seconds: widget.intervalSeconds));
    }

    // 每 1 秒切换一次 _isVisible 状态，实现闪烁效果
    while (widget.shouldFlash && _shouldContinueFlashing && mounted) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void didUpdateWidget(FlashingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldFlash != oldWidget.shouldFlash) {
      if (widget.shouldFlash) {
        _shouldContinueFlashing = true;
        _startFlashing();
      } else {
        if (mounted) {
          setState(() {
            _isVisible = true; // 停止闪烁时恢复到可见状态
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _shouldContinueFlashing = false; // 停止闪烁
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.sp(14),
      height: ScreenUtil.sp(30),
      decoration: BoxDecoration(
        gradient: _isVisible ? widget.gradient : widget.lightGradient,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: _isVisible
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  offset: const Offset(4, 4),
                  blurRadius: ScreenUtil.sp(8),
                ),
              ]
            : [],
      ),
    );
  }
}

class AnimatedText extends Text {
  const AnimatedText(
    super.data, {
    super.key,
    super.style,
    this.duration = const Duration(milliseconds: 250),
    this.size = true,
    this.slide = true,
  });

  final Duration duration;
  final bool size;
  final bool slide;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        child = FadeTransition(
          opacity: animation,
          child: child,
        );
        if (size) {
          child = SizeTransition(
            axis: Axis.horizontal,
            fixedCrossAxisSizeFactor: 1,
            sizeFactor: Tween<double>(begin: 0.88, end: 1).animate(animation),
            child: child,
          );
        }
        if (slide) {
          child = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
        return child;
      },
      child: Text(
        data!,
        key: ValueKey<String>(data!),
        style: style,
      ),
    );
  }
}
