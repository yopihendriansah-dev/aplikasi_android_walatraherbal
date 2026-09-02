import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/phone_formatter.dart';

class OtpRequestResult {
  final String phoneNumber;
  final String otpPair;

  const OtpRequestResult({required this.phoneNumber, required this.otpPair});
}

class AuthApiService {
  static const String baseUrl = 'https://test.walatraherbal.com/api/account';
  static Future<OtpRequestResult> requestOtp(String inputPhone) async {
    final phoneNumber = PhoneFormatter.normalize(inputPhone);

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'nohp': phoneNumber},
    );
    debugPrint('Nomor HP : $phoneNumber');
    debugPrint('OTP URL: ${baseUrl.trim()}/login');
    debugPrint('OTP status: ${response.statusCode}');
    debugPrint('OTP response: ${response.body}');
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server sedang bermasalah, silahkan coba lagi nanti');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final success = json['success'] == true;

    if (!success) {
      throw Exception('Nomor Whatsapp tidak dapat diproses');
    }

    final data = json['data'] as Map<String, dynamic>?;
    final otpPair = data?['otp-pair'] as String?;

    if (otpPair == null || otpPair.isEmpty) {
      throw Exception('Data OTP tidak lengkap');
    }

    return OtpRequestResult(
      phoneNumber: data?['number'] as String? ?? phoneNumber,
      otpPair: otpPair,
    );
  }

  static Future<String> confirmOtp({
    required String phoneNumber,
    required String otpPair,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp'),
      body: {'otp_pairs': otpPair, 'ponsel': phoneNumber, 'otp': otp},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server sedang bermasalah, silahkan coba lagi nanti');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final success = json['success'] == true;
    final status = json['status'] == 'success';

    if (!success || !status) {
      throw Exception('Kode OTP tidak valid');
    }

    final authToken = json['auth'] as String?;

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Token autentikasi tidak ditemukan');
    }
    return authToken;
  }

  static Future<Map<String, dynamic>?> checkLogin({
    required String token,
  }) async {
    final uri = Uri.parse('$baseUrl/login-check');

    try {
      final response = await http.post(uri, body: {'token': token});

      debugPrint('LOGIN CHECK URL: $uri');
      debugPrint('LOGIN CHECK STATUS: ${response.statusCode}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('LOGIN CHECK SUCCESS: ${json['success']}');

      if (json['success'] != true || json['status'] != 'success') {
        return null;
      }

      return json;
    } catch (error, stackTrace) {
      debugPrint('LOGIN CHECK ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }

  static Future<bool> logout({required String token}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      body: {'token': token},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Logout dari server gagal');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['success'] == true && json['status'] == 'success';
  }
}
