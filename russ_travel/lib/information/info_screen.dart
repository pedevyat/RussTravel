import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadDescription(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/splash.png',
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
    return await rootBundle.loadString('assets/info.txt');
  }
}