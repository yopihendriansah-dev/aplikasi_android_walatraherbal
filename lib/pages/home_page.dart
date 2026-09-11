import 'package:flutter/material.dart';
import 'package:new1/services/order_manager.dart';
import 'dart:async';
import '../models/product.dart';
import '../services/favorites_manager.dart';
import '../services/cart_manager.dart';
import '../services/auth_api_service.dart';
import '../widgets/product_card.dart';
import '../widgets/catalog_toolbar.dart';
import '../data/product_repository.dart';
import '../widgets/app_button.dart';
import '../widgets/promo_banner.dart';
import '../services/auth_manager.dart';

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

  final scrollController = ScrollController();
  final List<Product> loadedProducts = [];

  int currentPage = 1;
  bool isInitialLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;
  String? errorMessage;
  String? loadMoreError;
  static const pageSize = 20;

  Timer? searchDebounce;

  List<Product> get filteredProducts => loadedProducts;

  final products = ProductRepository.products;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    loadSavedData();
    loadFirstPage();
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

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300) {
      loadNextPage();
    }
  }

  Future<void> loadFirstPage() async {
    try {
      final firstPage = await ProductRepository.fetchProducts(
        page: 1,
        limit: pageSize,
        query: searchQuery,
        category: selectedCategory,
        sortOption: sortOption,
      );
      if (!mounted) {
        return;
      }

      setState(() {
        loadedProducts
          ..clear()
          ..addAll(firstPage);

        currentPage = 1;
        hasMore = firstPage.length == pageSize;
        isInitialLoading = false;
        errorMessage = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialLoading = false;
        errorMessage = 'Gagal memuat produk';
      });
    }
  }

  Future<void> loadNextPage() async {
    if (isLoadingMore || !hasMore) {
      return;
    }

    setState(() {
      isLoadingMore = true;
      loadMoreError = null;
    });

    final nextPage = currentPage + 1;

    try {
      final newProducts = await ProductRepository.fetchProducts(
        page: nextPage,
        limit: pageSize,
        query: searchQuery,
        category: selectedCategory,
        sortOption: sortOption,
      );
      if (!mounted) {
        return;
      }

      setState(() {
        loadedProducts.addAll(newProducts);
        currentPage = nextPage;
        isLoadingMore = false;
        hasMore = newProducts.length == pageSize;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoadingMore = false;
        loadMoreError = 'Gagal memuat produk berikutnya';
      });
    }
  }

  @override
  void dispose() {
    searchDebounce?.cancel();
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void showFilterSheet() {
    // final categories = [
    //   'Semua',
    //   ...products.map((product) => product.category).toSet(),
    // ];

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const Text(
                    'Filter dan Urutkan',
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Urutkan berdasarkan',
                    style: TextStyle(fontWeight: .bold),
                  ),
                  RadioGroup<String>(
                    groupValue: sortOption,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        sortOption = value;
                      });

                      Navigator.pop(context);
                      resetProducts();
                    },
                    child: Column(
                      children: [
                        const RadioListTile<String>(
                          contentPadding: .zero,
                          title: Text('Default'),
                          value: 'Default',
                        ),
                        const RadioListTile<String>(
                          contentPadding: .zero,
                          title: Text('Harga Terendah'),
                          value: 'Harga Terendah',
                        ),
                        const RadioListTile<String>(
                          contentPadding: .zero,
                          title: Text('Harga Tertinggi'),
                          value: 'Harga Tertinggi',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> testLoginCheck() async {
    final token = AuthManager.authToken;

    if (token == null || token.isEmpty) {
      debugPrint('Token autentikasi tidak tersedia');
      return;
    }

    try {
      final user = await AuthApiService.getCurrentUser(token: token);
      debugPrint('LOGIN CHECK SUCCESS: ${user.id}');
    } on ApiException catch (error) {
      debugPrint('LOGIN CHECK FAILED: ${error.statusCode}');
    }
  }

  List<String> get categories {
    return ['Semua', ...products.map((product) => product.category).toSet()];
  }

  Future<void> resetProducts() async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    if (!mounted) {
      return;
    }

    setState(() {
      loadedProducts.clear();
      currentPage = 1;
      hasMore = true;
      isInitialLoading = true;
      isLoadingMore = false;
      errorMessage = null;
      loadMoreError = null;
    });
    await loadFirstPage();
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
          IconButton(
            onPressed: testLoginCheck,
            tooltip: 'Tes',

            icon: const Icon(Icons.text_snippet),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          // Banner Promo
          const SliverToBoxAdapter(child: PromoBanner()),

          if (AuthManager.requiresProfileCompletion)
            SliverToBoxAdapter(child: _ProfileCompletionBanner(context)),

          // Katalog
          SliverToBoxAdapter(
            child: CatalogToolbar(
              searchController: searchController,
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                searchDebounce?.cancel();
                searchDebounce = Timer(const Duration(milliseconds: 400), () {
                  resetProducts();
                });
              },

              onFilterPressed: showFilterSheet,
              onClearSearch: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
                searchDebounce?.cancel();
                resetProducts();
              },
            ),
          ),

          // Kategori
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const .symmetric(horizontal: 16),
                scrollDirection: .horizontal,

                itemBuilder: (context, index) {
                  final category = categories[index];

                  return ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (sleected) {
                      setState(() {
                        selectedCategory = category;
                      });
                      resetProducts();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8);
                },
                itemCount: categories.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          if (!isInitialLoading)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menampilkan ${filteredProducts.length} produk',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
            ),

          // Daftar Produk
          if (isInitialLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 56,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        text: 'Coba lagi',
                        icon: Icons.refresh,
                        onPressed: loadFirstPage,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (filteredProducts.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  searchQuery.trim().isEmpty
                      ? 'Produk tidak ditemukan'
                      : 'Produk "$searchQuery" tidak ditemukan',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.crossAxisExtent;

                final columnCount = width >= 900
                    ? 4
                    : width >= 600
                    ? 3
                    : 2;

                return SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.55,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= filteredProducts.length) {
                          if (isLoadingMore) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return AppButton(
                            text: 'Coba lagi',
                            icon: Icons.refresh,
                            onPressed: loadNextPage,
                          );
                        }

                        final product = filteredProducts[index];

                        return ValueListenableBuilder(
                          valueListenable: FavoritesManager.items,
                          builder: (context, value, child) {
                            return ProductCard(
                              product: product,
                              isFavorite: FavoritesManager.isFavorite(product),
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
                      childCount:
                          filteredProducts.length +
                          ((isLoadingMore || loadMoreError != null) ? 1 : 0),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ProfileCompletionBanner extends StatelessWidget {
  final BuildContext parentContext;

  const _ProfileCompletionBanner(this.parentContext);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lengkapi profil Anda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tambahkan nama agar pengalaman belanja lebih personal.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(parentContext, '/edit-profile');
                },
                child: const Text('Lengkapi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
