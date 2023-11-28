import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
      ),
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Image.asset('assets/splash.png',
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
              ' Мобильное приложение, которое поможет путешественникам планировать свои поездки. Оно включает в себя функции по поиску отелей, местных достопримечательностей.' +
              'Также будут предусмотрены интегрированные карты и советы по путешествиям.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    )
    );
  }
}