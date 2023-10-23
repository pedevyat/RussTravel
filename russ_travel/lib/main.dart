import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainPage()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
}

  class MainPage extends StatelessWidget {
  const MainPage({ Key? key}) : super(key: key);

  void _pushPage(BuildContext context, MapPage page) {
  Navigator.push(
  context,
  MaterialPageRoute<void>(builder: (_) =>
  Scaffold(
  appBar: AppBar(title: Text(page.title)),
  body: Container(
  padding: const EdgeInsets.all(8),
  child: page
  )
  )
  )
  );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: const Text('YandexMap examples')),
  body: Column(
  children: <Widget>[
  Expanded(
  child: Container(
  padding: const EdgeInsets.all(8),
  child: const YandexMap()
  )
  ),
  Expanded(
  child: ListView.builder(
  itemCount: _allPages.length,
  itemBuilder: (_, int index) => ListTile(
  title: Text(_allPages[index].title),
  onTap: () => _pushPage(context, _allPages[index]),
  ),
  )
  )
  ]
  )
  );
  }
  }