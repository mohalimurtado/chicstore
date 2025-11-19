// lib/providers/wishlist_provider.dart

import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  // Menggunakan Set untuk penyimpanan yang efisien (menghindari duplikasi)
  final Set<String> _productIds = {}; // Hanya menyimpan ID produk

  // Getter: Mendapatkan list produk favorit (dengan mencocokkan ID ke dummyProducts)
  List<Product> get favoriteProducts {
    return dummyProducts
        .where((product) => _productIds.contains(product.id))
        .toList();
  }

  // Getter: Untuk memeriksa apakah suatu produk ada di wishlist
  bool isFavorite(Product product) {
    return _productIds.contains(product.id);
  }

  // Menambah atau Menghapus produk dari wishlist
  void toggleFavorite(Product product) {
    if (_productIds.contains(product.id)) {
      _productIds.remove(product.id); // Hapus
    } else {
      _productIds.add(product.id); // Tambah
    }
    notifyListeners(); // Beri tahu UI bahwa status favorit telah berubah
  }

  // Mengosongkan Wishlist (Opsional)
  void clearWishlist() {
    _productIds.clear();
    notifyListeners();
  }
}
