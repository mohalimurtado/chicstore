// lib/screens/admin/manage_orders_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/order.dart'; // Import model Order
import '../main_menu/order_detail_screen.dart'; // Re-use OrderDetailScreen

class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membagi data dummy (Dalam aplikasi nyata, ini dari Firestore)
    final pendingOrders = dummyOrders
        .where((o) => o.status == OrderStatus.pending)
        .toList();
    final processedOrders = dummyOrders
        .where((o) => o.status == OrderStatus.processed)
        .toList();
    final shippedOrders = dummyOrders
        .where((o) => o.status == OrderStatus.shipped)
        .toList();
    final deliveredOrders = dummyOrders
        .where((o) => o.status == OrderStatus.delivered)
        .toList();

    // Kita gabungkan Delivered dan Cancelled ke History untuk Admin
    final historyOrders =
        deliveredOrders +
        dummyOrders.where((o) => o.status == OrderStatus.cancelled).toList();

    return DefaultTabController(
      length: 4, // Pending, Processed, Shipped, History
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kelola Pesanan'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.buttonText,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.buttonText,
            labelColor: AppColors.buttonText,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Diproses'),
              Tab(text: 'Dikirim'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(
              context,
              pendingOrders,
              true,
            ), // Pending (bisa diproses)
            _buildOrderList(
              context,
              processedOrders,
              true,
            ), // Diproses (bisa dikirim)
            _buildOrderList(
              context,
              shippedOrders,
              true,
            ), // Dikirim (sudah selesai)
            _buildOrderList(
              context,
              historyOrders,
              false,
            ), // Riwayat (hanya lihat)
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Daftar Pesanan
  Widget _buildOrderList(
    BuildContext context,
    List<Order> orders,
    bool showActionButton,
  ) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada pesanan di kategori ini.',
          style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCardAdmin(context, order, showActionButton);
      },
    );
  }

  // Widget Pembantu: Kartu Pesanan Khusus Admin
  Widget _buildOrderCardAdmin(
    BuildContext context,
    Order order,
    bool showActionButton,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  label: Text(_getStatusString(order.status)),
                  backgroundColor: _getStatusColor(
                    order.status,
                  ).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _getStatusColor(order.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(),

            // Detail Ringkas
            ...order.productNames.map(
              (name) => Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Total: Rp ${order.totalAmount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),

            const SizedBox(height: 10),

            // --- Aksi Admin & Detail ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigasi ke OrderDetailScreen yang sudah ada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(order: order),
                      ),
                    );
                  },
                  child: const Text(
                    'Lihat Detail',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),

                if (showActionButton) _buildActionButton(context, order),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Tombol Aksi Sesuai Status
  Widget _buildActionButton(BuildContext context, Order order) {
    String text;
    VoidCallback onTap;
    Color color = AppColors.primary;

    if (order.status == OrderStatus.pending) {
      text = 'Proses Pesanan';
      onTap = () => _updateStatus(context, order, OrderStatus.processed);
    } else if (order.status == OrderStatus.processed) {
      text = 'Kirim Sekarang';
      color = Colors.green;
      onTap = () => _updateStatus(context, order, OrderStatus.shipped);
    } else {
      return const SizedBox.shrink(); // Jangan tampilkan tombol untuk status lain
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text),
    );
  }

  // Fungsi Dummy untuk Update Status
  void _updateStatus(BuildContext context, Order order, OrderStatus newStatus) {
    // TODO: Implementasi Logika Update Status di Cloud Firestore
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Status Order ${order.id} berhasil diupdate ke ${_getStatusString(newStatus)}! (Dummy)',
        ),
        backgroundColor: AppColors.primaryDark,
      ),
    );
    // Dalam aplikasi nyata: panggil setState atau provider untuk merefresh daftar
  }

  // Fungsi Pembantu Status (diambil dari model/order.dart jika di-refactor)
  String _getStatusString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processed:
        return 'Diproses';
      case OrderStatus.shipped:
        return 'Dikirim';
      case OrderStatus.delivered:
        return 'Diterima';
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
        return AppColors.primaryDark;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
