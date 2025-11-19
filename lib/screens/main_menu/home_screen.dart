import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart'; // <-- Tambahkan ini
import 'search_screen.dart';
import 'wishlist_screen.dart';
import '../product/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularProducts = dummyProducts.where((p) => p.isPopular).toList();
    final latestProducts = dummyProducts.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChicStore',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildPromoCarousel(context),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Telusuri Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ),
            _buildCategoriesGrid(),
            const SizedBox(height: 20),
            _buildProductSection(
              title: 'Produk Populer',
              products: popularProducts,
            ),
            const SizedBox(height: 20),
            _buildProductSection(
              title: 'Produk Terbaru',
              products: latestProducts,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCarousel(BuildContext context) {
    final List<String> imgList = [
      'https://placehold.co/600x200/FF9800/FFFFFF?text=FLASH+SALE+50%25',
      'https://placehold.co/600x200/FFA500/000000?text=Gratis+Ongkir',
      'https://placehold.co/600x200/FFC04D/000000?text=Diskon+Member+Baru',
    ];
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.5,
        viewportFraction: 0.9,
      ),
      items: imgList
          .map(
            (item) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(item),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCategoriesGrid() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: dummyCategories.length,
        itemBuilder: (context, index) {
          final category = dummyCategories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    category['icon'],
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  category['name'],
                  style: const TextStyle(fontSize: 12, color: AppColors.text),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductSection({
    required String title,
    required List<Product> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  // 🔥 Sudah Diperbarui: Tambahkan tombol Love (Wishlist)
  Widget _buildProductCard(BuildContext context, Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    height: 120,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        width: 150,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            cartProvider.addItem(product, 1);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.name} ditambahkan ke keranjang!',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Beli',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.buttonText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ❤️ Ikon Love (Wishlist Toggle)
            Positioned(
              top: 5,
              right: 5,
              child: Consumer<WishlistProvider>(
                builder: (context, wishlist, child) {
                  final isFavorite = wishlist.isFavorite(product);
                  return InkWell(
                    onTap: () {
                      wishlist.toggleFavorite(product);
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
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : AppColors.secondaryText,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
