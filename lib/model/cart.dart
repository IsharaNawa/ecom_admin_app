import 'package:ecom_admin_app/model/product.dart';

class Cart {
  Cart({required this.cartId, required this.product, required this.quantity});

  final String cartId;
  final Product product;
  final int quantity;

  set quantity(int value) {
    quantity = value;
  }
}
