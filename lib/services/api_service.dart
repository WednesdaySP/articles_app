
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/article_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final Dio _dio = Dio();

  Future<List<ArticleModel>> fetchArticles({int start = 0, int limit = 30}) async {

    try {
      final url = '$_baseUrl?_start=$start&_limit=$limit';
      print('Fetching articles from: $url'); // Log URL for debugging
      final response = await _dio.get(url);
      print('Response status: ${response.statusCode}, body: ${response.data}'); // Log response

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Data fetched successfully: ${data.length} articles'); // Log data length
        return await compute(_parseArticles, data); // Offload parsing to background
      } else {
        throw Exception('Failed to load articles: HTTP ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode}, ${e.response?.data}'); // Log Dio error
      if (e.response != null) {
        throw Exception('Failed to load articles: HTTP ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e'); // Log unexpected error
      throw Exception('Failed to load articles: $e');
    }
  }

  static List<ArticleModel> _parseArticles(List<dynamic> data) {
    return data.map((json) => ArticleModel.fromJson(json)).toList();
  }
}