import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecom_admin_app/model/product.dart';

class CategoryProductNotifier extends StateNotifier<List<Product>> {
  CategoryProductNotifier() : super(Product.products);

  List<Product> getCategoryProducts(String category) {
    return state
        .where((product) => product.productCategory == category)
        .toList();
  }

  List<Product> getCategorySearchedProducts(
      String searchQuery, String category) {
    List<Product> searchedItems = getCategoryProducts(category)
        .where((product) => product.productTitle
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    searchedItems.addAll(state
        .where((product) => product.productDescription
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList());

    return searchedItems;
  }
}

final categoryProductsProvider =
    StateNotifierProvider<CategoryProductNotifier, List<Product>>((ref) {
  return CategoryProductNotifier();
});
