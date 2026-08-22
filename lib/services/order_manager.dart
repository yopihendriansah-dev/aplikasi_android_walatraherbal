import 'package:flutter/foundation.dart';

import '../models/order.dart';
import '../models/product.dart';
import 'local_storage.dart';

class OrderManager {
  static final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>(
    [],
  );

  static final LocalStorage storage = LocalStorage();

  static Future<void> load(List<Product> products) async {
    final saveOrders = await storage.loadOrder(products);
    orders.value = saveOrders;
  }

  static Future<void> add(Order order) async {
    orders.value = [...orders.value, order];

    await save();
  }

  static Future<void> save() async {
    await storage.saveOrders(orders.value);
  }

  static Future<void> clear() async {
    orders.value = [];
    await storage.clearOrders();
  }
}
