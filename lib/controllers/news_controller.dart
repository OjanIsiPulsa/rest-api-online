import 'package:flutter/foundation.dart';

import '../models/news_model.dart';
import '../services/api_service.dart';

class NewsController extends ChangeNotifier {
  NewsController({ApiService? apiService})
    : _apiService = apiService ?? ApiService() {
    loadNews();
  }

  final ApiService _apiService;
  List<News> news = const [];
  String? errorMessage;
  bool isLoading = true;
  bool _isDisposed = false;

  Future<void> loadNews() async {
    isLoading = true;
    errorMessage = null;
    _notifyIfActive();

    try {
      news = await _apiService.fetchNews();
    } on Exception catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      _notifyIfActive();
    }
  }

  void _notifyIfActive() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _apiService.close();
    super.dispose();
  }
}
