import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import 'article_detail_screen.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Articles Screen'),
        centerTitle: true,
        ),
      body: RefreshIndicator(
        onRefresh: provider.fetchArticles,
        child: Consumer<ArticleProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.errorMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: provider.fetchArticles,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: provider.articles.length,
              itemBuilder: (context, index) {
                final article = provider.articles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2,
                    child: ListTile(
                      title: Text(article.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),),
                      trailing: GestureDetector(
                        onLongPress: () {
                          provider.toggleFavorite(article.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(provider.favoriteIds.contains(article.id)
                                  ? 'Removed from favorites'
                                  : 'Added to favorites',style: TextStyle(color: Colors.white),),
                              backgroundColor: provider.favoriteIds.contains(article.id)
                                  ? Colors.red
                                  : Colors.green,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Icon(
                          provider.favoriteIds.contains(article.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: provider.favoriteIds.contains(article.id)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}