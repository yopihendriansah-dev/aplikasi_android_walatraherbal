import 'package:flutter/material.dart';
import 'dart:async';
import '../models/user.dart';
import '../services/auth_api_service.dart';
import '../services/auth_manager.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String otpPair;

  const OtpPage({required this.phoneNumber, required this.otpPair, super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final fromKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  late String currentOtpPair;

  bool isLoading = false;
  bool isResending = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    currentOtpPair = widget.otpPair;
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> confirmOtp() async {
    if (!fromKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final success = await AuthApiService.confirmOtp(
        phoneNumber: widget.phoneNumber,
        otpPair: currentOtpPair,
        otp: otpController.text.trim(),
      );
      if (!mounted) {
        return;
      }

      if (!success) {
        setState(() {
          isLoading = false;
          errorMessage = 'OTP tidak valid';
        });
        return;
      }

      final user = User(
        id: widget.phoneNumber,
        name: 'Nama Pengguna',
        email: '',
      );

      await AuthManager.login(user);

      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, '/home', ((route) => false));
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
        errorMessage = 'Konfirmasi OTP gagal, silakan coba lagi';
      });
    }
  }

  Future<void> resendOtp() async {
    setState(() {
      isResending = true;
      errorMessage = null;
    });

    try {
      final result = await AuthApiService.requestOtp(widget.phoneNumber);
      if (!mounted) {
        return;
      }

      setState(() {
        currentOtpPair = result.otpPair;
        isResending = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP baru berhasil dikirim'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        isResending = false;
        errorMessage = 'Gagal mengirim ulant OTP';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(24),
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'Veriifkasi OTP',
                  style: TextStyle(fontSize: 30, fontWeight: .bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Masukan kode Otp yang dikirim ke nomor ${widget.phoneNumber}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 28),

                AppTextField(
                  controller: otpController,
                  hintText: 'Masukan kode OTP',
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Kode OTP tidak boleh kosong';
                    }

                    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                      return 'Kode OTP harus 6 digit angka';
                    }
                    return null;
                  },
                ),

                if (errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],

                const SizedBox(height: 24),

                AppButton(
                  text: 'Konfirmasi OTP',
                  onPressed: confirmOtp,
                  isLoading: isLoading,
                ),

                const SizedBox(height: 12),

                Center(
                  child: TextButton.icon(
                    onPressed: isResending ? null : resendOtp,
                    icon: isResending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(
                      isResending ? 'Mengirim ulang...' : 'Kirim ulang OTP',
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ganti nomor WhatsApp'),
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
