import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/payment_method.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metode Pembayaran'), elevation: 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMethodSection(
              context,
              'Pembayaran Elektronik',
              dummyPaymentMethods.where((m) => m.isElectronic).toList(),
            ),
            const Divider(height: 1),
            _buildMethodSection(
              context,
              'Pembayaran Non-Elektronik',
              dummyPaymentMethods.where((m) => !m.isElectronic).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodSection(
    BuildContext context,
    String title,
    List<PaymentMethod> methods,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryText,
            ),
          ),
        ),
        ...methods.map((method) => _buildPaymentTile(context, method)),
      ],
    );
  }

  Widget _buildPaymentTile(BuildContext context, PaymentMethod method) {
    return ListTile(
      leading: Icon(method.icon, color: AppColors.primary),
      title: Text(method.name, style: const TextStyle(color: AppColors.text)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.secondaryText),
      onTap: () {
        // TODO: Navigasi ke Detail Konfigurasi Metode Pembayaran
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Memilih/Konfigurasi ${method.name}')),
        );
      },
    );
  }
}
