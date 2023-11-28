import 'package:flutter/material.dart';

class Article {
  final String title;
  final Widget content;

  Article({required this.title, required this.content});
}

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: article.content,
      ),
    );
  }
}
