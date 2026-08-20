import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/cart_manager.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const CircleAvatar(
              radius: 48,
              child: Icon(Icons.shopping_bag_outlined, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              product.name,
              style: const TextStyle(fontSize: 28, fontWeight: .bold),
            ),
            const SizedBox(height: 8),

            Text(
              product.category,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(height: 16),
            Text(
              'Rp ${product.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 22, fontWeight: .bold),
            ),
            const SizedBox(height: 24),

            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  CartManager.add(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} ditambahkan ke keranjang'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(fontSize: 16, fontWeight: .bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
