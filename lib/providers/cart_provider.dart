// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // Gunakan list internal untuk menyimpan item
  final List<CartItem> _items = dummyCartItems; // Mulai dengan dummy data

  // Getter (untuk dibaca oleh UI)
  List<CartItem> get items => _items;

  // Total Harga
  double get totalCartPrice {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  // Menambahkan Item ke Keranjang
  void addItem(Product product, [int quantity = 1]) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners(); // Beri tahu UI bahwa data telah berubah
  }

  // Mengubah Kuantitas
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity < 1) {
      removeItem(productId); // Hapus jika kuantitas kurang dari 1
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    if (itemIndex != -1) {
      _items[itemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Menghapus Item dari Keranjang
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Mengosongkan Keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
