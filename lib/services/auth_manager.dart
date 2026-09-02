import 'package:flutter/foundation.dart';
import 'local_storage.dart';
import '../models/user.dart';
import 'auth_api_service.dart';

class AuthManager {
  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);
  static String? authToken;
  static final LocalStorage storage = LocalStorage();

  static Future<void> login(User user, {String? token}) async {
    currentUser.value = user;

    if (token != null && token.isNotEmpty) {
      authToken = token;
      await storage.saveAuthToken(token);
    }
    await storage.saveUser(user);
  }

  static Future<void> restoreSession() async {
    final savedUser = await storage.loadUser();
    final savedToken = await storage.loadAuthToken();

    if (savedUser == null || savedToken == null || savedToken.isEmpty) {
      currentUser.value = null;
      authToken = null;
      return;
    }

    final result = await AuthApiService.checkLogin(token: savedToken);

    if (result == null) {
      currentUser.value = null;
      authToken = null;

      await storage.clearUser();
      await storage.clearAuthToken();
      return;
    }

    currentUser.value = savedUser;
    authToken = savedToken;
  }

  static Future<void> logout() async {
    final token = authToken;

    try {
      if (token != null && token.isNotEmpty) {
        final success = await AuthApiService.logout(token: token);

        if (!success) {
          debugPrint('logou server gagal');
        }
      }
    } catch (error) {
      debugPrint('Logout api error : $error');
    } finally {
      currentUser.value = null;
      authToken = null;

      await storage.clearUser();
      await storage.clearAuthToken();
    }
  }

  static bool get isLoggedIn {
    return currentUser.value != null &&
        authToken != null &&
        authToken!.isNotEmpty;
  }
}
