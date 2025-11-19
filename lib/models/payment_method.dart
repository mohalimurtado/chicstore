import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final bool isElectronic;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    this.isElectronic = true,
  });
}

final List<PaymentMethod> dummyPaymentMethods = [
  PaymentMethod(
    id: 'pm1',
    name: 'Transfer Bank (BCA/Mandiri)',
    icon: Icons.account_balance_outlined,
  ),
  PaymentMethod(
    id: 'pm2',
    name: 'COD (Bayar di Tempat)',
    icon: Icons.delivery_dining_outlined,
    isElectronic: false,
  ),
  PaymentMethod(id: 'pm3', name: 'QRIS', icon: Icons.qr_code_2_outlined),
  PaymentMethod(
    id: 'pm4',
    name: 'E-Wallet (DANA, OVO, ShopeePay)',
    icon: Icons.wallet_outlined,
  ),
];
