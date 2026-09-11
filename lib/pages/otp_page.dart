import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_api_service.dart';
import '../services/auth_manager.dart';
import '../widgets/app_button.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  final int challengeId;
  final DateTime? expiresAt;
  final String deliveryStatus;

  const OtpPage({
    required this.phone,
    required this.challengeId,
    required this.expiresAt,
    required this.deliveryStatus,
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final codeControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());
  Timer? countdownTimer;
  Timer? resendCooldownTimer;

  late int currentChallengeId;
  late DateTime? currentExpiresAt;
  late String currentDeliveryStatus;
  DateTime? resendAvailableAt;
  bool isLoading = false;
  bool isResending = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    currentChallengeId = widget.challengeId;
    currentExpiresAt = widget.expiresAt;
    currentDeliveryStatus = widget.deliveryStatus;
    _startCountdown();
  }

  void _startCountdown() {
    countdownTimer?.cancel();
    if (currentExpiresAt == null) return;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (DateTime.now().isAfter(currentExpiresAt!)) {
        countdownTimer?.cancel();
      }
      setState(() {});
    });
  }

  void _startResendCooldownTimer() {
    resendCooldownTimer?.cancel();
    resendCooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (!isResendCooldownActive) {
        resendCooldownTimer?.cancel();
        resendAvailableAt = null;
      }
      setState(() {});
    });
  }

  String get otp => codeControllers.map((controller) => controller.text).join();

  bool get isOtpComplete => otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);

  String get countdownText {
    final expiresAt = currentExpiresAt;
    if (expiresAt == null) return 'Periksa WhatsApp Anda';
    final seconds = expiresAt.difference(DateTime.now()).inSeconds;
    if (seconds <= 0) return 'Kode OTP sudah kedaluwarsa';
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return 'Kode berlaku $minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool get isResendCooldownActive {
    final availableAt = resendAvailableAt;
    return availableAt != null && DateTime.now().isBefore(availableAt);
  }

  int get resendRemainingSeconds {
    final availableAt = resendAvailableAt;
    if (availableAt == null) return 0;
    final remaining = availableAt.difference(DateTime.now()).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  String get resendCooldownText {
    final seconds = resendRemainingSeconds;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get maskedPhone {
    final phone = widget.phone;
    if (phone.length < 8) return phone;
    return '${phone.substring(0, 4)}****${phone.substring(phone.length - 3)}';
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    resendCooldownTimer?.cancel();
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleCodeChanged(int index, String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 1) {
      for (
        var offset = 0;
        offset < digits.length && index + offset < 6;
        offset++
      ) {
        codeControllers[index + offset].text = digits[offset];
      }
      final nextIndex = (index + digits.length).clamp(0, 5);
      focusNodes[nextIndex].requestFocus();
    } else if (digits.isNotEmpty) {
      codeControllers[index].text = digits;
      if (index < 5) focusNodes[index + 1].requestFocus();
    }

    if (errorMessage != null) errorMessage = null;
    setState(() {});
  }

  Future<void> pasteOtpFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;

    final digits = clipboardData?.text?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
    if (digits.length < 6) {
      setState(() {
        errorMessage = 'Clipboard tidak berisi kode OTP 6 digit';
      });
      return;
    }

    final otpDigits = digits.substring(0, 6);
    for (var index = 0; index < codeControllers.length; index++) {
      codeControllers[index].text = otpDigits[index];
    }
    focusNodes.last.requestFocus();
    setState(() {
      errorMessage = null;
    });
  }

  Future<void> confirmOtp() async {
    if (!isOtpComplete) {
      setState(() => errorMessage = 'Masukkan 6 digit kode OTP');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final session = await AuthApiService.verifyOtp(
        phone: widget.phone,
        challengeId: currentChallengeId,
        otp: otp,
        deviceName: 'flutter-app',
      );
      await AuthManager.saveSession(session);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = error.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'Konfirmasi OTP gagal, silakan coba lagi';
      });
    }
  }

  Future<void> resendOtp() async {
    if (isResendCooldownActive) return;

    setState(() {
      isResending = true;
      errorMessage = null;
    });

    try {
      final result = await AuthApiService.requestOtp(widget.phone);
      if (!mounted) return;
      setState(() {
        currentChallengeId = result.challengeId;
        currentExpiresAt = result.expiresAt;
        currentDeliveryStatus = result.deliveryStatus;
        resendAvailableAt = null;
        isResending = false;
        for (final controller in codeControllers) {
          controller.clear();
        }
      });
      _startCountdown();
      focusNodes.first.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_deliveryMessage(result.deliveryStatus))),
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        isResending = false;
        errorMessage = error.message;
        if (error.statusCode == 429) {
          final waitSeconds = error.retryAfter ?? 60;
          resendAvailableAt = DateTime.now().add(
            Duration(seconds: waitSeconds),
          );
          _startResendCooldownTimer();
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isResending = false;
        errorMessage = 'Gagal mengirim ulang OTP';
      });
    }
  }

  String _deliveryMessage(String status) {
    switch (status) {
      case 'sent':
        return 'Kode OTP berhasil dikirim ke WhatsApp';
      case 'pending':
      case 'unknown':
        return 'Permintaan OTP diterima. Silakan cek WhatsApp';
      default:
        return 'Permintaan OTP sedang diproses';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Kembali',
              ),
              const SizedBox(height: 28),
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logowhatsapp.webp',
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Verifikasi OTP',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Masukkan kode 6 digit yang dikirim ke\n$maskedPhone',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  '${_deliveryMessage(currentDeliveryStatus)} • $countdownText',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    height: 58,
                    child: Focus(
                      onKeyEvent: (node, event) {
                        final isBackspace =
                            event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace;

                        if (isBackspace &&
                            codeControllers[index].text.isEmpty &&
                            index > 0) {
                          codeControllers[index - 1].clear();
                          focusNodes[index - 1].requestFocus();
                          setState(() {});
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        controller: codeControllers[index],
                        focusNode: focusNodes[index],
                        autofocus: index == 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: index == 5
                            ? TextInputAction.done
                            : TextInputAction.next,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: colorScheme.surface,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) => _handleCodeChanged(index, value),
                        onSubmitted: index == 5 ? (_) => confirmOtp() : null,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: pasteOtpFromClipboard,
                  icon: const Icon(Icons.content_paste_outlined, size: 18),
                  label: const Text('Tempel kode OTP'),
                ),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
                if (isResendCooldownActive) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Silakan coba lagi dalam $resendCooldownText',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 28),
              AppButton(
                text: 'Verifikasi dan Masuk',
                icon: Icons.arrow_forward,
                onPressed: isOtpComplete ? confirmOtp : null,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: isResending || isResendCooldownActive
                      ? null
                      : resendOtp,
                  icon: isResending
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                  label: Text(_resendButtonText),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ganti nomor WhatsApp'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _resendButtonText {
    if (isResending) return 'Mengirim ulang...';
    if (isResendCooldownActive) {
      return 'Tunggu $resendCooldownText untuk kirim ulang';
    }
    return 'Kirim ulang kode';
  }
}
