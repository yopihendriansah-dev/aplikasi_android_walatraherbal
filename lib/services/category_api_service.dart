import 'dart:convert';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class CategoryApiService {
  static String get endpoint => '${ApiConfig.legacyApiUrl}/kategori';

  static Future<List<String>> fetchCategories() async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('gagal mengambil data kategori');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (json['success'] != true || json['status'] != 'success') {
      throw Exception('Response kategori tidak berhasil');
    }
    final rawaData = json['data'];
    if (rawaData is! List) {
      throw Exception('Format data kategori tidak valid');
    }

    final categories = <String>[];

    for (final item in rawaData) {
      if (item is String && item.trim().isNotEmpty) {
        categories.add(item.trim());
        continue;
      }

      if (item is Map<String, dynamic>) {
        final categoryName =
            item['name'] ??
            item['nama'] ??
            item['category'] ??
            item['kateogry'] ??
            item['realname'];

        if (categoryName is String && categoryName.trim().isNotEmpty) {
          categories.add(categoryName.trim());
        }
      }
    }
    return categories.toSet().toList();
  }
}
