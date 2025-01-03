import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin_app/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  List<Product> getSearchedProducts(String searchQuery) {
    List<Product> searchedItems = state
        .where((product) => product.productTitle
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    List<Product> searchedInDesc = state
        .where((product) => product.productDescription
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    for (final item in searchedInDesc) {
      if (!searchedItems.contains(item)) {
        searchedItems.add(item);
      }
    }

    return searchedItems;
  }

  Future<List<Product>?> fetchProducts() async {
    try {
      final productDB = FirebaseFirestore.instance.collection("products");
      List<Product> products = [];
      await productDB.get().then((productSnapshot) {
        for (var element in productSnapshot.docs) {
          products.add(Product.fromFirebase(element));
        }
      });

      state = products;

      return state;
    } on FirebaseException catch (error) {
      print(error.message);
      return null;
    } catch (error) {
      return null;
    }
  }

  Stream<List<Product>>? fetchProdcutsAsStream() {
    try {
      final productDB = FirebaseFirestore.instance.collection("products");

      return productDB.snapshots().map((snapshot) {
        List<Product> products = [];
        for (var element in snapshot.docs) {
          products.add(Product.fromFirebase(element));
        }
        print("Stream emitted ${products.length} products");

        // state = products;
        return products;
      });
    } on FirebaseException catch (error) {
      print(error.message);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}

final productsProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});
