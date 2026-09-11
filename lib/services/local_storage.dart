import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/order.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../models/address.dart';

class LocalStorage {
  static const favoriteIdsKey = 'favorite_product_ids';
  static const orderKey = 'orders';
  static const userKey = 'current_user';
  static const authTokenKey = 'auth_token';
  static const profileCompletionKey = 'requires_profile_completion';
  static const addressKey = 'addresses';

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

  Future<void> saveOrders(List<Order> ordres) async {
    final jsonData = jsonEncode(ordres.map((order) => order.toJson()).toList());

    await prefreences.setString(orderKey, jsonData);
  }

  Future<List<Order>> loadOrder(List<Product> products) async {
    final jsonData = await prefreences.getString(orderKey);
    if (jsonData == null) {
      return [];
    }

    final decodedData = jsonDecode(jsonData) as List<dynamic>;
    return decodedData.map((item) {
      return Order.fromJson(item as Map<String, dynamic>, products);
    }).toList();
  }

  Future<void> clearOrders() async {
    await prefreences.remove(orderKey);
  }

  Future<void> saveUser(User user) async {
    final jsonData = jsonEncode(user.toJson());

    await prefreences.setString(userKey, jsonData);
  }

  Future<User?> loadUser() async {
    final jsonData = await prefreences.getString(userKey);

    if (jsonData == null) {
      return null;
    }

    final decodedData = jsonDecode(jsonData) as Map<String, dynamic>;
    return User.fromJson(decodedData);
  }

  Future<void> clearUser() async {
    await prefreences.remove(userKey);
  }

  Future<void> saveAddresses(List<Address> addresses) async {
    final jsonData = jsonEncode(
      addresses.map((address) => address.toJson()).toList(),
    );
    await prefreences.setString(addressKey, jsonData);
  }

  Future<List<Address>> loadAddresses() async {
    final jsonData = await prefreences.getString(addressKey);
    if (jsonData == null) {
      return [];
    }

    final decodedData = jsonDecode(jsonData) as List<dynamic>;

    return decodedData.map((item) {
      return Address.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  Future<void> clearAddress() async {
    await prefreences.remove(addressKey);
  }

  Future<void> saveAuthToken(String token) async {
    await prefreences.setString(authTokenKey, token);
  }

  Future<String?> loadAuthToken() async {
    return await prefreences.getString(authTokenKey);
  }

  Future<void> clearAuthToken() async {
    await prefreences.remove(authTokenKey);
  }

  Future<void> saveProfileCompletionRequirement(bool required) async {
    await prefreences.setBool(profileCompletionKey, required);
  }

  Future<bool?> loadProfileCompletionRequirement() async {
    return await prefreences.getBool(profileCompletionKey);
  }

  Future<void> clearProfileCompletionRequirement() async {
    await prefreences.remove(profileCompletionKey);
  }
}
