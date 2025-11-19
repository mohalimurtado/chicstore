// lib/screens/main_menu/categories_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'products_by_category_screen.dart'; // <-- Pastikan file ini sudah ada

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // Data kategori statis
  static const List<Map<String, dynamic>> allCategories = [
    {'name': 'Baju Wanita', 'icon': Icons.woman_outlined},
    {'name': 'Baju Pria', 'icon': Icons.man_outlined},
    {'name': 'Baju Anak', 'icon': Icons.child_care_outlined},
    {'name': 'Outerwear (Jaket, Hoodie)', 'icon': Icons.checkroom_outlined},
    {'name': 'Kaos', 'icon': Icons.style},
    {'name': 'Kemeja', 'icon': Icons.inventory_2_outlined},
    {'name': 'Celana', 'icon': Icons.inventory_2}, // ikon aman untuk "celana"
    {'name': 'Aksesoris', 'icon': Icons.watch_outlined},
    {'name': 'Sepatu', 'icon': Icons.directions_run_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Produk'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: allCategories.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          return ListTile(
            leading: Icon(
              category['icon'] as IconData,
              color: AppColors.primary,
            ),
            title: Text(
              category['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
            ),
            onTap: () {
              // Ambil nama kategori
              final categoryName = category['name'] as String;

              // Navigasi ke layar daftar produk per kategori
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsByCategoryScreen(categoryName: categoryName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
