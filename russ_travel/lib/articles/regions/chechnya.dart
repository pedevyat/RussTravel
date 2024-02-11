import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chechnya extends StatelessWidget {
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
                    'https://cdn.tripster.ru/thumbs2/ca60d5a0-efd5-11ec-9d36-7ec6b791af02.800x600.jpeg',
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
    return await rootBundle.loadString('assets/north_caucasus/chechnya.txt');
  }
}