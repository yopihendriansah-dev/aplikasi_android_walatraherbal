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

  static Future<bool> confirmOtp({
    required String phoneNumber,
    required String otpPair,
    required String otp,
  }) async {
    final resphone = await http.post(
      Uri.parse('$baseUrl/otp'),

      body: {'ponsel': phoneNumber, 'otp_pairs': otpPair, 'otp': otp},
    );
    if (resphone.statusCode < 200 || resphone.statusCode >= 300) {
      throw Exception('Server sedang bermasalah, silahkan coba lagi nanti');
    }
    final json = jsonDecode(resphone.body) as Map<String, dynamic>;
    return json['success'] == true && json['status'] == 'success';
  }
}
