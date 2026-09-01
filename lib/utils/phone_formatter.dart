class PhoneFormatter {
  static String normalize(String input) {
    var phone = input.trim();

    // hapus spais, tanda hubung, kurang, dan karakter selain angka
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.startsWith('00')) {
      phone = phone.substring(2);
    }

    if (phone.startsWith('0')) {
      phone = '62${phone.substring(1)}';
    } else if (!phone.startsWith('62')) {
      phone = '62$phone';
    }

    return phone;
  }

  static bool isValid(String input) {
    final phone = normalize(input);

    return phone.startsWith('62') && phone.length >= 10 && phone.length <= 15;
  }
}
