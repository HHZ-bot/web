import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../providers/currency_manager.dart';
import 'dart:ui' as ui; // 添加 `as ui` 别名
import '../providers/screen_until.dart';
import '../providers/theme_manager.dart';
import '../models/funproduct_model.dart';
import '../widgets/countdown_timer_widget.dart';

class ProductCard extends StatefulWidget {
  final Funproduct product;
  final VoidCallback? onPress; // 修改为 onPress，符合 Dart 命名规范
  final bool isSelected; // 用于传递选中状态

  const ProductCard({
    super.key,
    required this.product,
    required this.onPress,
    this.isSelected = false, // 默认值
  });

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  final int vipdevices = 3;
  @override
  Widget build(BuildContext context) {
    String currentPrice, historyPrice;
    final discountStart = DateTime.tryParse(widget.product.discountStart ?? "");
    final discountStop = DateTime.tryParse(widget.product.discountStop ?? "");
    final currentClock = DateTime.now();
    double letterSpacing = MediaQuery.of(context).size.width * 0.004;
    final days = ((widget.product.productTime ?? 0) / 86400).toStringAsFixed(0);
    final currencyManager = Provider.of<CurrencyManager>(context);
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700; // 手机端
    bool willDiscount = (discountStart != null &&
        discountStop != null &&
        currentClock.isBefore(discountStop) &&
        currentClock.isBefore(discountStart));
    bool inDiscount = (discountStart != null &&
        discountStop != null &&
        currentClock.isBefore(discountStop) &&
        currentClock.isAfter(discountStart));
    if (inDiscount) {
      currentPrice = (((widget.product.productValue ?? 0) -
                  (widget.product.discountValue ?? 0)) /
              100)
          .toStringAsFixed(2);
      historyPrice =
          ((widget.product.productValue ?? 0) / 100).toStringAsFixed(2);
    } else {
      currentPrice =
          ((widget.product.productValue ?? 0) / 100).toStringAsFixed(2);
      historyPrice =
          ((widget.product.productValue ?? 0) / 100).toStringAsFixed(2);
    }

    return GestureDetector(
      onTap: () {
        // 点击时调用传入的回调，并可以传递产品索引
        if (widget.onPress != null) {
          widget.onPress!();
        }
        if (mounted) {
          setState(() {
            // 更新状态（选中或未选中）
          });
        }
      },
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter, // 渐变起始点
            end: Alignment.bottomRight, // 渐变结束点
            colors: widget.isSelected
                ? [
                    ThemeProvider.instance.onPrimaryContainerColor!,
                    ThemeProvider.instance.surfaceTintColor!,
                  ]
                : [
                    ThemeProvider.instance.primaryColor!,
                    ThemeProvider.instance.surfaceTintColor!,
                  ],
          ),
          /*    border: widget.isSelected
              ? Border.all(
                  color: ThemeProvider.instance.primaryColor,
                  width: 1) // 选中时的边框
              : null, */
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
            )
          ],
        ),
        child: (widget.product.productBanner == null ||
                widget.product.productBanner == "")
            ? SingleChildScrollView(
                child: Column(children: [
                  if (!isMobile)
                    Stack(
                      clipBehavior: Clip.none, // 允许子组件超出父组件的边界
                      children: [
                        // 大容器
                        Container(
                          //alignment: Alignment.,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(
                            top: ScreenUtil.sp(13),
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ThemeProvider.instance.surfaceTintColor!,
                                ThemeProvider.instance.primaryContainerColor!,
                              ],
                              begin: Alignment.topRight, // 渐变起始点
                              end: Alignment.bottomLeft, // 渐变结束点
                            ),
                          ),
                          child: Center(
                            child: Text(
                              context.tr(
                                  'payment.${(widget.product.productName?.split(' ').first ?? "null").toLowerCase()}'),
                              style: TextStyle(
                                color: ThemeProvider
                                    .instance.onPrimaryContainerColor,
                                fontSize: ScreenUtil.sp(7),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis, // 超出时省略
                            ),
                          ),
                        ),
                        // 小图形
                        Positioned(
                          right: ScreenUtil.sp(18.2), // 向右偏移
                          top: ScreenUtil.sp(2), // 向上偏移
                          child: Container(
                            height: ScreenUtil.sp(10), // 小图形的高度
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (widget.product.productLevle! >= 5)
                                      ? Colors.yellow.shade600
                                      : ThemeProvider.instance
                                          .primaryContainerColor!, // 渐变的结束颜色
                                  (widget.product.productLevle! >= 5)
                                      ? Colors.yellow.shade900
                                      : ThemeProvider
                                          .instance.primaryColor!, // 渐变的起始颜色
                                ],
                                begin: Alignment.topLeft, // 渐变起始点
                                end: Alignment.bottomRight, // 渐变结束点
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    ScreenUtil.sp(2.5)), // 左上角圆角
                                topRight: Radius.circular(
                                    ScreenUtil.sp(2.5)), // 右上角圆角
                                bottomRight: Radius.circular(
                                    ScreenUtil.sp(2.5)), // 右下角圆角
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26, // 阴影颜色
                                  offset: Offset(2, 2), // 阴影偏移量
                                  blurRadius: 4, // 模糊半径
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                context.tr(widget.product.productLevle! >= 5
                                    ? 'payment.pro'
                                    : 'payment.basic'),
                                style: TextStyle(
                                  color: ThemeProvider.instance
                                      .onPrimaryContainerColor, // 小图形内文本的颜色
                                  fontSize: ScreenUtil.sp(4.5),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: letterSpacing,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile)
                        Stack(
                          clipBehavior: Clip.none, // 允许子组件超出父组件的边界
                          children: [
                            // 大容器
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              margin: EdgeInsets.only(
                                top: ScreenUtil.sp(10),
                              ),
                              constraints: BoxConstraints(
                                minHeight: ScreenUtil.sp(12),
                                minWidth: 60, // 最小宽度
                                maxWidth: 120, // 最大宽度
                              ),
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      ScreenUtil.sp(6)), // 只有右上角圆角
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    ThemeProvider.instance.surfaceTintColor!,
                                    ThemeProvider
                                        .instance.primaryContainerColor!,
                                  ],
                                  begin: Alignment.topRight, // 渐变起始点
                                  end: Alignment.bottomLeft, // 渐变结束点
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  context.tr(
                                      'payment.${(widget.product.productName?.split(' ').first ?? "null").toLowerCase()}'),
                                  style: TextStyle(
                                    color: ThemeProvider
                                        .instance.onPrimaryContainerColor,
                                    fontSize: ScreenUtil.sp(6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis, // 超出时省略
                                ),
                              ),
                            ),
                            // 小图形
                            Positioned(
                              right: ScreenUtil.sp(-8.2), // 向右偏移
                              top: ScreenUtil.sp(4), // 向上偏移
                              child: Container(
                                height: ScreenUtil.sp(6), // 小图形的高度
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      (widget.product.productLevle! >= 5)
                                          ? Colors.yellow.shade600
                                          : ThemeProvider.instance
                                              .primaryContainerColor!, // 渐变的结束颜色
                                      (widget.product.productLevle! >= 5)
                                          ? Colors.yellow.shade900
                                          : ThemeProvider.instance
                                              .primaryColor!, // 渐变的起始颜色
                                    ],
                                    begin: Alignment.topLeft, // 渐变起始点
                                    end: Alignment.bottomRight, // 渐变结束点
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        ScreenUtil.sp(2.5)), // 左上角圆角
                                    topRight: Radius.circular(
                                        ScreenUtil.sp(2.5)), // 右上角圆角
                                    bottomRight: Radius.circular(
                                        ScreenUtil.sp(2.5)), // 右下角圆角
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26, // 阴影颜色
                                      offset: Offset(2, 2), // 阴影偏移量
                                      blurRadius: 4, // 模糊半径
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    context.tr(widget.product.productLevle! >= 5
                                        ? 'payment.pro'
                                        : 'payment.basic'),
                                    style: TextStyle(
                                      color: ThemeProvider.instance
                                          .onPrimaryContainerColor, // 小图形内文本的颜色
                                      fontSize: ScreenUtil.sp(4.5),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: letterSpacing,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Flexible(
                        flex: 7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      ((inDiscount || willDiscount)
                                          ? 0.035
                                          : 0.055),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currencyManager.getCurrencySymbol(),
                                        style: TextStyle(
                                          color: inDiscount
                                              ? Colors.yellow
                                              : ThemeProvider
                                                  .instance.onPrimaryColor,
                                          fontSize: ScreenUtil.sp(6.5),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        currencyManager
                                            .calculatePrice(
                                                double.tryParse(currentPrice) ??
                                                    0.0)
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                          color: inDiscount
                                              ? Colors.yellow
                                              : ThemeProvider
                                                  .instance.onPrimaryColor,
                                          fontSize: ScreenUtil.sp(6.5),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (inDiscount || willDiscount)
                                        Text(
                                          " ",
                                          style: TextStyle(
                                            color: ThemeProvider
                                                .instance.onPrimaryColor,
                                            fontWeight: FontWeight.w100,
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (inDiscount)
                                        Text(
                                          currencyManager
                                              .calculatePrice(double.tryParse(
                                                      historyPrice) ??
                                                  0.0)
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            color: ThemeProvider
                                                .instance.onPrimaryColor,
                                            fontWeight: FontWeight.w300,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2, // 增加删除线的厚度
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            fontSize: ScreenUtil.sp(5.5),
                                            overflow: TextOverflow.ellipsis,
                                            decorationColor:
                                                Colors.yellow, // 设置删除线的颜色
                                          ),
                                        ),
                                      if (inDiscount || willDiscount)
                                        Text(
                                          "  ${context.tr(inDiscount ? 'payment.onsale' : 'payment.comingsale')} ",
                                          style: TextStyle(
                                            color: ThemeProvider
                                                .instance.onPrimaryColor,
                                            fontSize: ScreenUtil.sp(4),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: letterSpacing,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (inDiscount || willDiscount)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                    child: Row(
                                        textDirection: ui.TextDirection.ltr,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            inDiscount
                                                ? context.tr('payment.untilend')
                                                : context
                                                    .tr('payment.untilstart'),
                                            style: TextStyle(
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil.sp(4.5),
                                                letterSpacing: letterSpacing),
                                          ),
                                          CountdownTimer(
                                              endTime: inDiscount
                                                  ? discountStop
                                                  : discountStart)
                                        ]),
                                  ),
                                ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    ((inDiscount || willDiscount)
                                        ? 0.026
                                        : 0.035),
                                child: Text(
                                  " $days${context.tr('payment.vipdays')} ",
                                  style: TextStyle(
                                    color:
                                        ThemeProvider.instance.onPrimaryColor,
                                    fontSize: ScreenUtil.sp(4),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: letterSpacing,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    ((inDiscount || willDiscount)
                                        ? 0.026
                                        : 0.035),
                                child: Text(
                                  " $vipdevices${context.tr('payment.vipdevices')}",
                                  style: TextStyle(
                                      color:
                                          ThemeProvider.instance.onPrimaryColor,
                                      fontSize: ScreenUtil.sp(4),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: letterSpacing,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ]),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: ScreenUtil.sp(15)),
                            constraints: const BoxConstraints(
                              minWidth: 33, // 最小宽度
                              maxWidth: 120, // 最大宽度
                            ),
                            width: MediaQuery.of(context).size.width * 0.09,
                            child: Icon(
                              Icons.check_circle,
                              size: ScreenUtil.sp(8),
                              color: widget.isSelected
                                  ? Colors.orange
                                  : Colors.transparent,
                            ),
                          ))
                    ],
                  )
                ]),
              )
            : ClipRect(
                child: Opacity(
                  opacity: 1, // 设置透明度，范围是 0.0 到 1.0
                  child: Banner(
                      message: widget.product.productBanner ?? "",
                      location: BannerLocation.topEnd,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          if (!isMobile)
                            Stack(
                              clipBehavior: Clip.none, // 允许子组件超出父组件的边界
                              children: [
                                // 大容器
                                Container(
                                  //alignment: Alignment.,
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil.sp(13),
                                  ),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ThemeProvider
                                            .instance.surfaceTintColor!,
                                        ThemeProvider
                                            .instance.primaryContainerColor!,
                                      ],
                                      begin: Alignment.topRight, // 渐变起始点
                                      end: Alignment.bottomLeft, // 渐变结束点
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      context.tr(
                                          'payment.${(widget.product.productName?.split(' ').first ?? "null").toLowerCase()}'),
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .instance.onPrimaryContainerColor,
                                        fontSize: ScreenUtil.sp(7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis, // 超出时省略
                                    ),
                                  ),
                                ),
                                // 小图形
                                Positioned(
                                  right: ScreenUtil.sp(18.2), // 向右偏移
                                  top: ScreenUtil.sp(2), // 向上偏移
                                  child: Container(
                                    height: ScreenUtil.sp(10), // 小图形的高度
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          (widget.product.productLevle! >= 5)
                                              ? Colors.yellow.shade600
                                              : ThemeProvider.instance
                                                  .primaryContainerColor!, // 渐变的结束颜色
                                          (widget.product.productLevle! >= 5)
                                              ? Colors.yellow.shade900
                                              : ThemeProvider.instance
                                                  .primaryColor!, // 渐变的起始颜色
                                        ],
                                        begin: Alignment.topLeft, // 渐变起始点
                                        end: Alignment.bottomRight, // 渐变结束点
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            ScreenUtil.sp(2.5)), // 左上角圆角
                                        topRight: Radius.circular(
                                            ScreenUtil.sp(2.5)), // 右上角圆角
                                        bottomRight: Radius.circular(
                                            ScreenUtil.sp(2.5)), // 右下角圆角
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26, // 阴影颜色
                                          offset: Offset(2, 2), // 阴影偏移量
                                          blurRadius: 4, // 模糊半径
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        context.tr(
                                            widget.product.productLevle! >= 5
                                                ? 'payment.pro'
                                                : 'payment.basic'),
                                        style: TextStyle(
                                          color: ThemeProvider.instance
                                              .onPrimaryContainerColor, // 小图形内文本的颜色
                                          fontSize: ScreenUtil.sp(4.5),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: letterSpacing,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isMobile)
                                Stack(
                                  clipBehavior: Clip.none, // 允许子组件超出父组件的边界
                                  children: [
                                    // 大容器
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      margin: EdgeInsets.only(
                                        top: ScreenUtil.sp(10),
                                      ),
                                      constraints: BoxConstraints(
                                        minHeight: ScreenUtil.sp(12),
                                        minWidth: 60, // 最小宽度
                                        maxWidth: 120, // 最大宽度
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.17,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              ScreenUtil.sp(6)), // 只有右上角圆角
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            ThemeProvider
                                                .instance.surfaceTintColor!,
                                            ThemeProvider.instance
                                                .primaryContainerColor!,
                                          ],
                                          begin: Alignment.topRight, // 渐变起始点
                                          end: Alignment.bottomLeft, // 渐变结束点
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          context.tr(
                                              'payment.${(widget.product.productName?.split(' ').first ?? "null").toLowerCase()}'),
                                          style: TextStyle(
                                            color: ThemeProvider.instance
                                                .onPrimaryContainerColor,
                                            fontSize: ScreenUtil.sp(6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow:
                                              TextOverflow.ellipsis, // 超出时省略
                                        ),
                                      ),
                                    ),
                                    // 小图形
                                    Positioned(
                                      right: ScreenUtil.sp(-8.2), // 向右偏移
                                      top: ScreenUtil.sp(4), // 向上偏移
                                      child: Container(
                                        height: ScreenUtil.sp(6), // 小图形的高度
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              (widget.product.productLevle! >=
                                                      5)
                                                  ? Colors.yellow.shade600
                                                  : ThemeProvider.instance
                                                      .primaryContainerColor!, // 渐变的结束颜色
                                              (widget.product.productLevle! >=
                                                      5)
                                                  ? Colors.yellow.shade900
                                                  : ThemeProvider.instance
                                                      .primaryColor!, // 渐变的起始颜色
                                            ],
                                            begin: Alignment.topLeft, // 渐变起始点
                                            end: Alignment.bottomRight, // 渐变结束点
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                ScreenUtil.sp(2.5)), // 左上角圆角
                                            topRight: Radius.circular(
                                                ScreenUtil.sp(2.5)), // 右上角圆角
                                            bottomRight: Radius.circular(
                                                ScreenUtil.sp(2.5)), // 右下角圆角
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26, // 阴影颜色
                                              offset: Offset(2, 2), // 阴影偏移量
                                              blurRadius: 4, // 模糊半径
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            context.tr(
                                                widget.product.productLevle! >=
                                                        5
                                                    ? 'payment.pro'
                                                    : 'payment.basic'),
                                            style: TextStyle(
                                              color: ThemeProvider.instance
                                                  .onPrimaryContainerColor, // 小图形内文本的颜色
                                              fontSize: ScreenUtil.sp(4.5),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: letterSpacing,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Flexible(
                                flex: 7,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              ((inDiscount || willDiscount)
                                                  ? 0.035
                                                  : 0.055),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                currencyManager
                                                    .getCurrencySymbol(),
                                                style: TextStyle(
                                                  color: inDiscount
                                                      ? Colors.yellow
                                                      : ThemeProvider.instance
                                                          .onPrimaryColor,
                                                  fontSize: ScreenUtil.sp(6.5),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                currencyManager
                                                    .calculatePrice(
                                                        double.tryParse(
                                                                currentPrice) ??
                                                            0.0)
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                  color: inDiscount
                                                      ? Colors.yellow
                                                      : ThemeProvider.instance
                                                          .onPrimaryColor,
                                                  fontSize: ScreenUtil.sp(6.5),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              if (inDiscount || willDiscount)
                                                Text(
                                                  " ",
                                                  style: TextStyle(
                                                    color: ThemeProvider
                                                        .instance
                                                        .onPrimaryColor,
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              if (inDiscount)
                                                Text(
                                                  currencyManager
                                                      .calculatePrice(
                                                          double.tryParse(
                                                                  historyPrice) ??
                                                              0.0)
                                                      .toStringAsFixed(2),
                                                  style: TextStyle(
                                                    color: ThemeProvider
                                                        .instance
                                                        .onPrimaryColor,
                                                    fontWeight: FontWeight.w300,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness:
                                                        2, // 增加删除线的厚度
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    fontSize:
                                                        ScreenUtil.sp(5.5),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    decorationColor: Colors
                                                        .yellow, // 设置删除线的颜色
                                                  ),
                                                ),
                                              if (inDiscount || willDiscount)
                                                Text(
                                                  "  ${context.tr(inDiscount ? 'payment.onsale' : 'payment.comingsale')} ",
                                                  style: TextStyle(
                                                    color: ThemeProvider
                                                        .instance
                                                        .onPrimaryColor,
                                                    fontSize: ScreenUtil.sp(4),
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing:
                                                        letterSpacing,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (inDiscount || willDiscount)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.035,
                                            child: Row(
                                                textDirection:
                                                    ui.TextDirection.ltr,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    inDiscount
                                                        ? context.tr(
                                                            'payment.untilend')
                                                        : context.tr(
                                                            'payment.untilstart'),
                                                    style: TextStyle(
                                                        color: Colors.yellow,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            ScreenUtil.sp(4.5),
                                                        letterSpacing:
                                                            letterSpacing),
                                                  ),
                                                  CountdownTimer(
                                                      endTime: inDiscount
                                                          ? discountStop
                                                          : discountStart)
                                                ]),
                                          ),
                                        ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                ((inDiscount || willDiscount)
                                                    ? 0.026
                                                    : 0.035),
                                        child: Text(
                                          " $days${context.tr('payment.vipdays')} ",
                                          style: TextStyle(
                                            color: ThemeProvider
                                                .instance.onPrimaryColor,
                                            fontSize: ScreenUtil.sp(4),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: letterSpacing,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                ((inDiscount || willDiscount)
                                                    ? 0.026
                                                    : 0.035),
                                        child: Text(
                                          " $vipdevices${context.tr('payment.vipdevices')}",
                                          style: TextStyle(
                                              color: ThemeProvider
                                                  .instance.onPrimaryColor,
                                              fontSize: ScreenUtil.sp(4),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: letterSpacing,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ]),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.only(top: ScreenUtil.sp(15)),
                                    constraints: const BoxConstraints(
                                      minWidth: 33, // 最小宽度
                                      maxWidth: 120, // 最大宽度
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    child: Icon(
                                      Icons.check_circle,
                                      size: ScreenUtil.sp(8),
                                      color: widget.isSelected
                                          ? Colors.orange
                                          : Colors.transparent,
                                    )),
                              )
                            ],
                          ),
                        ]),
                      )),
                ),
              ),
      ),
    );
  }
}
