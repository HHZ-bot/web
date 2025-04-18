import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:webpig/providers/currency_manager.dart';
import 'dart:ui' as ui; // 添加 `as ui` 别名
import 'package:webpig/providers/screen_until.dart';
import 'package:webpig/providers/theme_manager.dart';
import 'package:webpig/models/funproduct_model.dart';
import 'package:webpig/widgets/countdown_timer_widget.dart';

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
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
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
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
            )
          ],
        ),
        child: widget.product.productBanner == null ||
                widget.product.productBanner == ""
            ? (isMobile
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductBadge(
                          inDiscount: inDiscount,
                          willDiscount: willDiscount,
                          name: widget.product.productName ?? "null",
                          level: widget.product.productLevle!),
                      ProductPriceInfo(
                          inDiscount: inDiscount,
                          willDiscount: willDiscount,
                          currentPrice: currentPrice,
                          historyPrice: historyPrice,
                          days: days,
                          vipDevices: vipdevices,
                          discountStart: discountStart,
                          discountStop: discountStop,
                          currencyManager: currencyManager),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        ProductBadge(
                            inDiscount: inDiscount,
                            willDiscount: willDiscount,
                            name: widget.product.productName ?? "null",
                            level: widget.product.productLevle!),
                        ProductPriceInfo(
                            showswitch: 1,
                            inDiscount: inDiscount,
                            willDiscount: willDiscount,
                            currentPrice: currentPrice,
                            historyPrice: historyPrice,
                            days: days,
                            vipDevices: vipdevices,
                            discountStart: discountStart,
                            discountStop: discountStop,
                            currencyManager: currencyManager)
                      ]),
                      ProductPriceInfo(
                          showswitch: 2,
                          inDiscount: inDiscount,
                          willDiscount: willDiscount,
                          currentPrice: currentPrice,
                          historyPrice: historyPrice,
                          days: days,
                          vipDevices: vipdevices,
                          discountStart: discountStart,
                          discountStop: discountStop,
                          currencyManager: currencyManager),
                    ],
                  ))
            : ClipRect(
                child: Opacity(
                  opacity: 1,
                  child: Banner(
                      message: widget.product.productBanner ?? "",
                      location: BannerLocation.topEnd,
                      child: (isMobile
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductBadge(
                                    inDiscount: inDiscount,
                                    willDiscount: willDiscount,
                                    name: widget.product.productName ?? "null",
                                    level: widget.product.productLevle!),
                                ProductPriceInfo(
                                    inDiscount: inDiscount,
                                    willDiscount: willDiscount,
                                    currentPrice: currentPrice,
                                    historyPrice: historyPrice,
                                    days: days,
                                    vipDevices: vipdevices,
                                    discountStart: discountStart,
                                    discountStop: discountStop,
                                    currencyManager: currencyManager),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  ProductBadge(
                                      inDiscount: inDiscount,
                                      willDiscount: willDiscount,
                                      name:
                                          widget.product.productName ?? "null",
                                      level: widget.product.productLevle!),
                                  ProductPriceInfo(
                                      showswitch: 1,
                                      inDiscount: inDiscount,
                                      willDiscount: willDiscount,
                                      currentPrice: currentPrice,
                                      historyPrice: historyPrice,
                                      days: days,
                                      vipDevices: vipdevices,
                                      discountStart: discountStart,
                                      discountStop: discountStop,
                                      currencyManager: currencyManager)
                                ]),
                                ProductPriceInfo(
                                    showswitch: 2,
                                    inDiscount: inDiscount,
                                    willDiscount: willDiscount,
                                    currentPrice: currentPrice,
                                    historyPrice: historyPrice,
                                    days: days,
                                    vipDevices: vipdevices,
                                    discountStart: discountStart,
                                    discountStop: discountStop,
                                    currencyManager: currencyManager),
                              ],
                            ))),
                ),
              ),
      ),
    );
  }
}

class ProductBadge extends StatelessWidget {
  final bool inDiscount;
  final bool willDiscount;
  final int level; // 用户等级
  final String name; // 套餐名称

