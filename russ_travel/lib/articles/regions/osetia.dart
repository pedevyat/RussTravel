import 'package:flutter/material.dart';

class Osetia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://vmeste-rf.tv/upload/resize_cache/iblock/7b1/1040_650_2/lori_0000039468_a6.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Северная Осетия-Алания – почти самая компактная в плане территории из республик Северного Кавказа. Меньше только соседняя Ингушетия. Поэтому на знакомство с самыми главными достопримечательностями хватит 3-4 дня. ' +
                'Но на этой территории такое множество природных красот и исторических памятников, что для полноценного изучения здешних мест в самостоятельном режиме мы бы рекомендовали неделю. ' +
                'Республика славится интересными локациями, живописной природой и гостеприимными жителями. Разработано множество туристических направлений для последовательного ознакомления гостей Северной Осетии с ее достопримечательностями. Практически во все туры включено посещение горных аулов Цамад, Лац и Цымити, старинных святилищ, Даргавского некрополя, Дзивгисской крепости и других удивительных мест. ' +
                  'Материал: https://bolshayastrana.com/blog/severnaya-osetiya-letom-80'  ,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        )
    );
  }
}
