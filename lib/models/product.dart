class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String? imageUrl;
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
    this.rating = 0,
    this.reviewCount = 0,
    this.soldCount = 0,
  });
}
