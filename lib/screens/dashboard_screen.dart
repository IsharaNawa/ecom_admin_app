import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/app_title.dart';
import 'package:ecom_admin_app/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);
    List<Widget> dashboardItems = [
      DashboardItem(
        name: "Add a new Product",
        btn_icon: IconManager.addToCartGeneralIcon,
      ),
      DashboardItem(
        name: "Inspect All Products",
        btn_icon: IconManager.addToCartGeneralIcon,
      ),
      DashboardItem(
        name: "View Orders",
        btn_icon: IconManager.addToCartGeneralIcon,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Icon(
            IconManager.appBarIcon,
          ),
        ),
        title: const AppTitle(
          fontSize: 24.0,
        ),
        actions: [
          IconButton(
            icon: isDarkmodeOn
                ? Icon(IconManager.darkModeIcon)
                : Icon(IconManager.lightModeIcon),
            onPressed: () {
              ref.read(darkModeThemeStatusProvider.notifier).toggleDarkMode();
            },
          ),
        ],
      ),
      body: DynamicHeightGridView(
        builder: (context, index) {
          return dashboardItems[index];
        },
        itemCount: dashboardItems.length,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
    );
  }
}
