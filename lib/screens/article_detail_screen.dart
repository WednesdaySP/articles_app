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
      appBar: AppBar(title: const Text('Article Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(article.body),
            const SizedBox(height: 16),
            Consumer<ArticleProvider>(
              builder: (context, provider, child) {
                final isFavorite = provider.favoriteIds.contains(article.id);
                return ElevatedButton.icon(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFavorite ? 'Remove Favorite' : 'Add Favorite'),
                  onPressed: () => provider.toggleFavorite(article.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}