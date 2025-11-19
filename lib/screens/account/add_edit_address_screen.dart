// lib/screens/account/add_edit_address_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/address.dart'; // Import model Address

class AddEditAddressScreen extends StatefulWidget {
  final Address? existingAddress; // Objek Alamat yang ada (null jika Tambah)

  const AddEditAddressScreen({super.key, this.existingAddress});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk input data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();

  bool _isDefault = false; // Status Alamat Utama

  @override
  void initState() {
    super.initState();
    // Jika ada alamat yang dikirim, isi controller (Mode Edit)
    if (widget.existingAddress != null) {
      final address = widget.existingAddress!;
      _nameController.text = address.recipientName;
      _phoneController.text = address.phoneNumber;
      _streetController.text = address.street;
      _cityController.text = address.city;
      _postalController.text = address.postalCode;
      _isDefault = address.isDefault;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.existingAddress != null;

      // TODO: Logika penyimpanan/pembaruan alamat ke Cloud Firestore/data lokal

      final action = isEditing ? 'diperbarui' : 'ditambahkan';

      // Tampilkan notifikasi sukses dan kembali
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Alamat untuk ${_nameController.text} berhasil $action!',
          ),
          backgroundColor: AppColors.primaryDark,
        ),
      );

      // Kembali ke AddressScreen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingAddress != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Alamat' : 'Tambah Alamat Baru'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField(
                controller: _nameController,
                label: 'Nama Penerima',
                icon: Icons.person_outline,
                validatorMessage: 'Nama penerima harus diisi',
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _phoneController,
                label: 'Nomor Telepon',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validatorMessage: 'Nomor telepon harus diisi',
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: _streetController,
                label: 'Jalan/Blok/Nomor Rumah',
                icon: Icons.home_outlined,
                maxLines: 3,
                validatorMessage: 'Detail jalan harus diisi',
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _cityController,
                label: 'Kota/Kabupaten',
                icon: Icons.location_city_outlined,
                validatorMessage: 'Kota harus diisi',
              ),
              const SizedBox(height: 15),
              _buildInputField(
                controller: _postalController,
                label: 'Kode Pos',
                icon: Icons.markunread_mailbox_outlined,
                keyboardType: TextInputType.number,
                validatorMessage: 'Kode pos harus diisi',
              ),
              const SizedBox(height: 20),

              // --- Set Alamat Utama (Is Default) ---
              SwitchListTile(
                title: const Text('Tetapkan sebagai Alamat Utama'),
                value: _isDefault,
                onChanged: (bool value) {
                  setState(() {
                    _isDefault = value;
                  });
                },
                activeThumbColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
      // --- Tombol Simpan ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _saveAddress,
          child: Text(isEditing ? 'SIMPAN PERUBAHAN' : 'TAMBAH ALAMAT'),
        ),
      ),
    );
  }

  // Widget Pembantu untuk Input Field
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
        return null;
      },
    );
  }
}
