import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tumenskaya extends StatelessWidget {
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
                    'https://sun9-4.userapi.com/impg/qyE8Ppuk9JH_gCWsMdmtOZF376mGxwk-vzhwew/CydhzjH74PU.jpg?size=1067x800&quality=95&sign=d678d4f379427480a5ddbdd82f8c8396&type=album',
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
    return await rootBundle.loadString('assets/ural/Tumenskaya.txt');
  }
}