import 'package:flutter/foundation.dart';

import '../models/product.dart';
import 'local_storage.dart';

class FavoritesManager {
  static final ValueNotifier<List<Product>> items =
      ValueNotifier<List<Product>>([]);

  static final LocalStorage storage = LocalStorage();

  static Future<void> load(List<Product> products) async {
    final saveIds = await storage.loadFavoriteIds();

    items.value = products
        .where((product) => saveIds.contains(product.id))
        .toList();
  }

  static bool isFavorite(Product product) {
    return items.value.any((item) => item.id == product.id);
  }

  static Future<void> toggle(Product product) async {
    final updatedItems = [...items.value];

    final existingIndex = updatedItems.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingIndex >= 0) {
      updatedItems.removeAt(existingIndex);
    } else {
      updatedItems.add(product);
    }

    items.value = updatedItems;

    await storage.saveFavoriteIds(updatedItems.map((item) => item.id).toList());
  }

  static Future<void> clear() async {
    items.value = [];
    await storage.clearFavoriteIds();
  }
}
