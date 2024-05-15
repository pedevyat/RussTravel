import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:hive_flutter_templates/hive_functions.dart';
import 'package:hive/hive.dart';
import 'package:russ_travel/map/presentation/screens/hotels_collection.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'map/presentation/screens/map_screen.dart';
import 'profile.dart';
import 'articles/screens/article_list_screen.dart';
import 'information/info_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 		
  await Hive.initFlutter(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Yandex Map',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
<<<<<<< HEAD
    //MapScreen(),
=======
    MapScreen(),
>>>>>>> 495a5bc6bf135ed8a12e60783de84981ce95f278
    ArticleListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Color.fromRGBO(0, 108, 167, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Статьи',
          ),
        ],
      ),
    );
  }
}
