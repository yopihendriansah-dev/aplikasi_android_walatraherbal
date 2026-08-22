import 'package:flutter/material.dart';

import '../services/favorites_manager.dart';

import '../widgets/product_card.dart';

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
              return ProductCard(
                product: product,
                isFavorite: true,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product-detail',
                    arguments: product,
                  );
                },
                onFavoritePressed: () async {
                  await FavoritesManager.toggle(product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
