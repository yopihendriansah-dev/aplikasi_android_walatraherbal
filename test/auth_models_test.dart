import 'package:flutter_test/flutter_test.dart';
import 'package:new1/models/auth_session.dart';
import 'package:new1/models/otp_challenge.dart';

void main() {
  test('OTP challenge membaca challenge id dan masa berlaku', () {
    final challenge = OtpChallenge.fromJson({
      'challenge_id': 101,
      'expires_at': '2026-09-07T14:05:00+07:00',
      'delivery_status': 'sent',
    }, phone: '628123456789');

    expect(challenge.challengeId, 101);
    expect(challenge.phone, '628123456789');
    expect(challenge.deliveryStatus, 'sent');
    expect(challenge.expiresAt, isNotNull);
  });

  test('Auth session membaca token dan data user', () {
    final session = AuthSession.fromJson({
      'user': {
        'id': 12,
        'name': null,
        'phone': '628123456789',
        'profile_completed_at': null,
      },
      'token': '42|token-contoh',
      'token_type': 'Bearer',
      'is_new_user': true,
      'requires_profile_completion': true,
    });

    expect(session.user.id, '12');
    expect(session.user.name, isEmpty);
    expect(session.user.phone, '628123456789');
    expect(session.token, '42|token-contoh');
    expect(session.isNewUser, isTrue);
    expect(session.requiresProfileCompletion, isTrue);
  });
}
