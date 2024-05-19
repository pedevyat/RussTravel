import 'package:flutter/material.dart';
import 'package:russ_travel/articles/regions/DV/Komsomolsk-na-Amure.dart';
import 'package:russ_travel/articles/regions/DV/Ulan-Ude.dart';
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
import '../regions/DV/Amursk.dart';
import '../regions/DV/Anadyr.dart';
import '../regions/DV/Artem.dart';
import '../regions/DV/Belogorsk.dart';
import '../regions/DV/Birobidzhan.dart';
import '../regions/DV/Blagoveshensk.dart';
import '../regions/DV/Chita.dart';
import '../regions/DV/Elizovo.dart';
import '../regions/DV/Gusinoozersk.dart';
import '../regions/DV/Habarovsk.dart';
import '../regions/DV/Holmsk.dart';
import '../regions/DV/Korsakov.dart';
import '../regions/DV/Krasnokamensk.dart';
import '../regions/DV/Kyachta.dart';
import '../regions/DV/Magadan.dart';
import '../regions/DV/Milkovo.dart';
import '../regions/DV/Mirniy.dart';
import '../regions/DV/Nahodka.dart';
import '../regions/DV/Nerchinsk.dart';
import '../regions/DV/Neryungri.dart';
import '../regions/DV/Petropavlovsk-kamchatskiy.dart';
import '../regions/DV/Severobaikalsk.dart';
import '../regions/DV/Tynda.dart';
import '../regions/DV/Ussuriysk.dart';
import '../regions/DV/Vladivostok.dart';
import '../regions/DV/Yakutsk.dart';
import '../regions/DV/Yuzhno-Sachalinsk.dart';
import '../regions/Yufo/Astrachan.dart';
import '../regions/Yufo/Astrachan.dart';
import '../regions/Yufo/Elista.dart';
import '../regions/Yufo/Kerch.dart';
import '../regions/Yufo/Krasnodar.dart';
import '../regions/Yufo/Maikop.dart';
import '../regions/Yufo/Novocherkassk.dart';
import '../regions/Yufo/Novorossiysk.dart';
import '../regions/Yufo/Rostov.dart';
import '../regions/Yufo/Semfiropol.dart';
import '../regions/Yufo/Sevastopol.dart';
import '../regions/Yufo/Shachty.dart';
import '../regions/Yufo/Sochi.dart';
import '../regions/Yufo/Volgograd.dart';
import '../regions/Yufo/Volzhskiy.dart';
import '../regions/Yufo/Yalta.dart';
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
import '../regions/privolzhye/Bashkotorstan.dart';
import '../regions/privolzhye/Chyvashiya.dart';
import '../regions/privolzhye/Kirovskaya.dart';
import '../regions/privolzhye/Marii_el.dart';
import '../regions/privolzhye/Mordoviya.dart';
import '../regions/privolzhye/Nizhegorodskaya.dart';
import '../regions/privolzhye/Orenburgskaya.dart';
import '../regions/privolzhye/Penzenskaya.dart';
import '../regions/privolzhye/Permskii.dart';
import '../regions/privolzhye/Samarskaya.dart';
import '../regions/privolzhye/Saratovskaya.dart';
import '../regions/privolzhye/Tatarstan.dart';
import '../regions/privolzhye/Ydmurtiya.dart';
import '../regions/privolzhye/Ylyanovskaya.dart';
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
    
    Article(title: "Республика Башкортостан", content: Bashkotorstan()),
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
    Article(title: "Симфирополь", content: Semfiropol()),
    Article(title: "Севастополь", content: Sevastopol()),
    Article(title: "Шахты", content: Shachty()),
    Article(title: "Сочи", content: Sochi()),
    Article(title: "Волгоградская область", content: Volgograd()),
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
    Article(title: "Комсомольск-на-Амуре", content: Komsomolsk_na_Amure()),
    Article(title: "Корсаков", content: Korsakov()),
    Article(title: "Краснокаменск", content: Krasnokamensk()),
    Article(title: "Кяхта", content: Kyachta()),
    Article(title: "Магаданская область", content: Magadan()),
    Article(title: "Милково", content: Milkovo()),
    Article(title: "Мирный", content: Mirniy()),
    Article(title: "Находка", content: Nahodka()),
    Article(title: "Нерчинск", content: Nerchinsk()),
    Article(title: "Нерюнгри", content: Neryungri()),
    Article(title: "Камчатский край", content: Petropavlovsk_kamchatskiy()),
    Article(title: "Северобайкальск", content: Severobaikalsk()),
    Article(title: "Тунда", content: Tynda()),
    Article(title: "Республика Бурятия", content: Ulan_Ude()),
    Article(title: "Уссурийск", content: Ussuriysk()),
    Article(title: "Приморский край", content: Vladivostok()),
    Article(title: "Республика Саха (Якутия)", content: Yakutsk()),
    Article(title: "Сахалинская область", content: Yuzhno_Sachalinsk()),

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