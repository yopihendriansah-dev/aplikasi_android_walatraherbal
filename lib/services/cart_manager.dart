import 'package:flutter/widgets.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartManager {
  static final ValueNotifier<List<CartItem>> items =
      ValueNotifier<List<CartItem>>([]);

  static void add(Product product) {
    final updatedItems = [...items.value];

    final existingIndex = updatedItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      updatedItems[existingIndex].quantity++;
    } else {
      updatedItems.add(CartItem(product: product));
    }
    items.value = updatedItems;
  }

  static void removeAt(int index) {
    if (index < 0 || index >= items.value.length) {
      return;
    }

    final updatedItems = [...items.value];
    updatedItems.removeAt(index);
    items.value = updatedItems;
  }

  static void increaseQuantity(int index) {
    if (index < 0 || index >= items.value.length) {
      return;
    }
    final updatedItems = [...items.value];
    updatedItems[index].quantity++;
    items.value = updatedItems;
  }

  static void descreaseQuantity(int index) {
    if (index < 0 || index >= items.value.length) {
      return;
    }
    final updatedItems = [...items.value];
    final item = updatedItems[index];

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      updatedItems.removeAt(index);
    }
    items.value = updatedItems;
  }

  static void clear() {
    items.value = [];
  }
}
