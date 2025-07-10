
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// import '../models/article_model.dart';

// class ApiService {
//   static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
//   final Dio _dio = Dio();

//   Future<List<ArticleModel>> fetchArticles({int start = 0, int limit = 30}) async {

//     try {
//       final url = '$_baseUrl?_start=$start&_limit=$limit';
//       print('Fetching articles from: $url'); // Log URL
//       final response = await _dio.get(url);
//       print('Response status: ${response.statusCode}, body: ${response.data}'); // Log response

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         print('Data fetched successfully: ${data.length} articles'); // Log data length
//         return await compute(_parseArticles, data); // Offload parsing to background
//       } else {
//         throw Exception('Failed to load articles: HTTP ${response.statusCode} - ${response.statusMessage}');
//       }
//     } on DioException catch (e) {
//       print('Dio error: ${e.response?.statusCode}, ${e.response?.data}'); // Log Dio error
//       if (e.response != null) {
//         throw Exception('Failed to load articles: HTTP ${e.response?.statusCode} - ${e.response?.statusMessage}');
//       } else {
//         throw Exception('Network error: ${e.message}');
//       }
//     } catch (e) {
//       print('Unexpected error: $e'); // Log unexpected error
//       throw Exception('Failed to load articles: $e');
//     }
//   }

//   static List<ArticleModel> _parseArticles(List<dynamic> data) {
//     return data.map((json) => ArticleModel.fromJson(json)).toList();
//   }
// }


import 'package:dio/dio.dart';
import '../models/article_model.dart';

class ApiService {
  // Base URL for the API
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  
  // Create Dio instance with custom configuration
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'FlutterApp/1.0.0', // Custom user agent
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // Simplified fetch method with improved error handling
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      // Make the GET request with timeout
      final response = await _dio.get(
        _baseUrl,
        options: Options(
          // Additional headers if needed
          headers: {
            'Cache-Control': 'no-cache',
          },
        ),
      );

      // Check if request was successful (status code 200)
      if (response.statusCode == 200) {
        // Convert response data to List<ArticleModel>
        return (response.data as List)
            .map((item) => ArticleModel.fromJson(item))
            .toList();
      } else {
        // If server returns an error response
        throw Exception('Failed to load articles (HTTP ${response.statusCode})');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        // Server responded with error status code
        if (e.response!.statusCode == 403) {
          throw Exception('Access denied. Please try again later.');
        }
        throw Exception('Server error: ${e.response!.statusCode}');
      } else {
        // Network or other Dio errors
        throw Exception('Network error: ${e.message ?? 'Unknown error'}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Failed to load articles: $e');
    }
  }
}