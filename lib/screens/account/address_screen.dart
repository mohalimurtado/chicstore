import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/address.dart';
import 'add_edit_address_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  // Data dummy alamat
  List<Address> get addresses => dummyAddresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Pengiriman'), elevation: 1),
      body: addresses.isEmpty
          ? const Center(
              child: Text(
                'Anda belum memiliki alamat tersimpan.',
                style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _buildAddressCard(context, address);
              },
            ),

      // Tombol Tambah Alamat
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            // Navigasi ke form tambah alamat (tanpa data existing)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditAddressScreen(),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('TAMBAH ALAMAT BARU'),
        ),
      ),
    );
  }

  // Widget kartu alamat
  Widget _buildAddressCard(BuildContext context, Address address) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Nama + Chip utama
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.recipientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.text,
                  ),
                ),
                if (address.isDefault)
                  Chip(
                    label: const Text(
                      'Utama',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.buttonText,
                      ),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
              ],
            ),
            const SizedBox(height: 5),

            // Nomor telepon
            Text(
              address.phoneNumber,
              style: const TextStyle(color: AppColors.secondaryText),
            ),

            const Divider(height: 15),

            // Alamat lengkap
            Text(
              '${address.street}, ${address.city}, ${address.postalCode}',
              style: const TextStyle(color: AppColors.text),
            ),

            // Tombol Edit Alamat (DIPERBARUI)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Edit Alamat'),
                onPressed: () {
                  // Navigasi ke Form Tambah/Edit Alamat (mode EDIT)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditAddressScreen(
                        existingAddress: address, // Kirim objek alamat ke form
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
