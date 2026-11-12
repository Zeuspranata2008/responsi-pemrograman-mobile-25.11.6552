import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

/// Error yang aman ditampilkan ke pengguna.
class ApiException implements Exception {
  ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Layanan HTTP dasar.
class ApiService {
  /// GET `/users` dari [AppConfig.baseUrl]. Melempar [ApiException].
  /// API key dikirim via header dan tidak pernah dicetak ke log.
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final uri = Uri.parse('${AppConfig.baseUrl}/users');
    try {
      final res = await http.get(uri, headers: {
        'Accept': 'application/json',
        'X-Api-Key': AppConfig.apiKey,
      }).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) {
        throw ApiException('Server merespons dengan kode ${res.statusCode}');
      }
      return (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
    } on SocketException {
      throw ApiException('Tidak ada koneksi internet');
    } on TimeoutException {
      throw ApiException('Permintaan melebihi batas waktu');
    } on FormatException {
      throw ApiException('Format data dari server tidak valid');
    }
  }
}
