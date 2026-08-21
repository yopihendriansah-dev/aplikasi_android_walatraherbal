import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../services/cart_manager.dart';
import '../utils/currency_formatter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: ValueListenableBuilder(
        valueListenable: CartManager.items,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang masih kosong',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final total = items.fold<double>(
            0,
            (sum, item) => sum + item.totalPrice,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final product = item.product;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.shopping_bag_outlined),
                        ),
                        title: Text(product.name),
                        subtitle: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Text(CurrencyFormatter.format(product.price)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await CartManager.decreaseQuantity(
                                          index,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),

                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontWeight: .bold),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await CartManager.increaseQuantity(
                                          index,
                                        );
                                      },
                                      icon: Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await CartManager.removeAt(index);
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 18, fontWeight: .bold),
                        ),
                        Text(
                          CurrencyFormatter.format(total),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: AppButton(
                        text: 'Checkout',
                        icon: Icons.shopping_cart_checkout,
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
