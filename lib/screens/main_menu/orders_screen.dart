import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/order.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeOrders = dummyOrders
        .where(
          (o) =>
              o.status != OrderStatus.delivered &&
              o.status != OrderStatus.cancelled,
        )
        .toList();
    final historyOrders = dummyOrders
        .where(
          (o) =>
              o.status == OrderStatus.delivered ||
              o.status == OrderStatus.cancelled,
        )
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan Saya'),
          elevation: 1,
          bottom: const TabBar(
            indicatorColor: AppColors.primaryDark,
            labelColor: AppColors.primaryDark,
            unselectedLabelColor: AppColors.secondaryText,
            tabs: [
              Tab(text: 'Pesanan Aktif'),
              Tab(text: 'Riwayat Pesanan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(activeOrders),
            _buildOrderList(historyOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
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
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ID Pesanan dan Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  _getStatusString(order.status),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Daftar produk dalam pesanan
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
            // Total harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Tombol Lihat Detail (Diperbarui)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigasi ke Detail Pesanan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(order: order),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Detail',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
