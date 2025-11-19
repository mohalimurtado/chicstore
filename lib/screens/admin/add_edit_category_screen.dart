// lib/screens/admin/add_edit_category_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final Map<String, dynamic>?
  category; // Data kategori untuk mode Edit (opsional)

  const AddEditCategoryScreen({super.key, this.category});

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController =
      TextEditingController(); // Untuk input nama ikon

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      // Mode Edit: Isi form dengan data yang ada
      _nameController.text = widget.category!['name'] as String;
      // Mengubah objek IconData menjadi string untuk ditampilkan di Text Field
      _iconController.text = widget.category!['icon']
          .toString()
          .split('.')
          .last;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.category != null;
      final action = isEditing ? 'diperbarui' : 'ditambahkan';

      // TODO: Logika Simpan/Update Kategori ke Cloud Firestore
      // Catatan: Ikon di sini harus diubah kembali menjadi IconData jika disimpan di Firestore/database

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kategori "${_nameController.text}" berhasil $action!'),
          backgroundColor: AppColors.primary,
        ),
      );
      Navigator.pop(context); // Kembali ke ManageCategoriesScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.category != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Kategori' : 'Tambah Kategori Baru'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Nama Kategori ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kategori (Contoh: Baju Wanita)',
                  prefixIcon: Icon(Icons.label_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama kategori harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // --- Nama Ikon (Sederhana) ---
              TextFormField(
                controller: _iconController,
                decoration: const InputDecoration(
                  labelText: 'Nama Ikon (Contoh: woman_outlined)',
                  prefixIcon: Icon(Icons.palette_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ikon harus diisi (gunakan nama ikon Material)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // --- Tombol Simpan ---
              ElevatedButton(
                onPressed: _saveCategory,
                child: Text(isEditing ? 'SIMPAN PERUBAHAN' : 'TAMBAH KATEGORI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
