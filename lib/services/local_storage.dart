import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static const favoriteIdsKey = 'favorite_product_ids';

  final SharedPreferencesAsync prefreences = SharedPreferencesAsync();

  Future<void> saveFavoriteIds(List<String> ids) async {
    await prefreences.setStringList(favoriteIdsKey, ids);
  }

  Future<List<String>> loadFavoriteIds() async {
    return await prefreences.getStringList(favoriteIdsKey) ?? [];
  }

  Future<void> clearFavoriteIds() async {
    await prefreences.remove(favoriteIdsKey);
  }

  static const cartItemsKey = 'cart_items';
  Future<void> saveCartItems(Map<String, int> quantities) async {
    final jsonData = jsonEncode(quantities);

    await prefreences.setString(cartItemsKey, jsonData);
  }

  Future<Map<String, int>> loadCartItems() async {
    final jsonData = await prefreences.getString(cartItemsKey);
    if (jsonData == null) {
      return {};
    }

    final decodedData = jsonDecode(jsonData) as Map<String, dynamic>;

    return decodedData.map((key, value) {
      return MapEntry(key, (value as num).toInt());
    });
  }

  Future<void> clearCartItems() async {
    await prefreences.remove(cartItemsKey);
  }
}
