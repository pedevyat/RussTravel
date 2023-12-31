import 'package:flutter/material.dart';

class Ingushetia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://static.tildacdn.com/tild6430-6361-4566-b037-633131653334/DSCF9411.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ингушетия находится на Северном Кавказе. Республика граничит с Северной Осетией, Чечнёй и Грузией. Последнее обстоятельство следует учитывать при подготовке к путешествию. Дело в том, что часть маршрутов проходит по территории погранзоны. ' +
                'Значительную часть территории республики занимают горы. Они являются главным центром притяжения туристов. По площади Ингушетия считается самым малым регионом среди субъектов Федерации.' +
                    'Главными достопримечательностями республики являются живописная природа и древние памятники. В Ингушетии вы попадаете в Средние века. Общее число родовых башен, построенных в древности, превышает две тысячи! По меркам того времени это были настоящие небоскрёбы. Самым крупным башенным комплексом считаются Вовнушки. В республике сохранился один из старейших христианских храмов в России — Тхаба-Ерды. В Ингушетию едут поправить здоровье местной минеральной водичкой, а также посетить заповедник Эрзи, который славится разнообразием флоры и фауны.' +
              'Материал: https://www.vpoxod.ru/page/toponym/ingushetiya_info',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        ),
    );
  }
}
