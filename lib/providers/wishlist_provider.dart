import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecom_admin_app/model/product.dart';

class WishListNotifier extends StateNotifier<List<Product>> {
  WishListNotifier() : super([]);

  void addToWishList(Product product) {
    if (!isProductExitsInWishList(product)) {
      state = [product, ...state];
    }
  }

  bool isProductExitsInWishList(Product product) {
    return state.contains(product);
  }

  void clearWishList() {
    state = [];
  }
}

final wishListProvider =
    StateNotifierProvider<WishListNotifier, List<Product>>((ref) {
  return WishListNotifier();
});
