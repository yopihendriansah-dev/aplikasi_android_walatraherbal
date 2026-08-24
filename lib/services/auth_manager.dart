import 'package:flutter/foundation.dart';

import '../models/user.dart';

class AuthManager {
  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);

  static void login(User user) {
    currentUser.value = user;
  }

  static void logout() {
    currentUser.value = null;
  }

  static bool get isLoggedIn {
    return currentUser.value != null;
  }
}
