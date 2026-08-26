import 'package:flutter_test/flutter_test.dart';
import 'package:new1/data/product_repository.dart';

void main() {
  test('Harga terendah berada di urutan pertama', () async {
    final result = await ProductRepository.fetchProducts(
      page: 1,
      limit: 20,
      sortOption: 'Harga Terendah',
    );

    expect(result, isNotEmpty);

    for (var i = 0; i < result.length - 1; i++) {
      expect(result[i].price <= result[i + 1].price, isTrue);
    }
  });

  test('Harga tertinggi berada di urutan pertama', () async {
    final result = await ProductRepository.fetchProducts(
      page: 1,
      limit: 20,
      sortOption: 'Harga Tertinggi',
    );

    expect(result, isNotEmpty);

    for (var i = 0; i < result.length - 1; i++) {
      expect(result[i].price >= result[i + 1].price, isTrue);
    }
  });

  test('Pencarian kategori jam tangan berhasil', () async {
    final result = await ProductRepository.fetchProducts(
      page: 1,
      limit: 20,
      query: 'jam',
    );

    expect(result, isNotEmpty);

    for (final product in result) {
      final searchableText =
          '''
        ${product.name}
        ${product.category}
        ${product.description}
      '''
              .toLowerCase();

      expect(searchableText.contains('jam'), isTrue);
    }
  });

  test('Pagination mengembalikan jumlah produk sesuai limit', () async {
    final firstPage = await ProductRepository.fetchProducts(page: 1, limit: 20);

    final secondPage = await ProductRepository.fetchProducts(
      page: 2,
      limit: 20,
    );

    expect(firstPage.length, 20);
    expect(secondPage.length, 20);

    final firstIds = firstPage.map((product) => product.id).toSet();
    final secondIds = secondPage.map((product) => product.id).toSet();

    expect(firstIds.intersection(secondIds), isEmpty);
  });
}
