import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double? width;
  final double? height;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = width ?? size;
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
        imageUrl!,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: imageWidth,
            height: imageHeight,
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
