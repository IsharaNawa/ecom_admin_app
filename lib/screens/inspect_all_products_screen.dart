import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecom_admin_app/widgets/product_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/providers/product_provider.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';

class InspectAllProductsScreen extends ConsumerStatefulWidget {
  const InspectAllProductsScreen({super.key});

  @override
  ConsumerState<InspectAllProductsScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<InspectAllProductsScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  List<Product> searchedProducts = [];

  @override
  Widget build(BuildContext context) {
    List<Product> allProducts = ref.watch(productsProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          title: const Text("Explore Products"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _textEditingController,
                autocorrect: false,
                onSubmitted: (value) {
                  setState(() {
                    searchedProducts = ref
                        .watch(productsProvider.notifier)
                        .getSearchedProducts(value);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(IconManager.searhBarIcon),
                  suffixIcon: _textEditingController.text.isEmpty
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            _textEditingController.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: Icon(IconManager.clearSearchBarIcon),
                        ),
                  // suffixIconColor: Colors.red,
                  label: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      "Explore Products",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _textEditingController.text.isNotEmpty &&
                      searchedProducts.isEmpty
                  ? const Center(
                      child: Column(
                        children: [
                          Text("No Products Found!"),
                        ],
                      ),
                    )
                  : DynamicHeightGridView(
                      builder: (context, index) {
                        return ProductGridWidget(
                          product: _textEditingController.text.isEmpty
                              ? allProducts[index]
                              : searchedProducts[index],
                        );
                      },
                      itemCount: _textEditingController.text.isEmpty
                          ? allProducts.length
                          : searchedProducts.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
