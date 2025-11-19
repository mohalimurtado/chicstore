// lib/screens/main_menu/wishlist_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <-- Import Provider
import '../../config/app_colors.dart';
import '../../models/product.dart';
import '../../providers/wishlist_provider.dart'; // <-- Import WishlistProvider
import '../product/product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer untuk mendapatkan data wishlist
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final favoriteProducts = wishlistProvider.favoriteProducts;

        return Scaffold(
          appBar: AppBar(title: const Text('Wishlist Saya'), elevation: 0),
          body: favoriteProducts.isEmpty
              ? const Center(
                  child: Text(
                    'Daftar keinginan Anda kosong.\nSilakan tambahkan produk favorit!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryText,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65, // Sesuaikan rasio
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    // Gunakan widget card yang sudah ada
                    return _buildProductCard(
                      context,
                      product,
                      wishlistProvider,
                    );
                  },
                ),
        );
      },
    );
  }

  // Widget Card Produk (Disesuaikan untuk Wishlist)
  Widget _buildProductCard(
    BuildContext context,
    Product product,
    WishlistProvider wishlist,
  ) {
    // ... (Logika dan tampilan card tetap sama)
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        // ... (tampilan Card)
        child: Stack(
          // Gunakan Stack untuk menempatkan tombol love
          children: [
            Column(
              // ... (Gambar, Nama, Harga, Tombol Beli)
            ),
            // Tombol Hapus/Love di kanan atas
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  // Langsung panggil toggleFavorite untuk menghapus
                  wishlist.toggleFavorite(product);
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.favorite,
                    size: 18,
                    color: AppColors.buttonText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
