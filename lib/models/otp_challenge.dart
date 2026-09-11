class OtpChallenge {
  final String phone;
  final int challengeId;
  final DateTime? expiresAt;
  final String deliveryStatus;
  final String? exposedOtp;

  const OtpChallenge({
    required this.phone,
    required this.challengeId,
    required this.expiresAt,
    required this.deliveryStatus,
    this.exposedOtp,
  });

  factory OtpChallenge.fromJson(
    Map<String, dynamic> json, {
    required String phone,
  }) {
    final rawChallengeId = json['challenge_id'];
    final challengeId = rawChallengeId is num
        ? rawChallengeId.toInt()
        : int.tryParse('$rawChallengeId');
    if (challengeId == null) {
      throw const FormatException('challenge_id tidak ditemukan');
    }

    final rawExpiresAt = json['expires_at'];
    return OtpChallenge(
      phone: phone,
      challengeId: challengeId,
      expiresAt: rawExpiresAt is String
          ? DateTime.tryParse(rawExpiresAt)
          : null,
      deliveryStatus: json['delivery_status'] as String? ?? 'unknown',
      exposedOtp: json['otp'] as String?,
    );
  }
}
