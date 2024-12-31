import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/screens/add_new_product_screen.dart';
import 'package:ecom_admin_app/screens/inspect_all_products_screen.dart';
import 'package:ecom_admin_app/screens/view_orders_screen.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/app_title.dart';
import 'package:ecom_admin_app/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

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
        btnIcon: IconManager.addNewProduct,
        onPressedFunc: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNewProductScreen(),
            ),
          );
        },
      ),
      DashboardItem(
          name: "Inspect All Products",
          btnIcon: IconManager.searchActiveNavbarIcon,
          onPressedFunc: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InspectAllProductsScreen(),
              ),
            );
          }),
      DashboardItem(
          name: "View Orders",
          btnIcon: IconManager.ordersIcon,
          onPressedFunc: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ViewOrdersScreen(),
              ),
            );
          }),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: DynamicHeightGridView(
          builder: (context, index) {
            return dashboardItems[index];
          },
          itemCount: dashboardItems.length,
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
      ),
    );
  }
}
