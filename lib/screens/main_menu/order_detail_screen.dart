// lib/screens/main_menu/order_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal
import '../../config/app_colors.dart';
import '../../models/order.dart';

// Catatan: Anda mungkin perlu menambahkan package intl ke pubspec.yaml jika belum ada:
// dependencies:
//   intl: ^0.18.1

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  // Fungsi Pembantu untuk Status dan Warna
  String _getStatusString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Menunggu Pembayaran';
      case OrderStatus.processed:
        return 'Diproses Penjual';
      case OrderStatus.shipped:
        return 'Sedang Dikirim';
      case OrderStatus.delivered:
        return 'Telah Diterima';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processed:
        return Colors.blue;
      case OrderStatus.shipped:
        return AppColors.primaryDark; // Orange
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format tanggal
    final formattedDate = DateFormat(
      'dd MMMM yyyy, HH:mm',
    ).format(order.orderDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan'), elevation: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Status Pesanan ---
            _buildStatusCard(),

            const SizedBox(height: 20),

            // --- Informasi Dasar Pesanan ---
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Tanggal Pesanan: $formattedDate',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
            const Divider(height: 30),

            // --- Daftar Item Pesanan ---
            const Text(
              'Item Dipesan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...order.productNames.map(
              (name) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '• $name',
                  style: const TextStyle(color: AppColors.text),
                ),
              ),
            ),

            const Divider(height: 30),

            // --- Detail Pengiriman (Dummy) ---
            const Text(
              'Detail Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Penerima', 'Bambang Sudiro'),
            _buildDetailRow(
              'Alamat',
              'Jl. Melati Indah No. 45, Jakarta Selatan',
            ),
            _buildDetailRow('Kurir', 'JNE Reguler'),
            _buildDetailRow(
              'No. Resi',
              order.status == OrderStatus.shipped ? 'JNE123456789' : '-',
            ),

            const Divider(height: 30),

            // --- Ringkasan Pembayaran ---
            const Text(
              'Ringkasan Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
              'Total Harga Barang',
              'Rp ${(order.totalAmount - 20000).toStringAsFixed(0)}',
            ), // Harga dummy
            _buildDetailRow('Ongkos Kirim', 'Rp 20.000'),
            _buildDetailRow(
              'Total Pembayaran',
              'Rp ${order.totalAmount.toStringAsFixed(0)}',
              isTotal: true,
            ),

            const SizedBox(height: 30),

            // --- Tombol Aksi ---
            if (order.status == OrderStatus.delivered)
              ElevatedButton(
                onPressed: () {
                  /* TODO: Logika Ulasan Produk */
                },
                child: const Text('BERI ULASAN'),
              ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Kartu Status
  Widget _buildStatusCard() {
    return Card(
      color: _getStatusColor(order.status).withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: _getStatusColor(order.status)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Status: ${_getStatusString(order.status)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(order.status),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Baris Detail
  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppColors.text : AppColors.secondaryText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.primaryDark : AppColors.text,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
