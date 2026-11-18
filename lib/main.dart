import 'package:flutter/material.dart';

import 'services/api_service.dart';
import 'views/news_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.apiService});

  final ApiService? apiService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: NewsListPage(apiService: apiService),
      debugShowCheckedModeBanner: false,
    );
  }
}
