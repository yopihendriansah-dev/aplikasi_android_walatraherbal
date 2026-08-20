import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_page.dart';
import 'cart_page.dart';
import '../utils/currency_formatter.dart';

class HomePage extends StatelessWidget {
  final List<Product> products = const [
    Product(
      id: 'p001',
      name: 'Sneakers Urban',
      category: 'Sepatu',
      price: 399000,
      description: 'Sepatu kasualuntuk aktivitas sehari-hari',
    ),
    Product(
      id: 'p002',
      name: 'Tas Selempang',
      category: 'Tas',
      price: 560000,
      description: 'Tas aktivitas sehari-hari',
    ),
    Product(
      id: 'p003',
      name: 'Jaket Denimi',
      category: 'Pakaian',
      price: 399000,
      description: 'Jaket untuk  aktivitas sehari-hari',
    ),
  ];
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Keluar",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Konfirmasi logout"),
                    content: const Text("Apakah kamu yakin ingin keluar?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: const Text("Keluar"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Keranjang',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,

        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
              leading: const CircleAvatar(
                child: Icon(Icons.shopping_bag_outlined),
              ),

              title: Text(product.name, style: TextStyle(fontWeight: .bold)),
              subtitle: Text(product.category),
              trailing: Text(
                CurrencyFormatter.format(product.price),
                style: const TextStyle(fontWeight: .bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
