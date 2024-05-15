import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Kurganskaya extends StatelessWidget {
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
                    'https://sun1-14.userapi.com/impg/URyt9PeS7Vw4YfjBRjqQypP0Eh5W2_GY_4FJKw/DhagnD0DH_s.jpg?size=1080x720&quality=96&sign=984835c3e18d88ccfaca5c23bb656f63&c_uniq_tag=flk5ibMJ4Ae0OiF2VAZykA46Gg237l-BOFPknOkngNE&type=album',
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
    return await rootBundle.loadString('assets/ural/Kurganskaya.txt');
  }
}