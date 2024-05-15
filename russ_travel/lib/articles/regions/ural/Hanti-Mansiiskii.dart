import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hanti_Mansiiskii extends StatelessWidget {
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
                    'https://sun9-43.userapi.com/impg/AQfN53D-yjBdG6NHu55yZR5lp514OhGTkL9hsA/44MNjnZ7uw0.jpg?size=807x538&quality=95&sign=32f76b2f466d552b9d7555415982238b&c_uniq_tag=q42hjCeW98YrmH2_TCK1Fu9owRxIPxemzeBosu3eg7k&type=album',
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
    return await rootBundle.loadString('assets/ural/Hanti-Mansiiskii.txt');
  }
}