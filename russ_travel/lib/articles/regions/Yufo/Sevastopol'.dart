import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sevastopol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadDescription(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    'https://news2.ru/user_images/36694/1453633467.jpg',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      snapshot.data ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }


  Future<String> loadDescription() async {
    return await rootBundle.loadString("assets/Yufo/Sevastopol'.txt");
  }
}