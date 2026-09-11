import 'user.dart';

class AuthSession {
  final User user;
  final String token;
  final String tokenType;
  final bool isNewUser;
  final bool requiresProfileCompletion;

  const AuthSession({
    required this.user,
    required this.token,
    required this.tokenType,
    required this.isNewUser,
    required this.requiresProfileCompletion,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String?;
    final rawUser = json['user'];
    if (token == null || token.isEmpty || rawUser is! Map<String, dynamic>) {
      throw const FormatException('Data sesi login tidak lengkap');
    }
    return AuthSession(
      user: User.fromJson(rawUser),
      token: token,
      tokenType: json['token_type'] as String? ?? 'Bearer',
      isNewUser: json['is_new_user'] as bool? ?? false,
      requiresProfileCompletion:
          json['requires_profile_completion'] as bool? ?? false,
    );
  }
}
