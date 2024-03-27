import 'package:flutter/material.dart';
import 'package:russ_travel/articles/regions/center/belgorod.dart';
import 'package:russ_travel/articles/regions/center/ivanovo.dart';
import 'package:russ_travel/articles/regions/center/kostroma.dart';
import 'package:russ_travel/articles/regions/center/kursk.dart';
import 'package:russ_travel/articles/regions/center/lipetsk.dart';
import 'package:russ_travel/articles/regions/center/moscow1.dart';
import 'package:russ_travel/articles/regions/center/moscow2.dart';
import 'package:russ_travel/articles/regions/center/moscow3.dart';
import 'package:russ_travel/articles/regions/center/moscow_region.dart';
import 'package:russ_travel/articles/regions/center/ryazan.dart';
import 'package:russ_travel/articles/regions/center/tambov.dart';
import 'package:russ_travel/articles/regions/center/tver_city.dart';
import 'package:russ_travel/articles/regions/center/tver_region.dart';
import 'package:russ_travel/articles/regions/center/vladimir_city.dart';
import 'package:russ_travel/articles/regions/center/vladimir_region.dart';
import 'package:russ_travel/articles/regions/center/voronezh.dart';
import 'package:russ_travel/articles/regions/center/yaroslavl.dart';
import '../regions/center/bryansk.dart';
import '../regions/center/kaluga.dart';
import '../regions/center/oryol.dart';
import '../regions/center/smolensk.dart';
import '../regions/center/tula.dart';
import '../regions/north_caucaus/chechnya.dart';
import '../regions/north_caucaus/dagestan.dart';
import '../regions/north_caucaus/ingushetiya.dart';
import '../regions/north_caucaus/kbr.dart';
import '../regions/north_caucaus/kchr.dart';
import '../regions/north_caucaus/kmv.dart';
import '../regions/north_caucaus/osetia.dart';
import '../regions/north_caucaus/stavropol.dart';
import 'article_detail_screen.dart';

// ДОБАВИТЬ ИЗОБРАЖЕНИЕ, ЕСЛИ НЕТ РЕЗУЛЬТАТОВ ПОИСКА
// ДОБАВИТЬ ПРОКРУТКУ

class ArticleListScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  bool _ascendingOrder = true;
  TextEditingController _searchController = TextEditingController();
  List<Article> articles = [
    Article(title: "Республика Ингушетия", content: Ingushetia()),
    Article(title: "Чеченская республика", content: Chechnya()),
    Article(title: "Республика Северная Осетия - Алания", content: Osetia()),
    Article(title: "Республика Кабардино-Балкария", content: Kbr()),
    Article(title: "Республика Дагестан", content: Dagestan()),
    Article(title: "Ставропольский край: Кавказские Минеральные Воды", content: Kmv()),
    Article(title: "Ставропольский край", content: Stavropol()),
    Article(title: "Республика Карачаево-Черкессия", content: Kchr()),

    Article(title: "Белгородская область", content: Belgorod()),
    Article(title: "Брянская область", content: Bryansk()),
    Article(title: "Владимирская область", content: VladimirRegion()),
    Article(title: "Владимирская область: Владимир", content: VladimirCity()),
    Article(title: "Воронежская область", content: Voronezh()),
    Article(title: "Ивановская область", content: Ivanovo()),
    Article(title: "Калужская область", content: Kaluga()),
    Article(title: "Костромская область", content: Kostroma()),
    Article(title: "Курская область", content: Kursk()),
    Article(title: "Липецкая область", content: Lipetsk()),
    Article(title: "Москва: Главные достопримечательности (ч. 1)", content: Moscow1()),
    Article(title: "Москва: Главные достопримечательности (ч. 2)", content: Moscow2()),
    Article(title: "Москва: Главные достопримечательности (ч. 3)", content: Moscow3()),
    Article(title: "Московская область", content: MoscowRegion()),
    Article(title: "Орловская область", content: Oryol()),
    Article(title: "Рязанская область", content: Ryazan()),
    Article(title: "Смоленская область", content: Smolensk()),
    Article(title: "Тамбовская область", content: Tambov()),
    Article(title: "Тверская область", content: TverRegion()),
    Article(title: "Тверская область: Тверь", content: TverCity()),
    Article(title: "Тульская область", content: Tula()),
    Article(title: "Ярославская область", content: Yaroslavl()),
  ];

  List<Article> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    _filteredArticles.addAll(articles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Статьи'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _sortArticles,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchArticles,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Поиск',
                hintText: 'Поиск места...',
              ),
              onChanged: (value) {
                _filterArticles(value);
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filteredArticles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredArticles[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailScreen(article: _filteredArticles[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sortArticles() {
    setState(() {
      if (_ascendingOrder) {
        articles.sort((a, b) => a.title.compareTo(b.title));
      } else {
        articles.sort((a, b) => b.title.compareTo(a.title));
      }
      _ascendingOrder = !_ascendingOrder;
      _filteredArticles.clear();
      _filteredArticles.addAll(articles);
    });
  }

  void _searchArticles() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Поиск места'),
          content: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              hintText: 'Поиск места...',
            ),
            onChanged: (value) {
              _filterArticles(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void _filterArticles(String query) {
    setState(() {
      _filteredArticles = articles.where((article) => article.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }
}