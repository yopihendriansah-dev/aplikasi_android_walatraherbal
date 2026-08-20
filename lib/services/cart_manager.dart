import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartManager {
  static final ValueNotifier<List<Product>> items =
      ValueNotifier<List<Product>>([]);

  static void add(Product product) {
    items.value = [...items.value, product];
  }

  static void removeAt(int index) {
    if (index < 0 || index >= items.value.length) {
      return;
    }

    final updateItems = [...items.value];
    updateItems.removeAt(index);
    items.value = updateItems;
  }

  static void clear() {
    items.value = [];
  }
}
