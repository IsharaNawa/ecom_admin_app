import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecom_admin_app/model/product.dart';

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super(Product.products);

  List<Product> getSearchedProducts(String searchQuery) {
    List<Product> searchedItems = state
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

final productsProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});
