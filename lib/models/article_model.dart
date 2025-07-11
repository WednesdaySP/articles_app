class ArticleModel {
  final int? userId;
  final int id;
  final String title;
  final String body;

  ArticleModel({ required this.id, required this.title, required this.body, this.userId });
  
  factory ArticleModel.fromJson(Map<String, dynamic> json){
    return ArticleModel(
      userId: json['userId'] ?? 0, // Default to 0 if userId is not present
      id: json['id'],
      title: json['title'],
      body: json['content'],
    );
  }
}