  const ProductBadge({
    super.key,
    required this.inDiscount,
    required this.willDiscount,
    required this.level,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // 允许子组件超出父组件的边界
      children: [
        // 主标签容器
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.only(top: ScreenUtil.sp(10)),
          constraints: const BoxConstraints(
            minWidth: 60,
            maxWidth: 100,
          ),
          height: ScreenUtil.sp(18),
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil.sp(6)),
            ),
            gradient: LinearGradient(
              colors: level >= 5
                  ? [Colors.yellow.shade600, Colors.yellow.shade900]
                  : [
                      ThemeProvider.instance.surfaceTintColor!,
                      ThemeProvider.instance.primaryContainerColor!,
                    ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Text(
              context.tr('payment.${name.split(' ').first.toLowerCase()}'),
              style: TextStyle(
                color: ThemeProvider.instance.onPrimaryContainerColor,
                fontSize: ScreenUtil.sp(6),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // 等级徽标
        if (inDiscount || willDiscount)
          Positioned(
            right: ScreenUtil.sp(-8.2),
            top: ScreenUtil.sp(2),
            child: Container(
              height: ScreenUtil.sp(8),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil.sp(2.5)),
                  topRight: Radius.circular(ScreenUtil.sp(2.5)),
                  bottomRight: Radius.circular(ScreenUtil.sp(2.5)),
                ),
                border: Border.all(
                  color: Colors.yellowAccent, // 设置边框颜色
                  width: 0.5, // 设置边框宽度
                ),
              ),
              child: Center(
                child: Text(
                  "  ${context.tr(inDiscount ? 'payment.onsale' : 'payment.comingsale')} ",
                  style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: ScreenUtil.sp(5.5),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProductPriceInfo extends StatelessWidget {
  final int showswitch;
  final bool inDiscount;
  final bool willDiscount;
  final String currentPrice;
  final String historyPrice;
  final String days;
  final int vipDevices;
  final DateTime? discountStart;
  final DateTime? discountStop;
  final CurrencyManager currencyManager;
  final double letterSpacing;

  const ProductPriceInfo({
    super.key,
    this.showswitch = 0,
    required this.inDiscount,
    required this.willDiscount,
    required this.currentPrice,
    required this.historyPrice,
    required this.days,
    required this.vipDevices,
    required this.discountStart,
    required this.discountStop,
    required this.currencyManager,
    this.letterSpacing = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showswitch == 1) SizedBox(height: ScreenUtil.sp(10)),
          if (showswitch != 2)
            Row(
              textDirection: ui.TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currencyManager.getCurrencySymbol(),
                  style: TextStyle(
                    color: inDiscount
                        ? Colors.yellow
                        : ThemeProvider.instance.onPrimaryColor,
                    fontSize: ScreenUtil.sp(6.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  currencyManager
                      .calculatePrice(double.tryParse(currentPrice) ?? 0.0)
                      .toStringAsFixed(2),
                  style: TextStyle(
                    color: inDiscount
                        ? Colors.yellow
                        : ThemeProvider.instance.onPrimaryColor,
                    fontSize: ScreenUtil.sp(10),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (inDiscount)
                  Text(
                    currencyManager
                        .calculatePrice(double.tryParse(historyPrice) ?? 0.0)
                        .toStringAsFixed(2),
                    style: TextStyle(
                      color: ThemeProvider.instance.onPrimaryColor,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: ScreenUtil.sp(5.5),
                      overflow: TextOverflow.ellipsis,
                      decorationColor: Colors.yellow,
                    ),
                  ),
              ],
            ),
          if ((inDiscount || willDiscount) && showswitch != 1)
            Row(
              textDirection: ui.TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  inDiscount
                      ? context.tr('payment.untilend')
                      : context.tr('payment.untilstart'),
                  style: TextStyle(
                    color: ThemeProvider.instance.onPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.sp(5.5),
                    letterSpacing: letterSpacing,
                  ),
                ),
                CountdownTimer(
                  endTime: inDiscount ? discountStop! : discountStart!,
                ),
              ],
            ),
          if (showswitch != 1)
            Row(
                textDirection: ui.TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " $days${context.tr('payment.vipdays')} ",
                    style: TextStyle(
                      color: ThemeProvider.instance.onPrimaryColor,
                      fontSize: ScreenUtil.sp(5.5),
                      fontWeight: FontWeight.w500,
                      letterSpacing: letterSpacing,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]),
          if (showswitch != 1)
            Row(
                textDirection: ui.TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " $vipDevices${context.tr('payment.vipdevices')}",
                    style: TextStyle(
                      color: ThemeProvider.instance.onPrimaryColor,
                      fontSize: ScreenUtil.sp(5.5),
                      fontWeight: FontWeight.w500,
                      letterSpacing: letterSpacing,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]),
        ],
      ),
    );
  }
}
