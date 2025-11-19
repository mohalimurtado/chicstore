enum OrderStatus { pending, processed, shipped, delivered, cancelled }
class Order {
  final String id;
  final DateTime orderDate;
  final double totalAmount;
  final List<String> productNames;
  final OrderStatus status;
  final String paymentMethod; // ✅ Tambahan baru

  Order({
    required this.id,
    required this.orderDate,
    required this.totalAmount,
    required this.productNames,
    required this.paymentMethod, // ✅ Tambahkan ke constructor
    this.status = OrderStatus.pending,
  });
}

// ✅ Data dummy untuk laporan & testing
final List<Order> dummyOrders = [
  Order(
    id: 'ORD-2025001',
    orderDate: DateTime(2025, 11, 10),
    totalAmount: 185000,
    productNames: ['Kemeja Flanel Merah'],
    status: OrderStatus.delivered,
    paymentMethod: 'Transfer Bank', // ✅ Tambahkan metode pembayaran
  ),
  Order(
    id: 'ORD-2025002',
    orderDate: DateTime(2025, 11, 11),
    totalAmount: 99000 * 2,
    productNames: ['T-Shirt Oversize Hitam (2x)'],
    status: OrderStatus.shipped,
    paymentMethod: 'COD', // ✅ Contoh metode lain
  ),
  Order(
    id: 'ORD-2025003',
    orderDate: DateTime(2025, 11, 12),
    totalAmount: 350000,
    productNames: ['Jaket Denim Vintage'],
    status: OrderStatus.pending,
    paymentMethod: 'E-Wallet (Dana)', // ✅ Contoh tambahan
  ),
];
