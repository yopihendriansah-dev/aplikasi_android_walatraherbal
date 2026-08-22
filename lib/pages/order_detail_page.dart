import 'package:flutter/material.dart';
import '../widgets/product_image.dart';
import '../models/order.dart';
import '../utils/currency_formatter.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;
  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesanan #${order.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Chip(
            avatar: const Icon(Icons.access_time, size: 18),
            label: Text(order.status),
          ),

          const SizedBox(height: 16),
          const Text(
            'Daftar Produk',
            style: TextStyle(fontSize: 20, fontWeight: .bold),
          ),
          const SizedBox(height: 16),
          ...order.items.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: ProductImage(imageUrl: item.product.imageUrl),
                title: Text(
                  '${item.quantity} x '
                  '${CurrencyFormatter.format(item.product.price)}',
                ),
                trailing: Text(
                  CurrencyFormatter.format(item.totalPrice),
                  style: const TextStyle(fontWeight: .bold),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Text('Metode Pembayaran: ${order.paymentMethod}'),
          const SizedBox(height: 8),
          Text('Alamat Pengiriman: ${order.address}'),
          const SizedBox(height: 16),
          Text(
            'Total: ${CurrencyFormatter.format(order.total)}',
            style: const TextStyle(fontSize: 20, fontWeight: .bold),
          ),
        ],
      ),
    );
  }
}
