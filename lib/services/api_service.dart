import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ApiService {
  // Base URL for the API
  final String _baseUrl = 'https://jsonplaceholder.org/posts';

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      // GET request
      final response = await http.get(Uri.parse(_baseUrl));

      // request successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> data = json.decode(response.body);
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        
        // Convert response data to List<ArticleModel>
        return data.map((item) => ArticleModel.fromJson(item)).toList();
      } else {
        // If server returns an error response
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        throw Exception('Failed to load articles (HTTP ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }
}