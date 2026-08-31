import 'package:flutter/material.dart';
import 'package:new1/widgets/app_button.dart';
import '../utils/currency_formatter.dart';
import '../models/product.dart';
import '../services/cart_manager.dart';
import '../widgets/product_image.dart';
import '../services/favorites_manager.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController pageController = PageController();
  int currentImageIndex = 0;

  int quantity = 1;

  Product get product => widget.product;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity <= 1) {
      return;
    }
    setState(() {
      quantity--;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> buyNow() async {
    for (var i = 0; i < quantity; i++) {
      await CartManager.add(product);
    }
    if (!mounted) {
      return;
    }

    Navigator.pushNamed(context, '/checkout');
  }

  @override
  Widget build(BuildContext context) {
    final images = product.galleryImages;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        actions: [
          ValueListenableBuilder(
            valueListenable: FavoritesManager.items,
            builder: (context, favorites, child) {
              final isFavorite = FavoritesManager.isFavorite(widget.product);

              return IconButton(
                onPressed: () async {
                  await FavoritesManager.toggle(widget.product);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: pageController,
                        itemCount: images.isEmpty ? 1 : images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/image-viewer',
                                arguments: {
                                  'images': images,
                                  'initialIndex': index,
                                },
                              );
                            },
                            child: ProductImage(
                              imageUrl: images.isEmpty ? null : images[index],
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                      ),
                      if (images.length > 1)
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: Container(
                            padding: const .symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: .circular(16),
                            ),
                            child: Text(
                              '${currentImageIndex + 1}/${images.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (images.length > 1)
              Padding(
                padding: const .only(top: 12),
                child: Row(
                  mainAxisAlignment: .center,
                  children: List.generate(images.length, (index) {
                    final isActive = index == currentImageIndex;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const .symmetric(horizontal: 4),
                      width: isActive ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        borderRadius: .circular(8),
                      ),
                    );
                  }),
                ),
              ),
            const SizedBox(height: 24),
            Padding(
              padding: const .all(20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    widget.product.category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: .w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 26, fontWeight: .bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${product.rating}'),
                      const SizedBox(width: 8),
                      Text(
                        '${product.reviewCount} ulasan',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.soldCount} terjual',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        CurrencyFormatter.format(product.price),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: .bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Stok tersedia',
                    style: TextStyle(color: Colors.green, fontWeight: .w500),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(fontWeight: .bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            mainAxisSize: .min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jumlah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: decreaseQuantity,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: increaseQuantity,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Keranjang',
                      onPressed: () async {
                        for (var i = 0; i < quantity; i++) {
                          await CartManager.add(product);
                        }
                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Produk ditambahkan ke keranjang'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppButton(text: 'Beli Sekarang', onPressed: buyNow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
