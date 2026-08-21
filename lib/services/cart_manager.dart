import 'package:flutter/widgets.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

import 'local_storage.dart';

class CartManager {
  static final ValueNotifier<List<CartItem>> items =
      ValueNotifier<List<CartItem>>([]);

  static final LocalStorage storage = LocalStorage();
  static Future<void> load(List<Product> products) async {
    final savedQuantities = await storage.loadCartItems();

    items.value = products
        .where((product) {
          return savedQuantities.containsKey(product.id);
        })
        .map((product) {
          return CartItem(
            product: product,
            quantity: savedQuantities[product.id]!,
          );
        })
        .toList();
  }

  static Future<void> add(Product product) async {
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
    await save();
  }

  static Future<void> increaseQuantity(int index) async {
    if (index < 0 || index >= items.value.length) {
      return;
    }

    final updatedItems = [...items.value];
    updatedItems[index].quantity++;

    items.value = updatedItems;
    await save();
  }

  static Future<void> decreaseQuantity(int index) async {
    if (index < 0 || index >= items.value.length) {
      return;
    }

    final updateItems = [...items.value];
    final item = updateItems[index];

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      updateItems.removeAt(index);
    }

    items.value = updateItems;
    await save();
  }

  static Future<void> removeAt(int index) async {
    if (index < 0 || index >= items.value.length) {
      return;
    }

    final updatedItems = [...items.value];
    updatedItems.removeAt(index);

    items.value = updatedItems;
    await save();
  }

  static Future<void> clear() async {
    items.value = [];
    await storage.clearCartItems();
  }

  static Future<void> save() async {
    final quantities = <String, int>{
      for (final item in items.value) item.product.id: item.quantity,
    };
    await storage.saveCartItems(quantities);
  }
}
