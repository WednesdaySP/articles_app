import 'package:articles_app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleModel article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Article Detail Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  article.body,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<ArticleProvider>(
                  builder: (context, provider, child) {
                    final isFavorite = provider.favoriteIds.contains(
                      article.id,
                    );
                    return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFavorite ? Colors.red : Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),

                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        isFavorite ? 'Remove Favorite' : 'Add Favorite',
                      ),
                      onPressed: () {
                        provider.toggleFavorite(article.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? 'Removed from favorites'
                                  : 'Added to favorites',
                              style: const TextStyle(color: Colors.white),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor:
                                isFavorite ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
