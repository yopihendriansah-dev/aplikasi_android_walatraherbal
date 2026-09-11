import 'dart:async';
import 'package:flutter/material.dart';
import '../services/auth_api_service.dart';
import '../utils/phone_formatter.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  Timer? retryTimer;
  DateTime? retryAvailableAt;
  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    retryTimer?.cancel();
    phoneController.dispose();
    super.dispose();
  }

  bool get isRetryCooldownActive {
    final availableAt = retryAvailableAt;
    return availableAt != null && DateTime.now().isBefore(availableAt);
  }

  int get retryRemainingSeconds {
    final availableAt = retryAvailableAt;
    if (availableAt == null) return 0;
    final remaining = availableAt.difference(DateTime.now()).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  String get retryCountdownText {
    final seconds = retryRemainingSeconds;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startRetryCooldown(int seconds) {
    retryTimer?.cancel();
    retryAvailableAt = DateTime.now().add(Duration(seconds: seconds));
    retryTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (!isRetryCooldownActive) {
        retryTimer?.cancel();
        retryAvailableAt = null;
      }
      setState(() {});
    });
  }

  Future<void> requestOtp() async {
    if (isRetryCooldownActive) return;
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await AuthApiService.requestOtp(phoneController.text);
      if (!mounted) return;
      setState(() {
        isLoading = false;
        retryAvailableAt = null;
      });

      Navigator.pushNamed(
        context,
        '/otp',
        arguments: {
          'phone': result.phone,
          'challengeId': result.challengeId,
          'expiresAt': result.expiresAt,
          'deliveryStatus': result.deliveryStatus,
        },
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = error.message;
      });
      if (error.statusCode == 429) {
        startRetryCooldown(error.retryAfter ?? 60);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'Gagal mengirim OTP. Silakan coba lagi';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Masuk ke Walatra',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Gunakan nomor WhatsApp untuk melanjutkan belanja.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: phoneController,
                  hintText: 'Nomor WhatsApp',
                  prefixIcon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor WhatsApp wajib diisi';
                    }
                    if (!PhoneFormatter.isValid(value)) {
                      return 'Nomor WhatsApp tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Contoh: 081234567890 atau 6281234567890',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  if (isRetryCooldownActive) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Silakan coba lagi dalam $retryCountdownText',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
                const SizedBox(height: 24),
                AppButton(
                  text: isRetryCooldownActive
                      ? 'Tunggu $retryCountdownText'
                      : 'Kirim Kode OTP',
                  icon: Icons.arrow_forward,
                  onPressed: isRetryCooldownActive ? null : requestOtp,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Kode verifikasi akan dikirim melalui WhatsApp.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
