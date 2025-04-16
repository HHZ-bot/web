import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

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

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
            Text('home.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: Text('home.goto_about'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
