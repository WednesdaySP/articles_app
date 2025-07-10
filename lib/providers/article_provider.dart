import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<int> _favoriteIds = [];

  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<int> get favoriteIds => _favoriteIds;

  final ApiService _apiService = ApiService();

  ArticleProvider() {
    _init();
  }

  Future<void> _init() async {
    await fetchArticles();
    await _loadFavorites();
  }

  Future<void> fetchArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _apiService.fetchArticles();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _favoriteIds = (prefs.getStringList('favorites') ?? [])
          .map((id) => int.parse(id))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(int articleId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_favoriteIds.contains(articleId)) {
        _favoriteIds.remove(articleId);
      } else {
        _favoriteIds.add(articleId);
      }
      await prefs.setStringList(
          'favorites', _favoriteIds.map((id) => id.toString()).toList());
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}