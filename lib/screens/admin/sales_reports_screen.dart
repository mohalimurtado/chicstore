// lib/screens/admin/sales_reports_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/app_colors.dart';
import '../../models/order.dart'; // Menggunakan model Order untuk data transaksi

class SalesReportsScreen extends StatefulWidget {
  const SalesReportsScreen({super.key});

  @override
  State<SalesReportsScreen> createState() => _SalesReportsScreenState();
}

class _SalesReportsScreenState extends State<SalesReportsScreen> {
  // State untuk Filter Tanggal
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isGenerating = false;

  // Data Dummy Laporan
  final List<Order> _transactions = dummyOrders
      .where((o) => o.status == OrderStatus.delivered)
      .toList();
  final double _totalRevenue = dummyOrders
      .where((o) => o.status == OrderStatus.delivered)
      .fold(0.0, (sum, item) => sum + item.totalAmount);
  final int _totalOrders = dummyOrders
      .where((o) => o.status == OrderStatus.delivered)
      .length;

  // Format tanggal dan mata uang
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  // Fungsi untuk memilih rentang tanggal
  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now().subtract(const Duration(days: 7)),
        end: _endDate ?? DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.buttonText,
              onSurface: AppColors.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _generateReport(); // Panggil generate report setelah tanggal dipilih
    }
  }

  // Fungsi Dummy Generate Laporan
  void _generateReport() {
    setState(() {
      _isGenerating = true;
    });

    // Simulasi pengambilan data dari Firestore berdasarkan _startDate dan _endDate
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isGenerating = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Laporan Penjualan (${_dateFormat.format(_startDate!)} - ${_dateFormat.format(_endDate!)}) berhasil dimuat!',
            ),
            backgroundColor: AppColors.primaryDark,
          ),
        );
        // Di sini seharusnya Anda memfilter _transactions berdasarkan tanggal
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Default: Laporan 7 hari terakhir
    _endDate = DateTime.now();
    _startDate = _endDate!.subtract(const Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan Penjualan',
          style: TextStyle(color: AppColors.buttonText),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 1. Filter Tanggal & Export ---
            _buildDateFilterRow(context),

            const SizedBox(height: 25),

            // --- 2. Ringkasan Laporan ---
            _isGenerating
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : _buildReportSummary(),

            const SizedBox(height: 25),

            // --- 3. Tabel Detail Transaksi ---
            const Text(
              'Detail Transaksi Selesai',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTransactionTable(),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Filter Tanggal
  Widget _buildDateFilterRow(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rentang Tanggal:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_dateFormat.format(_startDate!)} - ${_dateFormat.format(_endDate!)}',
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () => _pickDateRange(context),
              icon: const Icon(Icons.date_range),
              label: const Text('Pilih Tanggal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
              ),
            ),
            // Tombol Export (Opsional)
            IconButton(
              icon: const Icon(Icons.download, color: Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengekspor laporan ke CSV... (Dummy)'),
                  ),
                );
              },
              tooltip: 'Export ke CSV',
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Ringkasan Laporan
  Widget _buildReportSummary() {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryRow(
              'Total Pendapatan',
              _currencyFormat.format(_totalRevenue),
              Colors.green,
            ),
            const Divider(),
            _buildSummaryRow(
              'Total Pesanan',
              _totalOrders.toString(),
              AppColors.primaryDark,
            ),
            const Divider(),
            _buildSummaryRow(
              'Pesanan Rata-Rata',
              _currencyFormat.format(_totalRevenue / _totalOrders),
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu: Baris Ringkasan
  Widget _buildSummaryRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.secondaryText,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu: Tabel Transaksi
  Widget _buildTransactionTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text(
              'ID Order',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Tanggal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Metode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: _transactions.map((order) {
          return DataRow(
            cells: [
              DataCell(Text(order.id.substring(0, 7))),
              DataCell(Text(_dateFormat.format(order.orderDate))),
              DataCell(Text(_currencyFormat.format(order.totalAmount))),
              DataCell(Text(order.paymentMethod)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
