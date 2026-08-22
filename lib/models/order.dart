import 'cart_item.dart';
import 'product.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final String address;
  final String paymentMethod;
  final DateTime createdAt;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.createdAt,
    this.status = 'Diproses',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) {
        return {'productId': item.product.id, 'quantity': item.quantity};
      }).toList(),
      'total': total,
      'address': address,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json, List<Product> products) {
    final rawItems = json['items'] as List<dynamic>;

    final cartItems = rawItems.map((rawItem) {
      final itemData = rawItem as Map<String, dynamic>;

      final productId =
          (itemData['productId'] ?? itemData['product']) as String;
      final product = products.firstWhere((product) => product.id == productId);

      return CartItem(
        product: product,
        quantity: (itemData['quantity'] as num).toInt(),
      );
    }).toList();

    return Order(
      id: json['id'] as String,
      items: cartItems,
      total: (json['total'] as num).toDouble(),
      address: json['address'] as String,
      paymentMethod: json['paymentMethod'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: (json['status'] as String?) ?? 'Diproses',
    );
  }
}
