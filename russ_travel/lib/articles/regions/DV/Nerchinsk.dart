import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Nerchinsk extends StatelessWidget {
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
                    'hhttps://sun9-79.userapi.com/impg/xVYr8aTMNCXkQXNrel7LNGQH66AQ-CJ0T6i_fg/Oz5Hq8vVeK4.jpg?size=960x639&quality=96&sign=3b8302dbbc0765c9bb49ae025879ff2a&c_uniq_tag=Uv8kC6eBL5vA_dEQtIBW0sYp4UlWpZRJbKWJtRNy-fk&type=album',
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
    return await rootBundle.loadString('assets/DV/Nerchinsk.txt');
  }
}