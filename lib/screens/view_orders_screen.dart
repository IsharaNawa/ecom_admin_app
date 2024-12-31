import 'package:flutter/material.dart';

import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/empty_bag.dart';
import 'package:ecom_admin_app/widgets/order_widget.dart';

class ViewOrdersScreen extends StatefulWidget {
  const ViewOrdersScreen({super.key});

  @override
  State<ViewOrdersScreen> createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  bool isOrdersListEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isOrdersListEmpty
        ? Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.canPop(context)
                      ? Navigator.of(context).pop()
                      : null;
                },
                icon: Icon(
                  IconManager.backButtonIcon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            body: EmptyBag(
              mainImage: Icon(
                IconManager.emptyOrdersListIcon,
                size: 200,
              ),
              mainTitle: "There are no ongoing orders!",
              subTitle: "You dont have any ongoing orders.",
              buttonText: "Explore Products",
              buttonFunction: () {},
            ))
        : Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.canPop(context)
                        ? Navigator.of(context).pop()
                        : null;
                  },
                  icon: Icon(
                    IconManager.backButtonIcon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              title: const Text("Orders(6)"),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    OrderWidget(),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.8,
                    ),
                  ],
                );
              },
              itemCount: 25,
            ),
          );
  }
}
