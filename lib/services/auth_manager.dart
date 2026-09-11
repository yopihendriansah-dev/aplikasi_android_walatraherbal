import 'package:flutter/foundation.dart';
import 'local_storage.dart';
import '../models/user.dart';
import '../models/auth_session.dart';
import 'auth_api_service.dart';

class AuthManager {
  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);
  static String? authToken;
  static bool requiresProfileCompletion = false;
  static final LocalStorage storage = LocalStorage();

  static Future<void> login(User user, {String? token}) async {
    currentUser.value = user;

    if (token != null && token.isNotEmpty) {
      authToken = token;
      await storage.saveAuthToken(token);
    }
    await storage.saveUser(user);
  }

  static Future<void> saveSession(AuthSession session) async {
    currentUser.value = session.user;
    authToken = session.token;
    requiresProfileCompletion = session.requiresProfileCompletion;
    await storage.saveUser(session.user);
    await storage.saveAuthToken(session.token);
    await storage.saveProfileCompletionRequirement(requiresProfileCompletion);
  }

  static Future<void> updateCurrentUser(User user) async {
    currentUser.value = user;
    requiresProfileCompletion = false;
    await storage.saveUser(user);
    await storage.saveProfileCompletionRequirement(false);
  }

  static Future<void> restoreSession() async {
    final savedUser = await storage.loadUser();
    final savedToken = await storage.loadAuthToken();
    final savedProfileRequirement = await storage
        .loadProfileCompletionRequirement();

    if (savedUser == null || savedToken == null || savedToken.isEmpty) {
      currentUser.value = null;
      authToken = null;
      requiresProfileCompletion = false;
      return;
    }

    try {
      final user = await AuthApiService.getCurrentUser(token: savedToken);
      currentUser.value = user;
      authToken = savedToken;
      requiresProfileCompletion =
          savedProfileRequirement ?? user.name.trim().isEmpty;
    } on ApiException catch (error) {
      if (error.statusCode != 401 && error.statusCode != 403) {
        currentUser.value = savedUser;
        authToken = savedToken;
        requiresProfileCompletion =
            savedProfileRequirement ?? savedUser.name.trim().isEmpty;
        return;
      }
      currentUser.value = null;
      authToken = null;

      await storage.clearUser();
      await storage.clearAuthToken();
      await storage.clearProfileCompletionRequirement();
    } catch (_) {
      // Gangguan jaringan sementara tidak langsung menghapus sesi lokal.
      currentUser.value = savedUser;
      authToken = savedToken;
      requiresProfileCompletion =
          savedProfileRequirement ?? savedUser.name.trim().isEmpty;
    }
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
      requiresProfileCompletion = false;

      await storage.clearUser();
      await storage.clearAuthToken();
      await storage.clearProfileCompletionRequirement();
    }
  }

  static bool get isLoggedIn {
    return currentUser.value != null &&
        authToken != null &&
        authToken!.isNotEmpty;
  }
}
