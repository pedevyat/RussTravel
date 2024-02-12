import 'package:flutter/material.dart';
import 'package:russ_travel/articles/regions/center/belgorod.dart';
import '../regions/center/bryansk.dart';
import '../regions/north_caucaus/chechnya.dart';
import '../regions/north_caucaus/dagestan.dart';
import '../regions/north_caucaus/ingushetiya.dart';
import '../regions/north_caucaus/kbr.dart';
import '../regions/north_caucaus/kmv.dart';
import '../regions/north_caucaus/osetia.dart';
import '../regions/north_caucaus/stavropol.dart';
import 'article_detail_screen.dart';



class ArticleListScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(title: "Республика Ингушетия", content: Ingushetia()),
    Article(title: "Чеченская республика", content: Chechnya()),
    Article(title: "Республика Северная Осетия - Алания", content: Osetia()),
    Article(title: "Республика Кабардино-Балкария", content: Kbr()),
    Article(title: "Республика Дагестан", content: Dagestan()),
    Article(title: "Ставропольский край: Кавказские Минеральные Воды", content: Kmv()),
    Article(title: "Ставропольский край", content: Stavropol()),

    Article(title: "Белгородская область", content: Belgorod()),
    Article(title: "Брянская область", content: Bryansk()),
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
