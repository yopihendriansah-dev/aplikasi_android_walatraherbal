class ApiConfig {
  static const String baseUrl = 'https://ac8e-175-158-49-126.ngrok-free.app';

  static const String apiPrefix = '/api/v1';

  static String get apiUrl => '$baseUrl$apiPrefix';

  // Endpoint katalog lama belum dipindahkan ke dokumentasi v1.
  static String get legacyApiUrl => '$baseUrl/api';
}
