// lib/screens/main_menu/products_by_category_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/product.dart'; // Pastikan model Product dan dummyProducts sudah ada
import '../product/product_detail_screen.dart'; // <-- Halaman detail produk

class ProductsByCategoryScreen extends StatelessWidget {
  final String categoryName;

  const ProductsByCategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan nama kategori
    final filteredProducts = dummyProducts
        .where((p) => p.category == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName), elevation: 1),
      body: filteredProducts.isEmpty
          ? Center(
              child: Text(
                'Tidak ada produk ditemukan di kategori "$categoryName" saat ini.',
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                childAspectRatio: 0.7, // Ukuran proporsional card produk
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductPlaceholderCard(context, product);
              },
            ),
    );
  }

  // Widget Card Produk Placeholder — sudah diberi navigasi ke detail produk
  Widget _buildProductPlaceholderCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        // NAVIGASI KE DETAIL PRODUK
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Image.network(
              product.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Nama produk
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            // Harga produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Rp ${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
