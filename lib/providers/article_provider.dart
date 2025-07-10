// import 'package:flutter/material.dart';
// import '../models/article_model.dart';
// import '../services/api_service.dart';

// class ArticleProvider with ChangeNotifier {
//   List<ArticleModel> _articles = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   List<int> _favoriteIds = [];

//   List<ArticleModel> get articles => _articles;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   List<int> get favoriteIds => _favoriteIds;

//   final ApiService _apiService = ApiService();

//   ArticleProvider() {
//     _loadFavorites();
//     fetchArticles(); // Fetch initial articles on initialization
//   }

//   Future<void> fetchArticles({int start = 0, int limit = 20}) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _articles = await _apiService.fetchArticles(start: start, limit: limit);
//     } catch (e) {
//       // Clean error message by removing "Exception:" prefix
//       _errorMessage = e.toString().replaceFirst('Exception: ', '');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> _loadFavorites() async {
//     // final prefs = await SharedPreferences.getInstance();
//     // _favoriteIds = (prefs.getStringList('favorites') ?? []).map((id) => int.parse(id)).toList();
//     // notifyListeners();
//   }

//   Future<void> toggleFavorite(int articleId) async {
//     // final prefs = await SharedPreferences.getInstance();
//     // if (_favoriteIds.contains(articleId)) {
//     //   _favoriteIds.remove(articleId);
//     // } else {
//     //   _favoriteIds.add(articleId);
//     // }
//     // await prefs.setStringList('favorites', _favoriteIds.map((id) => id.toString()).toList());
//     // notifyListeners();
//   }
// }



import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<int> _favoriteIds = [];
  bool _hasMore = true;

  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<int> get favoriteIds => _favoriteIds;
  bool get hasMore => _hasMore;

  final ApiService _apiService = ApiService();
  //final Connectivity _connectivity = Connectivity();

  ArticleProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadFavorites();
    await fetchArticles(); // Fetch initial articles
  }

  Future<void> fetchArticles({int start = 0, int limit = 20, bool refresh = false}) async {
    if (_isLoading) return;
    
    _isLoading = true;
    if (refresh) {
      _articles = [];
      _hasMore = true;
    }
    _errorMessage = null;
    notifyListeners();

    try {
      // Check connectivity
      // final connectivityResult = await _connectivity.checkConnectivity();
      // if (connectivityResult == ConnectivityResult.none) {
      //   throw Exception('No internet connection');
      // }

      final newArticles = await _apiService.fetchArticles(start: start, limit: limit);
      _hasMore = newArticles.length == limit;
      _articles.addAll(newArticles);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      debugPrint('Error fetching articles: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   _favoriteIds = (prefs.getStringList('favorites') ?? [])
    //       .map((id) => int.parse(id))
    //       .toList();
    //   notifyListeners();
    // } catch (e) {
    //   debugPrint('Error loading favorites: $e');
    // }
  }

  Future<void> toggleFavorite(int articleId) async {
    try {
    //   final prefs = await SharedPreferences.getInstance();
    //   if (_favoriteIds.contains(articleId)) {
    //     _favoriteIds.remove(articleId);
    //   } else {
    //     _favoriteIds.add(articleId);
    //   }
    //   await prefs.setStringList(
    //       'favorites', _favoriteIds.map((id) => id.toString()).toList());
    //   notifyListeners();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}