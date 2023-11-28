import 'package:flutter/material.dart';
import 'article_detail_screen.dart';



class ArticleListScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(title: "Республика Ингушетия", content: "Содержание"),
    Article(title: "Чеченская республика", content: "Содержание"),
    Article(title: "Республика Северная Осетия - Алания", content: "Содержание"),
    Article(title: "Дальнейшие планы", content: "..")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Статьи'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(articles[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: articles[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
