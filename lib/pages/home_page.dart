import 'package:flutter/material.dart';
import 'package:new1/widgets/app_text_field.dart';
import '../models/product.dart';
import '../services/favorites_manager.dart';
import '../utils/currency_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  String searchQuery = '';
  String sortOption = 'Default';
  String selectedCategory = 'Semua';

  List<Product> get filteredProducts {
    final result = products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'Semua' || product.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    if (sortOption == 'Harga Terendah') {
      result.sort((a, b) => a.price.compareTo(b.price));
    }

    if (sortOption == 'Harga Tertinggi') {
      result.sort((a, b) => b.price.compareTo(a.price));
    }
    return result;
  }

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

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    await FavoritesManager.load(products);
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
            tooltip: 'Favorite',

            icon: const Icon(Icons.favorite_outline),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/orders');
            },
            tooltip: 'Riwayat Pesanan',

            icon: const Icon(Icons.history),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Keranjang',
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            tooltip: 'Profil',

            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              controller: searchController,
              hintText: 'Cari produk',
              prefixIcon: Icons.search,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              initialValue: sortOption,
              decoration: InputDecoration(
                labelText: 'Urutkan',
                prefixIcon: const Icon(Icons.sort),
                border: OutlineInputBorder(borderRadius: .circular(12)),
              ),
              items: const [
                DropdownMenuItem(value: 'Default', child: Text('Default')),
                DropdownMenuItem(
                  value: 'Harga Terendah',
                  child: Text('Harga Terendah'),
                ),
                DropdownMenuItem(
                  value: 'Harga Tertinggi',
                  child: Text('Harga Tertinggi'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  sortOption = value ?? 'Default';
                });
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Produk tidak ditemukan',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredProducts.length,

                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product-detail',
                              arguments: product,
                            );
                          },
                          leading: const CircleAvatar(
                            child: Icon(Icons.shopping_bag_outlined),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontWeight: .bold),
                          ),
                          subtitle: Text(product.category),
                          trailing: Row(
                            mainAxisSize: .min,
                            children: [
                              Text(
                                CurrencyFormatter.format(product.price),
                                style: const TextStyle(fontWeight: .bold),
                              ),

                              ValueListenableBuilder(
                                valueListenable: FavoritesManager.items,
                                builder: (context, favorites, child) {
                                  final isFavorite =
                                      FavoritesManager.isFavorite(product);

                                  return IconButton(
                                    onPressed: () async {
                                      FavoritesManager.toggle(product);
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : null,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
