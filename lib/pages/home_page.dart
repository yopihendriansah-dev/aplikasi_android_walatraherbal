import 'package:flutter/material.dart';
import 'package:new1/services/order_manager.dart';
import 'package:new1/widgets/app_text_field.dart';
import '../models/product.dart';
import '../services/favorites_manager.dart';
import '../services/cart_manager.dart';
import '../widgets/product_card.dart';

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
      imageUrl:
          'https://www.happystore.id/_next/image?url=https%3A%2F%2Fcf.shopee.co.id%2Ffile%2Fid-11134207-7rasb-m13kkvtth7vs38&w=1200&q=75',
      rating: 4.8,
      reviewCount: 120,
      soldCount: 20,
    ),
    Product(
      id: 'p002',
      name: 'Tas Selempang',
      category: 'Tas',
      price: 560000,
      description: 'Tas aktivitas sehari-hari',
      rating: 4.8,
      reviewCount: 122,
      soldCount: 28,
    ),
    Product(
      id: 'p003',
      name: 'Jaket Denimi',
      category: 'Pakaian',
      price: 399000,
      description: 'Jaket untuk  aktivitas sehari-hari',
      rating: 4.0,
      reviewCount: 120,
      soldCount: 40,
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    await Future.wait([
      FavoritesManager.load(products),
      CartManager.load(products),
      OrderManager.load(products),
    ]);

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
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final columnCount = constraints.maxWidth >= 900
                          ? 4
                          : constraints.maxWidth >= 900
                          ? 3
                          : 2;
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.60,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ValueListenableBuilder(
                            valueListenable: FavoritesManager.items,
                            builder: (context, value, child) {
                              return ProductCard(
                                product: product,
                                isFavorite: FavoritesManager.isFavorite(
                                  product,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/product-detail',
                                    arguments: product,
                                  );
                                },
                                onFavoritePressed: () async {
                                  await FavoritesManager.toggle(product);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
