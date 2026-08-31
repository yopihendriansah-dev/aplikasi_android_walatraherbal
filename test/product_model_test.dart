import 'package:flutter_test/flutter_test.dart';
import 'package:new1/models/product.dart';

void main() {
  test('Single image otomatis menjadi gallery satu gambar', () {
    const product = Product(
      id: 'p001',
      name: 'Produk Test',
      category: 'Test',
      price: 10000,
      description: 'Deskripsi test',
      imageUrl: 'https://contoh.com/gambar.webp',
    );

    expect(product.galleryImages, ['https://contoh.com/gambar.webp']);
  });

  test('Multiple image menggunakan imageUrls', () {
    const product = Product(
      id: 'p002',
      name: 'Produk Test',
      category: 'Test',
      price: 10000,
      description: 'Deskripsi test',
      imageUrls: [
        'https://contoh.com/gambar-1.webp',
        'https://contoh.com/gambar-2.webp',
      ],
    );

    expect(product.galleryImages.length, 2);
  });
}
