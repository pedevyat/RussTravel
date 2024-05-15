import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tatarstan extends StatelessWidget {
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
                    'https://cdn.yenicaggazetesi.com.tr/other/2023/12/01/64e0a5ecb634d64e0a5ecb634e169244414064e0a5ecb634b64e0a5ecb634c.jpg',
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
    return await rootBundle.loadString('assets/privolzhye/Tatarstan.txt');
  }
}