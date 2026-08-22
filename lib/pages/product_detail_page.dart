import 'package:flutter/material.dart';
import 'package:new1/widgets/app_button.dart';
import '../utils/currency_formatter.dart';
import '../models/product.dart';
import '../services/cart_manager.dart';
import '../widgets/product_image.dart';
import '../services/favorites_manager.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        actions: [
          ValueListenableBuilder(
            valueListenable: FavoritesManager.items,
            builder: (context, favorites, child) {
              final isFavorite = FavoritesManager.isFavorite(product);

              return IconButton(
                onPressed: () async {
                  await FavoritesManager.toggle(product);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            ProductImage(imageUrl: product.imageUrl, size: 160),
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
              CurrencyFormatter.format(product.price),
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
              child: AppButton(
                onPressed: () async {
                  await CartManager.add(product);
                  if (!context.mounted) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('${product.name} ditambahkan ke keranjang'),
                    ),
                  );
                },
                icon: Icons.shopping_cart_outlined,

                text: 'Tambah ke Keranjang',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
