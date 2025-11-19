// lib/screens/admin/admin_dashboard_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'add_product_screen.dart';
import 'manage_categories_screen.dart';
import 'manage_orders_screen.dart';
import 'manage_users_screen.dart';
import 'sales_reports_screen.dart'; // ✅ Import layar laporan penjualan

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Data Dummy Statistik ---
    const totalSales = 1850000.0;
    const totalUsers = 450;
    const totalProducts = 25;
    const bestSeller = 'Jaket Denim Vintage';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: AppColors.buttonText),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.buttonText),
            onPressed: () {
              // TODO: Tambahkan logika logout admin di sini
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Bisnis ChicStore',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const Divider(height: 20),

            // --- D.1.1: Statistik Bisnis ---
            _buildMetricGrid(totalSales, totalUsers, totalProducts, bestSeller),

            const SizedBox(height: 30),

            // --- D.1.2: Placeholder Grafik ---
            const Text(
              'Grafik Penjualan Bulanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSalesChartPlaceholder(),

            const SizedBox(height: 30),

            // --- Menu Cepat Aksi ---
            const Text(
              'Menu Kelola Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // D.2 Tambah Produk
            _buildActionCard(
              context,
              icon: Icons.add_box_outlined,
              title: 'Tambah Produk',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              },
            ),

            // D.3 Kelola Kategori
            _buildActionCard(
              context,
              icon: Icons.dashboard_outlined,
              title: 'Kelola Kategori',
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageCategoriesScreen(),
                  ),
                );
              },
            ),

            // D.4 Kelola Pesanan
            _buildActionCard(
              context,
              icon: Icons.list_alt,
              title: 'Kelola Pesanan',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageOrdersScreen(),
                  ),
                );
              },
            ),

            // D.5 Kelola Pengguna
            _buildActionCard(
              context,
              icon: Icons.people_alt_outlined,
              title: 'Kelola Pengguna (D.5)',
              color: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageUsersScreen(),
                  ),
                );
              },
            ),

            // ✅ D.6 Laporan Penjualan
            _buildActionCard(
              context,
              icon: Icons.receipt_long_outlined,
              title: 'Laporan Penjualan (D.6)',
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesReportsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Pembantu: Grid Statistik ---
  Widget _buildMetricGrid(
    double sales,
    int users,
    int products,
    String bestSeller,
  ) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMetricCard(
          'Total Penjualan',
          'Rp ${sales.toStringAsFixed(0)}',
          Icons.payments,
          Colors.green,
        ),
        _buildMetricCard(
          'Total Pengguna',
          users.toString(),
          Icons.people_alt,
          Colors.deepOrange,
        ),
        _buildMetricCard(
          'Produk Terlaris',
          bestSeller,
          Icons.star,
          Colors.blue,
        ),
        _buildMetricCard(
          'Total Produk',
          products.toString(),
          Icons.inventory_2,
          Colors.purple,
        ),
      ],
    );
  }

  // --- Widget Pembantu: Kartu Statistik ---
  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Pembantu: Placeholder Grafik ---
  Widget _buildSalesChartPlaceholder() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.secondaryText.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.bar_chart, size: 40, color: AppColors.secondaryText),
            SizedBox(height: 8),
            Text(
              'Placeholder Grafik Penjualan',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Pembantu: Kartu Aksi ---
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      color: color.withOpacity(0.9),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: AppColors.buttonText),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
