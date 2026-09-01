import 'package:flutter_test/flutter_test.dart';
import 'package:new1/utils/phone_formatter.dart';

void main() {
  test('Nomor dengan awalan 0 diubah ke format 62', () {
    final result = PhoneFormatter.normalize('0881023889081');

    expect(result, '62881023889081');
  });

  test('Nomor dengan awalan 62 tetap konsisten', () {
    final result = PhoneFormatter.normalize('62881023889081');

    expect(result, '62881023889081');
  });

  test('Nomor tanpa awalan diubah ke format 62', () {
    final result = PhoneFormatter.normalize('881023889081');

    expect(result, '62881023889081');
  });

  test('Nomor dengan tanda plus dan spasi dibersihkan', () {
    final result = PhoneFormatter.normalize('+62 881-0238-89081');

    expect(result, '62881023889081');
  });

  test('Nomor valid menghasilkan nilai true', () {
    expect(PhoneFormatter.isValid('0881023889081'), isTrue);
  });

  test('Nomor terlalu pendek menghasilkan nilai false', () {
    expect(PhoneFormatter.isValid('08123'), isFalse);
  });
}
