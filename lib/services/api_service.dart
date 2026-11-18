import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class ApiService {
  ApiService({http.Client? client})
    : _client = client ?? http.Client(),
      _ownsClient = client == null;

  static final Uri _newsUri = Uri.parse(
    'https://6af3c74a55a1de7dcf033e74.mockapi.io/news',
  );

  final http.Client _client;
  final bool _ownsClient;

  Future<List<News>> fetchNews() async {
    final response = await _client
        .get(_newsUri)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal mengambil berita (HTTP ${response.statusCode}).');
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException catch (error) {
      throw FormatException(
        'Respons API bukan JSON yang valid: ${error.message}',
      );
    }

    if (decoded is! List) {
      throw const FormatException('Respons API harus berupa daftar berita.');
    }

    return decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Salah satu data berita memiliki format tidak valid.',
        );
      }
      return News.fromJson(item);
    }).toList();
  }

  void close() {
    if (_ownsClient) _client.close();
  }
}
