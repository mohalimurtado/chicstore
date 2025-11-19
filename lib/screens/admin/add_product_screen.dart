// lib/screens/admin/add_product_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/app_colors.dart';
import '../../models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // State
  String? _selectedCategory;
  File? _imageFile;
  bool _isPopular = false;
  bool _isSaving = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // --- Fungsi Pilih Gambar ---
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // --- Fungsi Simpan Produk (tanpa Firebase Storage) ---
  void _saveProduct() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      setState(() {
        _isSaving = true; // mulai loading
      });

      try {
        // URL placeholder (dummy)
        const String imageUrl =
            'https://firebasestorage.googleapis.com/v0/b/chicstore-app.appspot.com/o/placeholders%2Fplaceholder.jpg?alt=media&token=c19e59a9-39b0-4592-9380-0a2a07c390a1';

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception("Admin belum login. Silakan login ulang.");
        }

        // Simpan ke Firestore
        await FirebaseFirestore.instance.collection('products').add({
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'description': _descController.text,
          'category': _selectedCategory,
          'isPopular': _isPopular,
          'imageUrl': imageUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'createdBy': user.uid,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_nameController.text} berhasil ditambahkan ke database!',
            ),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan produk: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk Baru'), elevation: 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImagePicker(),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _nameController,
                    label: 'Nama Produk',
                    icon: Icons.shopping_bag_outlined,
                    validatorMessage: 'Nama produk harus diisi',
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    controller: _priceController,
                    label: 'Harga (Rp)',
                    icon: Icons.money_outlined,
                    keyboardType: TextInputType.number,
                    validatorMessage: 'Harga harus diisi',
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _descController,
                    label: 'Deskripsi Produk',
                    icon: Icons.description_outlined,
                    maxLines: 5,
                    validatorMessage: 'Deskripsi harus diisi',
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('Tandai sebagai Produk Populer'),
                    value: _isPopular,
                    onChanged: (value) {
                      setState(() => _isPopular = value);
                    },
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveProduct,
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('SIMPAN PRODUK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Pembantu: Image Picker Area ---
  Widget _buildImagePicker() {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primaryDark.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: _imageFile == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 50,
                      color: AppColors.primaryDark,
                    ),
                    SizedBox(height: 8),
                    Text('Unggah Gambar Produk (Tap untuk memilih)'),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
      ),
    );
  }

  // --- Widget Pembantu: Dropdown Kategori ---
  Widget _buildCategoryDropdown() {
    final categoryNames = dummyCategories
        .map((c) => c['name'].toString())
        .toList();

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Kategori',
        prefixIcon: Icon(Icons.category_outlined),
      ),
      initialValue: _selectedCategory,
      hint: const Text('Pilih Kategori Produk'),
      items: categoryNames.map((String category) {
        return DropdownMenuItem<String>(value: category, child: Text(category));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kategori harus dipilih';
        }
        return null;
      },
    );
  }

  // --- Widget Pembantu: Input Field ---
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String validatorMessage,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        if (keyboardType == TextInputType.number &&
            double.tryParse(value) == null) {
          return 'Harus berupa angka yang valid';
        }
        return null;
      },
    );
  }
}
