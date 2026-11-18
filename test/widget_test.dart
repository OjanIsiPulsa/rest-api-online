import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pemob_restapionline/main.dart';
import 'package:pemob_restapionline/services/api_service.dart';

void main() {
  testWidgets('loads news returned by the API', (WidgetTester tester) async {
    final apiService = ApiService(
      client: MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/news');
        return http.Response(
          jsonEncode([
            {
              'id': '1',
              'title': 'Berita pengujian',
              'content': 'Isi berita',
              'image_url': '',
              'category': 'Teknologi',
              'author': 'Penulis',
              'cratedAt': '2026-11-10T08:12:21.624Z',
            },
          ]),
          200,
        );
      }),
    );

    await tester.pumpWidget(MyApp(apiService: apiService));
    await tester.pumpAndSettle();

    expect(find.text('News App'), findsOneWidget);
    expect(find.text('Berita pengujian'), findsOneWidget);
    expect(find.text('Teknologi'), findsOneWidget);
    expect(find.textContaining('Penulis'), findsOneWidget);

    await tester.tap(find.text('Berita pengujian'));
    await tester.pumpAndSettle();

    expect(find.text('News App'), findsOneWidget);
    expect(find.text('Isi berita'), findsOneWidget);
    expect(find.byKey(const ValueKey('news-detail-back')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('news-detail-back')));
    await tester.pumpAndSettle();

    expect(find.text('Berita pengujian'), findsOneWidget);
    expect(find.text('Isi berita'), findsNothing);
  });
}
