// lib/screens/admin/manage_categories_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/product.dart'; // Import dummyCategories
import 'add_edit_category_screen.dart'; // Nanti kita buat

class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  // Gunakan state lokal agar dapat merefresh daftar kategori setelah menambah/menghapus
  List<Map<String, dynamic>> categories = dummyCategories;

  void _navigateToAddCategory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEditCategoryScreen()),
    ).then((_) {
      // Refresh daftar kategori setelah kembali dari form
      setState(() {
        // Dalam aplikasi sungguhan, Anda akan mengambil data dari Firestore di sini.
        categories = dummyCategories;
      });
    });
  }

  void _navigateToEditCategory(Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditCategoryScreen(category: category),
      ),
    ).then((_) {
      setState(() {
        categories = dummyCategories;
      });
    });
  }

  void _deleteCategory(String categoryName) {
    // TODO: Implementasi Logika Hapus dari Firestore
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kategori $categoryName dihapus! (Dummy Action)'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Kategori'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
      ),
      body: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(
              category['icon'] as IconData?,
              color: AppColors.primaryDark,
            ),
            title: Text(category['name'] as String),
            subtitle: Text(
              'Icon: ${category['icon'].toString().split('.').last}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _navigateToEditCategory(category),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCategory(category['name']),
                ),
              ],
            ),
            onTap: () => _navigateToEditCategory(category),
          );
        },
      ),
      // Tombol Tambah Kategori
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _navigateToAddCategory,
        child: const Icon(Icons.add, color: AppColors.buttonText),
      ),
    );
  }
}
