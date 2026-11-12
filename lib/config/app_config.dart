import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Konfigurasi aplikasi yang dimuat dari file `.env` (tanpa hardcoded credential).
class AppConfig {
  AppConfig._();

  /// Memuat file `.env`. Panggil sekali di `main()` sebelum `runApp`.
  static Future<void> load() => dotenv.load(fileName: '.env');

  /// URL dasar API publik.
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  /// API key (dummy). Jangan pernah dicetak ke log.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
