import 'package:flutter/material.dart';
import '../services/order_manager.dart';
import '../utils/currency_formatter.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pesanan')),
      body: ValueListenableBuilder(
        valueListenable: OrderManager.orders,
        builder: (context, orders, child) {
          if (orders.isEmpty) {
            return const Center(
              child: Text('Belum ada pesanan', style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final formattedDate = DateFormat(
                'dd MM yyyy, HH;mm',
                'id_ID',
              ).format(order.createdAt);

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/order-detail',
                        arguments: order,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Pesanan #${order.id}',
                            style: const TextStyle(fontWeight: .bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Dibuat: $formattedDate',
                            style: const TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 8),
                          Chip(
                            avatar: const Icon(Icons.access_time, size: 18),
                            label: Text(order.status),
                          ),
                          const SizedBox(height: 8),

                          Text('${order.items.length} jenis produk'),

                          const SizedBox(height: 8),
                          Text('Pembayaran: ${order.paymentMethod}'),
                          const SizedBox(height: 8),
                          Text('Alamat: ${order.address}'),

                          const SizedBox(height: 12),
                          Text(
                            CurrencyFormatter.format(order.total),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: .bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
