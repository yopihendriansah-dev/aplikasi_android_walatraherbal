import 'package:flutter/foundation.dart';
import 'local_storage.dart';
import '../models/user.dart';

class AuthManager {
  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);

  static final LocalStorage storage = LocalStorage();

  static Future<void> login(User user) async {
    currentUser.value = user;
    await storage.saveUser(user);
  }

  static Future<void> restoreSession() async {
    currentUser.value = await storage.loadUser();
  }

  static Future<void> logout() async {
    currentUser.value = null;
    await storage.clearUser();
  }

  static bool get isLoggedIn {
    return currentUser.value != null;
  }
}
