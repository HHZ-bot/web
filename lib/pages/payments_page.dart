import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/screen_until.dart';
import '../providers/theme_manager.dart';
import '../const/consts.dart';
import '../widgets/product_card.dart';
import '../widgets/footer.dart';
import '../providers/currency_manager.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CurrencyManager>().setCurrencyBasedOnLocale(context.locale);
    });
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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

  List<Tab> _buildTabs(BuildContext context) {
    return [
      Tab(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr('payment.onlinePurchasepro')),
            const SizedBox(width: 8), // 为了使图标和文本之间有间隙
            Container(
              width: ScreenUtil.sp(6),
              height: ScreenUtil.sp(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle, // 让它成为圆形
                gradient: LinearGradient(
                  colors: [
                    ThemeProvider.instance.primaryContainerColor!,
                    ThemeProvider.instance.primaryColor!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
      Tab(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr('payment.onlinePurchaseultra')),
            const SizedBox(width: 8), // 为了使图标和文本之间有间隙
            Container(
              width: ScreenUtil.sp(6),
              height: ScreenUtil.sp(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle, // 让它成为圆形
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow.shade600,
                    Colors.yellow.shade900,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withAlpha((0.06 * 255).toInt()),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.tr("payment.bigtitle"),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 5,
                              color: Color(0xFF0E1823),
                            ),
                          ),
                          SizedBox(width: 10),
                          Selector<CurrencyManager, String>(
                            selector: (context, currencyManager) =>
                                currencyManager.currentCurrency,
                            builder: (context, currentCurrency, child) {
                              return DropdownButton<String>(
                                value: currentCurrency,
                                items: ['USD', 'CNY', 'RUB', 'IRR', 'AFN']
                                    .map((currency) => DropdownMenuItem<String>(
                                          value: currency,
                                          child: Text(
                                            currency,
                                            style: TextStyle(
                                                fontSize: ScreenUtil.sp(6),
                                                color: ThemeProvider
                                                    .instance.onSurfaceColor),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  // 当用户选择不同的币种时更新 CurrencyManager
                                  context
                                      .read<CurrencyManager>()
                                      .updateCurrency(value!);
                                },
                                iconEnabledColor: Color(0xFF0E1823), // 弹出时图标颜色
                                selectedItemBuilder: (BuildContext context) {
                                  return ['USD', 'CNY', 'RUB', 'IRR', 'AFN']
                                      .map((currency) => Text(
                                            context.tr('payment.currency') +
                                                currency,
                                            style: TextStyle(
                                              color: Color(
                                                  0xFF0E1823), // 默认显示的文字颜色
                                              fontSize:
                                                  ScreenUtil.sp(8), // 设置字体大小
                                            ),
                                          ))
                                      .toList();
                                },
                                isDense: true,
                                underline: Container(), // 移除下划线
                              );
                            },
                          )
                        ]),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        SizedBox(width: 20),
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
                        SizedBox(width: 20),
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
                  ]),
            ),
            // 顶部 TabBar
            TabBar(
              controller: _tabController,
              indicatorWeight: 5,
              labelPadding: const EdgeInsets.only(left: 0, right: 0),
              dividerColor: Colors.transparent,
              tabs: _buildTabs(context),
              indicatorColor: ThemeProvider.instance.surfaceTintColor,
              labelStyle: TextStyle(
                fontSize: ScreenUtil.sp(8),
                fontWeight: FontWeight.bold,
                color: ThemeProvider.instance.surfaceTintColor,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: ScreenUtil.sp(8),
              ),
            ),

            // ✅ 中间内容 + Footer 一起滚动
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildScrollableTabContent(
                    const ProductsOnline(lowSearchLevel: 3, highSearchLevel: 5),
                  ),
                  _buildScrollableTabContent(
                    const ProductsOnline(lowSearchLevel: 5, highSearchLevel: 7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ 封装每个 Tab 内容为可滚动区域
  Widget _buildScrollableTabContent(Widget childContent) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          childContent,
          const SizedBox(height: 40), // 和 Footer 留些距离
          const SiteFooter(),
        ],
      ),
    );
  }
}

class ProductsOnline extends StatefulWidget {
  const ProductsOnline({
    super.key,
    required this.lowSearchLevel,
    required this.highSearchLevel,
  });

  final int lowSearchLevel; // 新增下限搜索条件
  final int highSearchLevel; // 新增上限搜索条件
  @override
  State<ProductsOnline> createState() => _ProductsOnlineState();
}

class _ProductsOnlineState extends State<ProductsOnline> {
  int? selectedIndex; // 用于跟踪选中的产品索引 --lskchange
  int? selectedProductIndex;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700; // 手机端
    final products = funproducts;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: EdgeInsets.only(
            left: !isMobile ? 10 : 30, right: !isMobile ? 10 : 30),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(children: [
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                        height: screenHeight * 0.6, // 设置合适的高度
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 4, // 每行显示2个元素
                            crossAxisSpacing: 3, // 列间距
                            mainAxisSpacing: 3, // 行间距
                            childAspectRatio: isMobile ? 5 : 0.8, // 控制每个项目的宽高比例
                          ),
                          itemCount: products
                              .where((product) =>
                                  product.productLevle != null &&
                                  product.productLevle! >=
                                      widget.lowSearchLevel &&
                                  product.productLevle! <
                                      widget.highSearchLevel)
                              .length,
                          itemBuilder: (context, index) {
                            final filteredProducts = products
                                .where((product) =>
                                    product.productLevle != null &&
                                    product.productLevle! >=
                                        widget.lowSearchLevel &&
                                    product.productLevle! <
                                        widget.highSearchLevel)
                                .toList();
                            final product = filteredProducts[index];
                            return ProductCard(
                              product: product,
                              isSelected: selectedProductIndex ==
                                  (product.id! - 1), // 转换为 String
                              onPress: () async {
                                if (mounted) {
                                  setState(() {
                                    selectedProductIndex =
                                        (product.id! - 1); // 转换为 String
                                  });
                                }
                              },
                            );
                          },
                        )),
                  ]);
                },
              ),
              Text(context.tr('payment.currencystatement'),
                  style: TextStyle(
                      color: ThemeProvider.instance.onSurfaceColor,
                      fontSize: ScreenUtil.sp(4))),
              SizedBox(height: screenHeight * 0.03),
            ])));
  }
}
