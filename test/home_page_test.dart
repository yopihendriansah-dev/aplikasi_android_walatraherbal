import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new1/pages/home_page.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  testWidgets('Home page menampilkan produk', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Menunggu proses loadProducts selama 800 ms.
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Cari produk'), findsOneWidget);
    expect(find.text('Essence Mascara Lash Princess'), findsOneWidget);
  });

  testWidgets('Pencarian jam menampilkan produk jam tangan', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Tunggu data awal.
    await tester.pump(const Duration(milliseconds: 900));

    await tester.enterText(find.byType(TextField), 'jam');

    // Tunggu debounce 400 ms.
    await tester.pump(const Duration(milliseconds: 500));

    // Tunggu proses fetchProducts 800 ms.
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Brown Leather Belt Watch'), findsOneWidget);
    expect(find.text('Longines Master Collection'), findsOneWidget);
  });

  testWidgets('Pencarian produk tidak ditemukan', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.pump(const Duration(milliseconds: 900));

    await tester.enterText(find.byType(TextField), 'produk-tidak-ada');

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 900));

    expect(
      find.text('Produk "produk-tidak-ada" tidak ditemukan'),
      findsOneWidget,
    );
  });

  testWidgets('Filter harga terendah menampilkan produk termurah', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.pump(const Duration(milliseconds: 900));

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    expect(find.text('Harga Terendah'), findsOneWidget);

    await tester.tap(find.text('Harga Terendah'));

    // Menunggu proses reset dan fetch data.
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Lemon'), findsOneWidget);
  });

  testWidgets('Filter harga tertinggi menampilkan produk termahal', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.pump(const Duration(milliseconds: 900));

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    expect(find.text('Harga Tertinggi'), findsOneWidget);

    await tester.tap(find.text('Harga Tertinggi'));

    // Menunggu proses reset dan fetch data.
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Rolex Submariner Watch'), findsOneWidget);
  });
}
