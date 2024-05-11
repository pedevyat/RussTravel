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
import 'package:russ_travel/articles/regions/ural/Chelyabinskaya.dart';
import 'package:russ_travel/articles/regions/ural/Hanti-Mansiiskii.dart';
import 'package:russ_travel/articles/regions/ural/Kurganskaya.dart';
import 'package:russ_travel/articles/regions/ural/Sverdlovskaya.dart';
import 'package:russ_travel/articles/regions/ural/Tumenskaya.dart';
import 'package:russ_travel/articles/regions/ural/Yamalo-neneckii.dart';
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
import '../regions/ural/Yamalo-neneckii.dart';
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
    
    Article(title: "Ямало-Ненецкий АО", content: Yamalo_neneckii()),
    Article(title: "Тюменская область", content: Tumenskaya()),
    Article(title: "Свердловская область", content: Sverdlovskaya()),
    Article(title: "Курганская область", content: Kurganskaya()),
    Article(title: "Ханты-Мансийский АО", content: Hanti_Mansiiskii()),
    Article(title: "Челябинская область", content: Chelyabinskaya()),
    
    Article(title: "Республика Башкортостан", content: bashkortorstan()),
    Article(title: "Республика Чувашия", content: Chyvashiya()),
    Article(title: "Кировская область", content: Kirovskaya()),
    Article(title: "Республика Марий Эл", content: Marii_el()),
    Article(title: "Республика Мордовия", content: Mordoviya()),
    Article(title: "Нижегородская область", content: Nizhegorodskaya()),
    Article(title: "Оренбургская область", content: Orenburgskaya()),
    Article(title: "Пензенская область", content: Penzenskaya()),
    Article(title: "Пермский край", content: Permskii()),
    Article(title: "Самарская область", content: Samarskaya()),
    Article(title: "Саратовская область", content: Saratovskaya()),
    Article(title: "Республика Татарстан", content: Tatarstan()),
    Article(title: "Республика Удмуртия", content: Ydmurtiya()),
    Article(title: "Ульяновская область", content: Ylyanovskaya()),

    Article(title: "Астраханская область", content: Astrachan()),
    Article(title: "Элиста", content: Elista()),
    Article(title: "Керчь", content: Kerch()),
    Article(title: "Краснодарский край", content: Krasnodar()),
    Article(title: "Республика Адыгея", content: Maikop()),
    Article(title: "Новочеркасск", content: Novocherkassk()),
    Article(title: "Новороссийск", content: Novorossiysk()),
    Article(title: "Ростовская область", content: Rostov()),
    Article(title: "Семфирополь", content: Semfiropol()),
    Article(title: "Севастополь", content: Sevastopol()),
    Article(title: "Шахты", content: Shachty()),
    Article(title: "Сочи", content: Sochi()),
    Article(title: "Волгоградская область", content: Rostov()),
    Article(title: "Волжский", content: Volzhskiy()),
    Article(title: "Ялта", content: Yalta()),

    Article(title: "Амурская область", content: Amursk()),
    Article(title: "Чукотский автономный округ", content: Anadyr()),
    Article(title: "Артем", content: Artem()),
    Article(title: "Белогорск", content: Belogorsk()),
    Article(title: "Еврейская автономная область", content: Birobidzhan()),
    Article(title: "Амурская область", content: Blagoveshensk()),
    Article(title: "Забайкальский край", content: Chita()),
    Article(title: "Елизово", content: Elizovo()),
    Article(title: "Гусиноозёрск", content: Gusinoozersk()),
    Article(title: "Хабаровский край", content: Habarovsk()),
    Article(title: "Холмск", content: Holmsk()),
    Article(title: "Комсомольск-на-Амуре", content: Komsomolsk-na-Amure()),
    Article(title: "Корсаков", content: Korsakov()),
    Article(title: "Краснокаменск", content: Krasnokamensk()),
    Article(title: "Кяхта", content: Kyahta()),
    Article(title: "Магаданская область", content: Magadan()),
    Article(title: "Милково", content: Milkovo()),
    Article(title: "Мирный", content: Mirniy()),
    Article(title: "Находка", content: Nahodka()),
    Article(title: "Нерчинск", content: Nerchinsk()),
    Article(title: "Нерюнгри", content: Neryungri()),
    Article(title: "Камчатский край", content: Petropavlovsk-Kamchatskiy()),
    Article(title: "Северобайкальск", content: Severobaikalsk()),
    Article(title: "Тунда", content: Tynda()),
    Article(title: "Республика Бурятия", content: Ulan-Ude()),
    Article(title: "Уссурийск", content: Ussuriysk()),
    Article(title: "Приморский край", content: Vladivostok()),
    Article(title: "Республика Саха (Якутия)", content: Yakutsk()),
    Article(title: "Сахалинская область", content: Yuzhno-Sachalinsk()),

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
            /*TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Поиск',
                hintText: 'Поиск места...',
              ),
              onChanged: (value) {
                _filterArticles(value);
              },
            ),*/
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