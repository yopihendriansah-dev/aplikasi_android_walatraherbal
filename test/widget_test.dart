// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:new1/main.dart';

void main() {
  testWidgets('Login page tampil dengan benar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.text('Selamat datang'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Lupa password?'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);
  });

  testWidgets('Validasi muncul ketika login kosong', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Email wajib diisi'), findsOneWidget);
  });

  testWidgets('Tombol Daftar membuka halaman pendaftaran', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Buat akun baru'), findsOneWidget);
  });

  testWidgets('Validasi pendaftaran kosong', (WidgetTester teseter) async {
    await teseter.pumpWidget(const MyApp());

    await teseter.tap(find.text('Daftar'));
    await teseter.pumpAndSettle();

    await teseter.tap(find.text('Daftar'));
    await teseter.pump();

    expect(find.text('Nama wajib diisi'), findsOneWidget);
  });
}
