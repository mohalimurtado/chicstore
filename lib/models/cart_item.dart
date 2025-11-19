import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

final List<CartItem> dummyCartItems = [
  CartItem(product: dummyProducts[0], quantity: 2),
  CartItem(product: dummyProducts[2], quantity: 1),
];
