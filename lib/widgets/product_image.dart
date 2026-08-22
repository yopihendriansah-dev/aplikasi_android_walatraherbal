import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double? widht;
  final double? height;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.widht,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = widht ?? size;
    final imageHeight = height ?? size;
    if (imageUrl == null || imageUrl!.isEmpty) {
      return SizedBox(
        width: imageWidth,
        height: imageHeight,
        child: const CircleAvatar(child: Icon(Icons.shopping_bag_outlined)),
      );
    }
    return ClipRRect(
      borderRadius: .circular(12),
      child: Image.network(
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            width: size,
            height: size,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            ),
          );
        },
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: size,
            height: size,
            child: const ColoredBox(
              color: Colors.grey,
              child: Icon(Icons.broken_image_outlined),
            ),
          );
        },
      ),
    );
  }
}
