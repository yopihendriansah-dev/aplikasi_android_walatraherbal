import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final String address;
  final String paymentMethod;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.createdAt,
  });
}
