// lib/screens/main_menu/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <-- Import Provider
import '../../config/app_colors.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart'; // <-- Import CartProvider

class CartScreen extends StatelessWidget {
  // <-- Ganti menjadi StatelessWidget
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca CartProvider
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja'), elevation: 0),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Keranjang Anda kosong!',
                style: TextStyle(fontSize: 18, color: AppColors.secondaryText),
              ),
            )
          : Column(
              children: [
                Expanded(
                  // Menggunakan Consumer jika Anda ingin membatasi rebuild
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return _buildCartItemCard(context, item, cart);
                        },
                      );
                    },
                  ),
                ),
                _buildCartSummary(
                  context,
                  cartProvider,
                ), // Kirim provider ke summary
              ],
            ),
    );
  }

  // ... (Widget lainnya)

  // Widget untuk menampilkan satu item di keranjang
  Widget _buildCartItemCard(
    BuildContext context,
    CartItem item,
    CartProvider cart,
  ) {
    return Card(
      // ... (kode tampilan card)
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // ... (Gambar dan Detail Produk)

            // Kontrol Kuantitas & Hapus
            Column(
              children: [
                // Tombol Hapus
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () =>
                      cart.removeItem(item.product.id), // <-- Panggil Provider
                ),
                // Kontrol Kuantitas
                Row(
                  children: [
                    InkWell(
                      onTap: () => cart.updateQuantity(
                        item.product.id,
                        item.quantity - 1,
                      ), // <-- Panggil Provider
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    // ... (Tampilan kuantitas)
                    InkWell(
                      onTap: () => cart.updateQuantity(
                        item.product.id,
                        item.quantity + 1,
                      ), // <-- Panggil Provider
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Ringkasan Keranjang
  Widget _buildCartSummary(BuildContext context, CartProvider cart) {
    // Gunakan Consumer di sini agar hanya Summary yang rebuild saat total berubah
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Harga:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'Rp ${cart.totalCartPrice.toStringAsFixed(0)}', // <-- Ambil dari Provider
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (cart.items.isNotEmpty) {
                    // TODO: Navigasi ke Halaman Checkout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menuju halaman Checkout...'),
                      ),
                    );
                  }
                },
                child: const Text('CHECKOUT (LANJUTKAN KE PEMBAYARAN)'),
              ),
            ],
          ),
        );
      },
    );
  }
}
