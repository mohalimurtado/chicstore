// lib/screens/product/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart'; // ✅ Tambahkan import ini

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar dengan ikon Love dinamis
      appBar: AppBar(
        title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        elevation: 0,
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              final isFavorite = wishlistProvider.isFavorite(product);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : AppColors.text,
                ),
                onPressed: () {
                  wishlistProvider.toggleFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? '${product.name} dihapus dari wishlist'
                            : '${product.name} ditambahkan ke wishlist',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Harga dan Nama Produk
            Text(
              'Rp ${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Divider(height: 30),

            // Deskripsi Produk
            const Text(
              'Deskripsi Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 15),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                Text(
                  '${product.rating} (${product.reviewCount} ulasan)',
                  style: const TextStyle(color: AppColors.secondaryText),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Pilihan Ukuran
            const Text(
              'Pilih Ukuran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: product.sizes
                  .map((size) => Chip(label: Text(size)))
                  .toList(),
            ),
          ],
        ),
      ),

      // ✅ Tombol Tambah ke Keranjang
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            final cartProvider = Provider.of<CartProvider>(
              context,
              listen: false,
            );
            cartProvider.addItem(product, 1);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} ditambahkan ke keranjang!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart_outlined),
          label: const Text('TAMBAH KE KERANJANG'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
