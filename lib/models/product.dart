class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String? imageUrl;
  final List<String> imageUrls;
  final double rating;
  final int reviewCount;
  final int soldCount;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    this.imageUrl,
    this.imageUrls = const [],
    this.rating = 0,
    this.reviewCount = 0,
    this.soldCount = 0,
  });

  List<String> get galleryImages {
    final images = <String>[];
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      images.add(imageUrl!);
    }
    for (final image in imageUrls) {
      if (image.isNotEmpty && !images.contains(image)) {
        images.add(image);
      }
    }
    return images;
  }
}
