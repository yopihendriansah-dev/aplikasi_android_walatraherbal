import 'package:flutter/foundation.dart';

import '../models/order.dart';

class OrderManager {
  static final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>(
    [],
  );
  static void add(Order order) {
    orders.value = [...orders.value, order];
  }

  static void clear() {
    orders.value = [];
  }
}
