import 'package:flutter/material.dart';

import '../services/favorites_manager.dart';
import '../utils/currency_formatter.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),
      body: ValueListenableBuilder(
        valueListenable: FavoritesManager.items,
        builder: (context, favorites, child) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'Belm ada produk favorit',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product-detail',
                      arguments: product,
                    );
                  },
                  leading: const CircleAvatar(
                    child: Icon(Icons.shopping_bag_outlined),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: .bold),
                  ),
                  subtitle: Text(product.category),
                  trailing: Row(
                    mainAxisSize: .min,
                    children: [
                      Text(
                        CurrencyFormatter.format(product.price),
                        style: TextStyle(fontWeight: .bold),
                      ),
                      IconButton(
                        onPressed: () async {
                          FavoritesManager.toggle(product);
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    ],
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
