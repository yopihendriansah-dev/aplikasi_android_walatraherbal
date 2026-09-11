import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/auth_session.dart';
import '../models/otp_challenge.dart';
import '../models/user.dart';
import '../utils/phone_formatter.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final int? retryAfter;

  const ApiException(this.message, {this.statusCode = 0, this.retryAfter});

  @override
  String toString() => message;
}

class AuthApiService {
  static Uri _uri(String path) => Uri.parse('${ApiConfig.apiUrl}$path');

  static Map<String, String> _headers({String? token}) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Map<String, dynamic> _decode(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
    } on FormatException {
      // Fall through to a safe, user-facing error.
    }
    throw ApiException(
      'Respons server tidak valid',
      statusCode: response.statusCode,
    );
  }

  static Never _throwForStatus(http.Response response) {
    final json = _decode(response);
    final retryAfter = json['retry_after'];
    throw ApiException(
      json['message'] as String? ?? _defaultMessage(response.statusCode),
      statusCode: response.statusCode,
      retryAfter: retryAfter is num ? retryAfter.toInt() : null,
    );
  }

  static String _defaultMessage(int statusCode) {
    switch (statusCode) {
      case 401:
        return 'Sesi login tidak valid atau sudah berakhir';
      case 403:
        return 'Akun tidak aktif';
      case 422:
        return 'Data yang dikirim tidak valid';
      case 429:
        return 'Terlalu banyak percobaan. Silakan tunggu sebentar';
      case 503:
        return 'Layanan OTP sedang tidak tersedia';
      default:
        return 'Server sedang bermasalah, silakan coba lagi nanti';
    }
  }

  static Future<OtpChallenge> requestOtp(String inputPhone) async {
    final phone = PhoneFormatter.normalize(inputPhone);
    final response = await http.post(
      _uri('/auth/customer/request-otp'),
      headers: _headers(),
      body: jsonEncode({'phone': phone}),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _throwForStatus(response);
    }

    final json = _decode(response);
    final data = json['data'];
    if (json['success'] != true || data is! Map<String, dynamic>) {
      throw ApiException(
        json['message'] as String? ?? 'OTP tidak dapat dikirim',
      );
    }
    return OtpChallenge.fromJson(data, phone: phone);
  }

  static Future<AuthSession> verifyOtp({
    required String phone,
    required int challengeId,
    required String otp,
    required String deviceName,
  }) async {
    final response = await http.post(
      _uri('/auth/customer/verify-otp'),
      headers: _headers(),
      body: jsonEncode({
        'phone': phone,
        'challenge_id': challengeId,
        'otp': otp,
        'device_name': deviceName,
      }),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _throwForStatus(response);
    }

    final json = _decode(response);
    final data = json['data'];
    if (json['success'] != true || data is! Map<String, dynamic>) {
      throw ApiException(json['message'] as String? ?? 'Kode OTP tidak valid');
    }
    return AuthSession.fromJson(data);
  }

  static Future<User> getCurrentUser({required String token}) async {
    final response = await http.get(
      _uri('/auth/me'),
      headers: _headers(token: token),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _throwForStatus(response);
    }
    final json = _decode(response);
    final data = json['data'];
    final user = data is Map<String, dynamic> ? data['user'] : null;
    if (json['success'] != true || user is! Map<String, dynamic>) {
      throw ApiException('Data pengguna tidak ditemukan');
    }
    return User.fromJson(user);
  }

  static Future<User> updateProfile({
    required String token,
    required String name,
  }) async {
    final response = await http.patch(
      _uri('/auth/customer/profile'),
      headers: _headers(token: token),
      body: jsonEncode({'name': name}),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _throwForStatus(response);
    }
    final json = _decode(response);
    final data = json['data'];
    final user = data is Map<String, dynamic> ? data['user'] : null;
    if (json['success'] != true || user is! Map<String, dynamic>) {
      throw ApiException(
        json['message'] as String? ?? 'Profil gagal diperbarui',
      );
    }
    return User.fromJson(user);
  }

  static Future<bool> logout({required String token}) async {
    final response = await http.post(
      _uri('/auth/logout'),
      headers: _headers(token: token),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _throwForStatus(response);
    }
    final json = _decode(response);
    return json['success'] == true;
  }
}
