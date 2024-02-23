import 'dart:async';

import 'package:flutter/material.dart';
import 'package:russ_travel/map/domain/app_latitude_longitude.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/location_service.dart';
import '../../domain/museum_point.dart';
import '../../domain/outside_point.dart';
import '../../domain/park_point.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});


  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;


  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта открытий')),
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: Point(
                  latitude: 50,
                  longitude: 20,
                ),
                zoom: 3,
              ),
            ),
          );
        },
        mapObjects: _getPlacemarkObjectsP(context)+
            _getPlacemarkObjectsO(context) +
            _getPlacemarkObjectsM(context),
      ),
    );
  }
}
//  /// Проверка разрешений на доступ к геопозиции пользователя
//  Future<void> _initPermission() async {
//    if (!await LocationService().checkPermission()) {
//      await LocationService().requestPermission();
//    }
//    await _fetchCurrentLocation();
//  }
//
//  /// Получение текущей геопозиции пользователя
//  Future<void> _fetchCurrentLocation() async {
//    AppLatLong location;
//    const defLocation = MoscowLocation();
//    try {
//      location = await LocationService().getCurrentLocation();
//    } catch (_) {
//      location = defLocation;
//    }
//    _moveToCurrentLocation(location);
//  }
//
//  <--! /// Метод для показа текущей позиции
//  Future<void> _moveToCurrentLocation(
//    AppLatLong appLatLong,
//  ) async {
//    (await mapControllerCompleter.future).moveCamera(
//      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
//      CameraUpdate.newCameraPosition(
//       CameraPosition(
//          target: Point(
//            latitude: appLatLong.lat,
//            longitude: appLatLong.long,
//          ),
//          zoom: 3,
//        ),
//      ),
//    );
//  }
//}

  /// Методы для генерации точек на карте
  /// Музеи, исторические здания (икзампел: Спасская башня, Эрмитаж, Исакиевский собор, ...)
  List<MuseumPoint> _getMapPointsM() {
    return const [

      // Северо-Западный округ

      // республика Коми
      MuseumPoint(name: 'Дом-музей И. П. Морозова' , latitude: 61.67259571967766, longitude: 50.840373498693104),
      MuseumPoint(name: 'Пожарная каланча Сыктывкара', latitude: 61.673001, longitude: 50.837413),
      MuseumPoint(name: 'Национальная галерея Республики Коми' , latitude: 61.66956900, longitude: 50.84247200),
      MuseumPoint(name: 'Национальный музей Республики Коми' , latitude: 61.66909, longitude: 50.83829),
      MuseumPoint(name: 'Кылтовский крестовоздвиженский монастырь', latitude: 62.320529, longitude: 50.994444),
      MuseumPoint(name: 'Археологический памятник Мамонтовая Курья', latitude: 66.607333, longitude: 62.534510),
      MuseumPoint(name: 'Стоянки Бызовая и Крутая Гора', latitude: 64.975556, longitude: 59.528889),
      MuseumPoint(name: 'Свято-Стефановский Кафедральный собор в Сыктывкаре', latitude: 61.677814, longitude: 50.831633),

      // Ненецкий АО
      MuseumPoint(name: 'Музей-заповедник «Пустозерск»', latitude: 67.6413, longitude: 53.0070833),
      MuseumPoint(name: 'Шоинский маяк', latitude: 67.879182, longitude: 44.138176),
      MuseumPoint(name: 'Маяк Ходовариха', latitude: 68.932776, longitude: 53.762628),
      MuseumPoint(name: 'Ненецкий краеведческий музей', latitude: 67.640480, longitude: 53.010441),
      MuseumPoint(name: 'Заброшенный поселок Рудник', latitude: 65.031667, longitude: 53.969167),
      MuseumPoint(name: 'Памятный знак Голова Ленина', latitude: 67.816646, longitude: 34.84826),
      MuseumPoint(name: 'здание администрации Ненецкого АО', latitude: 67.6388917, longitude: 53.0056361),
      MuseumPoint(name: 'здание главпочтамта Ненецкого,  АО', latitude:67.639213562,longitude:53.007827759),
      MuseumPoint(name: 'Памятник «Подвигу участников оленно-транспортных батальонов»', latitude: 67.64, longitude: 53.01056),
      MuseumPoint(name: 'Памятник труженикам Печорского лесозавода', latitude: 67.66982400, longitude: 53.09680900),
      MuseumPoint(name: 'Памятник Яку-7Б', latitude: 67.66982400, longitude: 53.09680900),
      MuseumPoint(name: 'Этнокультурный центр Ненецкого автономного округа', latitude: 67.6404610, longitude: 53.0034470),


      // Архангельская область
      MuseumPoint(name: 'Космодром Плесецк', latitude: 62.96, longitude: 40.68),
      MuseumPoint(name: 'Соловецкий монастырь', latitude: 65.024729, longitude: 35.709728),
      MuseumPoint(name: 'Малые Корелы', latitude: 64.452927, longitude: 40.931691),
      MuseumPoint(name: 'Каргополье', latitude: 55.955556, longitude: 64.433333),
      MuseumPoint(name: 'Историко-мемориальный музей М. В. Ломоносова', latitude: 64.22972, longitude: 41.73361),
      MuseumPoint(name: 'Антониево-Сийский монастырь', latitude: 63.5539, longitude: 41.5560),
      MuseumPoint(name: 'Церковь Иоанна Златоуста в Саунино', latitude: 61.50498, longitude: 39.11612),
      MuseumPoint(name: 'Введенский собор в Сольвычегодске', latitude: 61.3326778, longitude: 46.9263083),
      MuseumPoint(name: 'Северный морской музей', latitude: 64.5339, longitude: 40.5168),
      MuseumPoint(name: 'Новодвинская крепость', latitude: 64.699981, longitude: 40.417537),
      MuseumPoint(name: 'Музей деревянного зодчества «Малые Корелы»', latitude: 64.454843, longitude: 40.951519),
      MuseumPoint(name: 'музей полярного капитана Александра Кучина', latitude: 64.226920, longitude: 41.838274),
      MuseumPoint(name: 'Онежский историко-мемориальный музей', latitude: 63.898530715044, longitude: 38.129629777158),
      MuseumPoint(name: 'Сретено-Михайловская церковь', latitude: 61.59867, longitude: 38.661435),
      MuseumPoint(name: 'Пинежский краеведческий музей', latitude: 64.698563, longitude: 43.394333),
      MuseumPoint(name: 'музей домовых росписей Поважья', latitude: 61.0771610, longitude: 42.1119160),
      MuseumPoint(name: 'Кожеозерский Богоявленский женский монастырь', latitude: 63.1578, longitude: 38.0830),
      MuseumPoint(name: 'Макарьевская Хергозерская пустынь', latitude: 61.8413, longitude: 38.252968),
      MuseumPoint(name: 'Холмогорский краеведческий музей', latitude: 64.22685500, longitude: 41.64560500),
      MuseumPoint(name: 'Каргопольский музей', latitude: 61.502904, longitude: 38.943331),
      MuseumPoint(name: 'Дом Пикуля', latitude: 56.346846, longitude: 43.847955),
      MuseumPoint(name: 'Церковь Троицы Живоначальной в Ухте', latitude: 61.193259, longitude: 38.567944),

      // Вологодская область
      MuseumPoint(name: 'Кирилло-Белозерский монастырь', latitude: 59.856507, longitude: 38.369435),
      MuseumPoint(name: 'Вологодский кремль', latitude: 59.224117, longitude: 39.881791),
      MuseumPoint(name: 'Ферапонтов Белозерский монастырь', latitude: 59.956496, longitude: 38.567472),
      MuseumPoint(name: 'Картуши в Тотьме', latitude: 59.9737800, longitude: 42.7651610),
      MuseumPoint(name: 'Белозерский кремль', latitude: 60.030953, longitude: 37.788606),
      MuseumPoint(name: 'Соборное дворище', latitude: 60.7608, longitude: 46.2972),
      MuseumPoint(name: 'Троице-Гледенский монастырь', latitude: 60.7177111, longitude: 46.3137944),
      MuseumPoint(name: 'Архитектурно-этнографический музей «Семёнково»', latitude: 59.2786646119338, longitude: 39.715944191154456),
      MuseumPoint(name: 'Музей кружева в Вологде', latitude: 59.223904, longitude: 39.884875),
      MuseumPoint(name: 'Усадьба Брянчаниновых', latitude: 59.0344806, longitude: 39.9564944),
      MuseumPoint(name: 'Усадьба Хвалёвское', latitude: 58.983371, longitude: 36.583570),
      MuseumPoint(name: 'Усадьба Батюшковых', latitude: 58.715111, longitude: 36.443694),
      MuseumPoint(name: 'Усадьба Галльских', latitude: 59.603530, longitude: 29.664780),
      MuseumPoint(name: 'Спасо-Прилуцкий монастырь', latitude: 59.2622008, longitude: 39.8895258),
      MuseumPoint(name: 'Воскресенский собор в Череповце', latitude: 59.119157, longitude: 37.92845),
      MuseumPoint(name: 'Горицкий Воскресенский монастырь', latitude: 59.864434, longitude: 38.261440),
      MuseumPoint(name: 'Дом-музей Петра I', latitude: 59.20998500, longitude: 39.90819100),
      MuseumPoint(name: 'Музей «Вологодская ссылка»', latitude: 59.215811, longitude: 39.884481),
      MuseumPoint(name: 'Музей металлургической промышленности', latitude: 59.133528533158405, longitude: 37.84594819858926),
      MuseumPoint(name: 'Музей «Подводная лодка Б-440»', latitude: 60.998236, longitude: 36.433181),
      MuseumPoint(name: 'Дом Засецких', latitude: 59.22389, longitude: 39.87639),
      MuseumPoint(name: 'Дом-музей А. Ф. Можайского', latitude: 59.199151, longitude: 39.904215),
      MuseumPoint(name: 'Успенская Нелазская церковь', latitude: 59.189056, longitude: 37.64331),
      MuseumPoint(name: 'Ферапонтов монастырь', latitude: 59.956664, longitude: 38.567499),
      MuseumPoint(name: 'Зелёная планета ФосАгро', latitude: 59.1507, longitude: 37.8271),
      MuseumPoint(name: 'Камерный театр в Череповце', latitude: 59.124694824, longitude: 37.929988861),
      MuseumPoint(name: 'музей «Дом И. А. Милютина»', latitude: 37.925378, longitude: 59.118698),
      MuseumPoint(name: 'Кузница мастера', latitude: 58.84296487482654, longitude: 36.43453240211713),
      MuseumPoint(name: 'Казанская церковь в Устюжне', latitude: 58.839003, longitude: 36.457081),
      MuseumPoint(name: 'Церковь Благовещения Пресвятой Богородицы в Устюжне', latitude: 58.840284, longitude: 36.429612),
      MuseumPoint(name: 'краеведческий музей в Тотьме', latitude: 59.9758, longitude: 42.7631),
      MuseumPoint(name: 'Музей мореходов в Тотьме', latitude: 59.975255, longitude: 42.751762),
      MuseumPoint(name: 'Музей церковной старины в Тотьме', latitude: 59.9697310, longitude: 42.7647240),
      MuseumPoint(name: 'храм Троицы в Зеленской слободе', latitude: 59.968014, longitude: 42.753133),
      MuseumPoint(name: 'храм Рождества Христова в Тотьме', latitude: 59.974744, longitude: 42.754385),
      MuseumPoint(name: 'храмовый комплекс Соборного дворища в Великом Устюге', latitude: 60.76052, longitude: 46.298348),
      MuseumPoint(name: 'Михайло-Архангельский монастырь в Великом Устюге', latitude: 62.223279, longitude: 50.399606),
      MuseumPoint(name: 'Музей новогодней и рождественской игрушки', latitude: 60.7530, longitude: 46.3117),

      // Мурманская область
      MuseumPoint(name: 'Кольская сверхглубокая скважина', latitude: 69.396326, longitude: 30.609513),
      MuseumPoint(name: 'Святоносский маяк', latitude: 68.13611, longitude: 39.76944),
      MuseumPoint(name: 'Маяк-мемориал в Мурманске', latitude: 68.970663, longitude: 33.074918),
      MuseumPoint(name: 'Музей ВВС Северного флота', latitude: 69.065369, longitude: 33.294752),
      MuseumPoint(name: 'Музейно-выставочный центр «Апатит»', latitude: 67.61574353, longitude: 33.66614054),
      MuseumPoint(name: 'Никольская деревянная церковь в Ковде', latitude: 68.994722, longitude: 33.072222),
      MuseumPoint(name: 'Заброшенный ж/д вокзал Кировска', latitude: 67.619694, longitude: 33.669787),
      MuseumPoint(name: 'Наскальные изображения у поселка Чалмны-Варрэ', latitude: 67, longitude: 37.5892356),

      // Карелия
      MuseumPoint(name: 'Национальный музей Республики Карелия', latitude: 61.786944, longitude: 34.363889),
      MuseumPoint(name: 'Музей изобразительных искусств Республики Карелия', latitude: 61.787778, longitude: 34.382222),
      MuseumPoint(name: 'Музей-заповедник «Кижи»', latitude: 62.084948, longitude: 35.212189),
      MuseumPoint(name: 'Валаамский монастырь', latitude: 61.388859, longitude: 30.944827),
      MuseumPoint(name: 'Городище Паасо', latitude: 61.731904, longitude: 30.699716),
      MuseumPoint(name: 'Кирха в Лумиваара', latitude: 61.433399, longitude: 30.140094),
      MuseumPoint(name: 'Военный комплекс «Гора Филина»', latitude: 61.548857, longitude: 30.199141),
      MuseumPoint(name: 'Шелтозерский вепсский этнографический музей', latitude: 61.3687, longitude: 35.358),
      MuseumPoint(name: 'Государственный Национальный театр Республики Карелия', latitude: 61.787483215, longitude: 34.379283905),
      MuseumPoint(name: 'Шелтозерский вепсский этнографический музей', latitude: 61.3687, longitude: 35.358),
      MuseumPoint(name: 'Муромский монастырь', latitude: 61.483, longitude: 36.250),
      MuseumPoint(name: 'Морской музей «Полярный Одиссей»', latitude: 61.779906, longitude: 34.415936),
      MuseumPoint(name: 'Богоявленская церковь в селе Челмужи', latitude: 62.578435, longitude: 35.576927),
      MuseumPoint(name: 'Культурно-выставочный центр имени Гоголева К.А.', latitude: 61.685649, longitude: 30.666233),
      MuseumPoint(name: 'Успенская церковь в Кондопоге', latitude: 62.175601, longitude: 34.286241),

      // Ленинградская область
      MuseumPoint(name: 'Фондовая площадка списанных поездов «Пионерский парк»', latitude: 59.953224, longitude: 29.399258),
      MuseumPoint(name: 'Башня инженера Инка', latitude: 59.661065, longitude: 30.242052),
      MuseumPoint(name: 'Усадьба купца Елисеева', latitude: 59.350820, longitude: 30.128605),
      MuseumPoint(name: 'Крепость Орешек', latitude: 59.95368, longitude: 31.03878),
      MuseumPoint(name: 'Маяк Толбухин', latitude: 60.0423889, longitude: 29.5420389),
      MuseumPoint(name: 'Останки церкви Святой Троицы', latitude: 59.443242, longitude: 29.754066),
      MuseumPoint(name: 'Девонская церковь', latitude: 53.827725, longitude: 30.388581),
      MuseumPoint(name: 'Волковицкая башня', latitude: 59.644676, longitude: 29.835482),
      MuseumPoint(name: 'Музей-диорама «Прорыв блокады Ленинграда»', latitude: 59.908545, longitude: 30.994313),
      MuseumPoint(name: 'Красногвардейский Укрепрайон', latitude: 59.635994, longitude: 30.033755),
      MuseumPoint(name: 'Форт Красная Горка', latitude: 59.973362, longitude: 29.327877),
      MuseumPoint(name: 'Мемориал «Разорванное кольцо»', latitude: 60.081502, longitude: 31.067323),
      MuseumPoint(name: 'Музей-усадьба Репина «Пенаты»', latitude: 60.155808, longitude: 29.896564),
      MuseumPoint(name: 'Крепость Корела', latitude: 61.029793, longitude: 30.122838),
      MuseumPoint(name: 'Парковый комплекс «Усадьба Богословка»', latitude: 59.8267166, longitude: 30.5689045),
      MuseumPoint(name: 'Ропшинский дворец', latitude: 59.7236111, longitude: 29.8605611),
      MuseumPoint(name: 'Музей-усадьба Ганнибалов', latitude: 59.603530, longitude: 29.664780),
      MuseumPoint(name: 'Музей «Дом станционного смотрителя»', latitude: 59.347889, longitude: 29.958528),
      MuseumPoint(name: 'Домик Няни Пушкина', latitude: 59.4280556, longitude: 30.1149999),
      MuseumPoint(name: 'Родовая усадьба Римских-Корсаковых', latitude: 55.491388889, longitude: 28.460833333),
      MuseumPoint(name: 'Приоратский дворец', latitude: 59.558318, longitude: 30.121296),
      MuseumPoint(name: 'Большой гатчинский дворец', latitude: 59.5632, longitude: 30.1074),
      MuseumPoint(name: 'Родовое имение Строгановых-Голицыных – усадьба Марьино', latitude: 59.41806, longitude: 30.90278),
      MuseumPoint(name: 'Музей-усадьба «Рождествено»', latitude: 59.3251, longitude: 29.9359),
      MuseumPoint(name: 'Музей-усадьба Приютино', latitude: 60.03068924, longitude: 30.655017853),
      MuseumPoint(name: 'Музей-дача А. С. Пушкина', latitude: 59.724167095570365, longitude: 30.400052998613187),
      MuseumPoint(name: 'Колоннада Аполлона', latitude: 59.6861959, longitude: 30.4432397),
      MuseumPoint(name: 'Кирха Святой Марии Магдалины', latitude: 60.36444, longitude: 28.60583),
      MuseumPoint(name: 'Маяк-усадьба', latitude: 54.8824, longitude: 26.8616),

      // Санкт-Петербург
      MuseumPoint(name: 'Исаакиевский собор', latitude: 59.933694, longitude: 30.3061425),
      MuseumPoint(name: 'Эрмитаж', latitude: 59.939844, longitude: 30.314557),
      MuseumPoint(name: 'Медный всадник', latitude: 59.9363783, longitude: 30.3022304),
      MuseumPoint(name: 'Кунсткамера', latitude: 59.9414967, longitude: 30.3045327),
      MuseumPoint(name: 'Собор Спаса-на-Крови', latitude: 59.940037, longitude: 30.328930),
      MuseumPoint(name: 'Русский музей', latitude: 59.9385918, longitude: 30.3322212),
      MuseumPoint(name: 'Крейсер «Аврора»', latitude: 59.9554045, longitude: 30.337833),
      MuseumPoint(name: 'Адмиралтейство', latitude: 59.9374583, longitude: 30.30855),
      MuseumPoint(name: 'Михайловский замок', latitude: 59.9399937, longitude: 30.3380463),
      MuseumPoint(name: 'Магазин купцов Елисеевых', latitude: 59.934263, longitude: 30.337982),
      MuseumPoint(name: 'Дом Зингера', latitude: 59.935667, longitude: 30.325917),
      MuseumPoint(name: 'Александро-Невская лавра', latitude: 59.922301, longitude: 30.387454),
      MuseumPoint(name: 'Морской Никольский собор в Кронштадте', latitude: 59.991672, longitude: 29.777801),
      MuseumPoint(name: 'Музей современного искусства Эрарта', latitude: 59.932029, longitude: 30.251525),
      MuseumPoint(name: 'Аптека Пеля и Башня грифонов', latitude: 59.93833, longitude: 30.28384),
      MuseumPoint(name: 'Петербург в миниатюре', latitude: 59.9386, longitude: 30.3141),
      MuseumPoint(name: 'Музей теней', latitude: 59.9403952, longitude: 30.3238216),
      MuseumPoint(name: 'Мемориальный музей Достоевского', latitude: 59.9270826, longitude: 30.3505176),
      MuseumPoint(name: 'Гранд макет «Россия»', latitude: 59.88741100, longitude: 30.32998900),
      MuseumPoint(name: 'Музей Фаберже', latitude: 59.93444, longitude: 30.34306),
      MuseumPoint(name: 'Музей обороны и блокады Ленинграда', latitude: 59.944444, longitude: 30.340833),
      MuseumPoint(name: 'Музей самоизоляции', latitude: 55.797661, longitude: 49.106815),
      MuseumPoint(name: 'Главный штаб', latitude: 59.939043, longitude: 30.318658),
      MuseumPoint(name: 'Смольный', latitude: 59.9461973, longitude: 30.3968174),
      MuseumPoint(name: 'Смольный собор', latitude: 59.94890700, longitude: 30.395608),
      MuseumPoint(name: 'Памятник Виктору Цою', latitude: 59.842056, longitude: 30.246088),
      MuseumPoint(name: 'Котельная «Камчатка»', latitude: 59.95206100, longitude: 30.30082900),
      MuseumPoint(name: 'Кронштадтский морской собор', latitude: 59.998584507713, longitude: 29.779331199833965),
      MuseumPoint(name: 'Домик Петра I', latitude: 59.953333, longitude: 30.330833),
      MuseumPoint(name: 'Здание двенадцати коллегий', latitude: 59.94001, longitude: 30.30119),
      MuseumPoint(name: 'Особняк Кшесинской', latitude: 59.9546056, longitude: 30.324583),
      MuseumPoint(name: 'Витебский вокзал', latitude: 59.9199219, longitude: 30.3288956),
      MuseumPoint(name: 'Юсуповский дворец', latitude: 59.927984, longitude: 30.30019),
      MuseumPoint(name: 'Памятник Екатерине II', latitude: 59.9333, longitude: 30.3369),
      MuseumPoint(name: 'Музей Пушкина на Мойке', latitude: 59.941209, longitude: 30.32124),
      MuseumPoint(name: 'Консерватория имени Н.А. Римского-Корсакова', latitude: 59.92583, longitude: 30.29806),
      MuseumPoint(name: 'Академия художеств', latitude: 59.93749400, longitude: 30.29020500),
      MuseumPoint(name: 'Малый Эрмитаж', latitude: 59.9412470, longitude: 30.3157100),
      MuseumPoint(name: 'Новый Эрмитаж', latitude: 59.939844, longitude: 30.314557),
      MuseumPoint(name: 'Инженерный замок', latitude: 59.940371, longitude: 30.337798),
      MuseumPoint(name: 'Воронцовский дворец', latitude: 59.93139, longitude: 30.33194),
      MuseumPoint(name: 'Строгановский дворец', latitude: 59.9357046, longitude: 30.320118),
      MuseumPoint(name: 'Ледовый дворец', latitude: 59.921670, longitude: 30.466390),
      MuseumPoint(name: 'Большой драматический театр', latitude: 59.927612, longitude: 30.330654),
      MuseumPoint(name: 'Ростральные колонны', latitude: 59.94389, longitude: 30.30583),
      MuseumPoint(name: 'Военно-исторический музей артиллерии, инженерных войск и войск связи', latitude: 59.9539, longitude: 30.3138),
      MuseumPoint(name: 'Михайловский театр', latitude: 9.9378647, longitude: 30.3291268),
      MuseumPoint(name: 'Эрмитажный театр', latitude: 59.94222600, longitude: 30.31812900),
      MuseumPoint(name: 'Здания Сената и Синода', latitude: 59.93528, longitude: 30.30139),
      MuseumPoint(name: 'Большой зал Филармонии', latitude: 59.9354121, longitude: 30.3281706),
      MuseumPoint(name: 'Московский вокзал', latitude: 59.9281401, longitude: 30.3626595),
      MuseumPoint(name: 'Мраморный дворец', latitude: 59.9451172, longitude: 30.3266928),
      MuseumPoint(name: 'Дворец Бобринских' , latitude: 59.93021761, longitude: 30.28525753),
      MuseumPoint(name: 'Чесменская церковь', latitude: 59.85697, longitude: 30.33093),
      MuseumPoint(name: 'Московские триумфальные ворота', latitude: 59.8914, longitude: 30.3194),

      // Новгородская область
      MuseumPoint(name: 'Новгородский детинец', latitude: 58.521667, longitude: 31.276111),
      MuseumPoint(name: 'Музей деревянного зодчества «Витославлицы»', latitude: 58.49153, longitude: 31.272311),
      MuseumPoint(name: 'Валдайский Иверский монастырь', latitude: 57.989356, longitude: 33.301665),
      MuseumPoint(name: 'Дом-музей Федора Достоевского', latitude: 59.9270826, longitude: 30.3505176),
      MuseumPoint(name: 'Музейный комплекс «Славянская деревня Х века»', latitude: 58.812776, longitude: 33.371713),
      MuseumPoint(name: 'Музей-усадьба Александра Суворова', latitude: 58.652958, longitude: 34.066157),
      MuseumPoint(name: 'Музей колоколов в Валдае', latitude: 57.96764900, longitude: 33.25003600),
      MuseumPoint(name: 'Урочище Перынь', latitude: 58.47315400, longitude: 31.2732320),
      MuseumPoint(name: 'Дом-музей Некрасова «Чудовская Лука»', latitude: 59.117583, longitude: 31.662985),
      MuseumPoint(name: 'Свято-Юрьев монастырь', latitude: 58.486606, longitude: 31.284708),
      MuseumPoint(name: 'Храм Спаса Преображения в Великом Новгороде', latitude: 58.517455, longitude: 31.295528),
      MuseumPoint(name: 'Антониев монастырь', latitude: 58.539847, longitude: 31.286794),
      MuseumPoint(name: 'Знаменский собор в Великом Новгороде', latitude: 58.51714, longitude: 31.294483),
      MuseumPoint(name: 'Варлаамо-Хутынский монастырь', latitude: 58.5876, longitude: 31.394),
      MuseumPoint(name: 'Николо-Вяжищский монастырь', latitude: 58.622801, longitude: 31.168758),
      MuseumPoint(name: 'Спасо-Преображенский монастырь в Старой Руссе', latitude: 57.99411, longitude: 31.3603),
      MuseumPoint(name: 'Воскресенский собор в Старой Руссе', latitude: 57.987951, longitude: 31.352792),
      MuseumPoint(name: 'Дом-музей Глеба Успенского в деревне Сябреницы', latitude: 59.138172, longitude: 31.625099),
      MuseumPoint(name: 'Музей Северо-Западного фронта в Старой Руссе', latitude: 57.992706, longitude: 31.363169),
      MuseumPoint(name: 'Музей уездного города в Валдае', latitude: 57.977625, longitude: 33.256659),

      // Псковская область
      MuseumPoint(name: 'Псковский Кремль', latitude: 57.8220008, longitude: 28.3289796),
      MuseumPoint(name: 'Псково-Печерский монастырь', latitude: 57.8100631, longitude: 27.6149939),
      MuseumPoint(name: 'Музей-усадьба «Михайловское»', latitude: 56.25670200, longitude: 31.34997700),
      MuseumPoint(name: 'Музей-усадьба «Петровское»', latitude: 57.07988700, longitude: 28.948374),
      MuseumPoint(name: 'Музей-усадьба «Тригорское»', latitude: 57.16305700, longitude: 28.839111),
      MuseumPoint(name: 'Палаты Меньшиковых в Пскове', latitude: 57.812261, longitude: 28.335448),
      MuseumPoint(name: 'Великолукская крепость', latitude: 56.342690, longitude: 30.507225),
      MuseumPoint(name: 'Музей-заповедник Н. А. Римского-Корсакова', latitude: 58.39944, longitude: 29.60222),
      MuseumPoint(name: 'Музей-заповедник М. П. Мусоргского', latitude: 56.27222, longitude: 31.32528),
      MuseumPoint(name: 'Музей-усадьба С. Ковалевской', latitude: 56.133437, longitude: 30.399968),
      MuseumPoint(name: 'Мирожский монастырь', latitude: 57.805167, longitude: 28.329288),
      MuseumPoint(name: 'Церковь Василия Великого на Горке', latitude: 57.815225, longitude: 28.335785),
      MuseumPoint(name: 'Гдовский кремль', latitude: 56.567222, longitude: 28.775),
      MuseumPoint(name: 'Спасо-Казанский Симанский монастырь', latitude: 57.338567, longitude: 28.3643),
      MuseumPoint(name: 'Музей-усадьба народа Сето', latitude: 57.7513, longitude: 27.6346),
      MuseumPoint(name: 'Ольгинская часовня', latitude: 57.820029, longitude: 28.324886),

      // Калининградская область
      MuseumPoint(name: 'Замок Шаакен', latitude: 54.90583, longitude: 20.66889),
      MuseumPoint(name: 'Музей «Вальдавский замок»', latitude: 54.700544, longitude: 20.742786),
      MuseumPoint(name: 'Маяк Лабагинена', latitude: 54.901414, longitude: 21.058136),
      MuseumPoint(name: 'Замок Георгенбург', latitude: 54.660477, longitude: 21.80667),
      MuseumPoint(name: 'Замок Прейсиш-Эйлау', latitude: 54.386605, longitude: 20.632886),
      MuseumPoint(name: 'Замок Гердауэн', latitude: 54.364502, longitude: 21.309507),
      MuseumPoint(name: 'Музей «Средневековое городище Ушкуй»', latitude: 54.471680, longitude: 21.066061),
      MuseumPoint(name: 'Музей «Поселение викингов Кауп»', latitude: 54.878422, longitude: 20.278862),
      MuseumPoint(name: 'Музей филинов и сов «ФилоСовия»', latitude: 54.956090, longitude: 20.477775),
      MuseumPoint(name: 'Музей «Старая немецкая школа Вальдвинкель»', latitude: 54.867357, longitude: 21.248785),
      MuseumPoint(name: 'Музей пыток в Орловке', latitude: 54.793098, longitude: 20.533545),
      MuseumPoint(name: 'Музей кошек «Мурариум» в Зеленоградске', latitude: 54.959795, longitude: 20.482545),
      MuseumPoint(name: 'Кирха Эйдткунена', latitude: 54.639885, longitude: 22.73345),
      MuseumPoint(name: 'Кирха святой Барбары', latitude: 54.891268, longitude: 20.564462),
      MuseumPoint(name: 'Кирха Святого Якоба', latitude: 54.618200, longitude: 21.231529),
      MuseumPoint(name: 'Кирха Куменена', latitude: 54.820339, longitude: 20.212478),

      // Сибирь

      // Омская область
      MuseumPoint(name: 'Государственный литературный музей им. Ф. М. Достоевского', latitude: 54.983603, longitude: 73.368796),
      MuseumPoint(name: 'Кафедральный собор Успения Божией Матери', latitude: 54.990158, longitude: 73.366838),
      MuseumPoint(name: 'Музей изобразительных искусств им. М. А. Врубеля', latitude: 54.988319, longitude: 73.372606),
      MuseumPoint(name: 'Городской музей «Искусство Омска»', latitude: 54.98587, longitude: 73.364445),
      MuseumPoint(name: 'Ачаирский женский монастырь', latitude: 54.665662, longitude: 73.817262),
      MuseumPoint(name: 'Никольский Казачий собор', latitude: 54.977629, longitude: 73.379411),
      MuseumPoint(name: '«Эрмитаж-Сибирь»', latitude: 54.985073, longitude: 73.372856),
      MuseumPoint(name: 'Воскресенский военный собор', latitude: 54.985262, longitude: 73.367017),
      MuseumPoint(name: 'Музей просвещения', latitude: 54.985748, longitude: 73.37254),
      MuseumPoint(name: 'Собор Воздвижения Креста Господня', latitude: 54.997206, longitude: 73.368645),
      MuseumPoint(name: 'Государственный историко-краеведческий музей', latitude: 54.980086, longitude: 73.378352),
      MuseumPoint(name: 'Крепость', latitude: 54.989347, longitude: 73.368221),
      MuseumPoint(name: 'Пожарная каланча', latitude: 54.991328, longitude: 73.37074),
      MuseumPoint(name: 'Особняк купца Батюшкова', latitude: 54.975086, longitude: 73.378022),
      MuseumPoint(name: 'Музей воинской славы омичей', latitude: 54.984455, longitude: 73.366188),
      MuseumPoint(name: 'Кафедральный собор Рождества Христова', latitude: 54.994149, longitude: 73.290865),
      MuseumPoint(name: 'Дом художника', latitude: 54.981351, longitude: 73.376204),
      MuseumPoint(name: 'Художественный музей «Либеров-центр»', latitude: 54.983728, longitude: 73.382625),
      MuseumPoint(name: 'Музей Кондратия Белова', latitude: 54.974517, longitude: 73.38057),
      MuseumPoint(name: 'Историко-культурный комплекс «Старина Сибирская»', latitude: 56.096102, longitude: 74.642265),

      // республика Алтай
      MuseumPoint(name: 'Музей-усадьба Григория Ивановича Чорос-Гуркина', latitude: 51.5012, longitude: 85.9419),
      MuseumPoint(name: 'Палеопарк', latitude: 51.4915, longitude: 85.9805),
      MuseumPoint(name: 'Национальный музей имени А.В. Анохина', latitude: 51.9564, longitude: 85.9464),
      MuseumPoint(name: 'Музей Чуйского, latitude: тракта', latitude: 52.5391, longitude: 85.2230),
      MuseumPoint(name: 'Памятник шофёру Кольке Снегирёву', latitude: 50.3529, longitude: 87.0558),
      MuseumPoint(name: 'Дом-музей Николая Рериха', latitude: 50.2140, longitude: 85.7429),

      // Алтайский край
      MuseumPoint(name: 'Музей Г.С. Титова', latitude: 53.215645, longitude: 84.636490),
      MuseumPoint(name: 'Музей М.Т. Калашникова', latitude: 56.850742, longitude: 53.206720),
      MuseumPoint(name: 'Музей-заповедник В.М. Шукшина', latitude: 52.42353, longitude: 85.707096),
      MuseumPoint(name: 'Музей-панорама Алтай', latitude: 52.4269, longitude: 85.5701),
      MuseumPoint(name: 'Музей истории камнерезного дела', latitude: 56.839192, longitude: 60.606957),
      MuseumPoint(name: 'Коробейниковский монастырь', latitude: 52.188691, longitude: 83.693178),
      MuseumPoint(name: 'Знаменский монастырь', latitude: 53.327585, longitude: 83.796278),
      MuseumPoint(name: 'Историко-архитектурный комплекс Андреевская слобода', latitude: 51.954003, longitude: 84.883513),

      // Иркутская область

      MuseumPoint(name: 'Музей «Тальцы»', latitude: 51.996414, longitude: 104.664236),
      MuseumPoint(name: 'Кругобайкальская железная дорога', latitude: 51.729483, longitude: 103.726433),
      MuseumPoint(name: 'Музей «Ангарская деревня»', latitude: 56.221760, longitude: 101.681152),
      MuseumPoint(name: 'Байкальская астрофизическая обсерватория', latitude: 51.846472, longitude: 104.891889),
      MuseumPoint(name: 'Памятник Александру III', latitude: 52.275556, longitude: 104.277222),
      MuseumPoint(name: ' краеведческий музей ', latitude: 52.2757990, longitude: 104.2781010),
      MuseumPoint(name: ' Памятник основателям Иркутска ', latitude: 52.292534, longitude: 104.28171),
      MuseumPoint(name: 'Памятник Турист ', latitude: 52.28436, longitude: 104.288101),
      MuseumPoint(name: 'Памятник адмиралу Александру Колчаку', latitude: 52.3, longitude: 104.295),
      MuseumPoint(name: ' Братская ГЭС', latitude: 56.28611, longitude: 101.78417),

      // Кемеровская область
      MuseumPoint(name: 'Этнографический музей «Тазгол»', latitude: 53.051177, longitude: 88.415015),
      MuseumPoint(name: 'Скульптура "Колыбель"', latitude: 55.358868, longitude: 86.083754),
      MuseumPoint(name: 'Скульптурная композиция "В 6 часов вечера после войны..."', latitude: 55.355453, longitude: 86.081812),
      MuseumPoint(name: 'Скульптурная композиция "Земля Кузнецкая"', latitude: 55.352525, longitude: 86.080589),
      MuseumPoint(name: '"Мост влюбленных"', latitude: 55.349439, longitude: 86.077362),
      MuseumPoint(name: 'Скульптурная композиция "Дружба народов"', latitude: 55.354507, longitude: 86.081023),
      MuseumPoint(name: 'Памятник рудознатцу Михайло Волкову', latitude: 55.348117, longitude: 86.075645),
      MuseumPoint(name: 'Мемориал славы воинов кузбассовцев', latitude: 55.35831, longitude: 86.05974),
      MuseumPoint(name: 'Скульптура "Бездомный пёс"', latitude: 55.359554, longitude: 86.087252),
      MuseumPoint(name: 'Скульптура "Драгоценная бабушка"', latitude: 55.360731, longitude: 86.085041),
      MuseumPoint(name: 'Скультура "От улыбки..."', latitude: 55.359966, longitude: 86.086227),
      MuseumPoint(name: 'Памятник реке "Томь"', latitude: 55.357048, longitude: 86.09223),
      MuseumPoint(name: 'Скульптура Философ', latitude: 55.357048, longitude: 86.09223),
      MuseumPoint(name: 'Памятник простому рабочему', latitude: 55.356514, longitude: 86.092116),
      MuseumPoint(name: 'Памятник хоккейному мячу', latitude: 55.355816, longitude: 86.074227),
      MuseumPoint(name: 'Скульптура "Модница"', latitude: 55.334893, longitude: 86.174836),
      MuseumPoint(name: 'Памятник Алексею Архиповичу Леонову', latitude: 55.357104, longitude: 86.082212),
      MuseumPoint(name: 'Памятник В. Д Мартемьянову', latitude: 55.361752, longitude: 86.083027),
      MuseumPoint(name: 'Памятник Г. К. Орджоникидзе', latitude: 55.358484, longitude: 86.079686),
      MuseumPoint(name: 'Парк Ангелов', latitude: 55.343693, longitude: 86.077965),
      MuseumPoint(name: 'Церковь Святой Троицы', latitude: 55.34584, longitude: 86.18166),
      MuseumPoint(name: 'Кемеровский областной краеведческий музей', latitude: 55.3565, longitude: 86.08051),


      // Красноярский край
      MuseumPoint(name: 'Красноярский художественный музей им. В.М. Сурикова', latitude: 6.011288, longitude: 92.881615),
      MuseumPoint(name: 'Красноярский краевой краеведческий музей', latitude: 56.007076, longitude: 92.87443),
      MuseumPoint(name: 'Арт-галерея Романовых', latitude: 55.997, longitude: 92.9296),
      MuseumPoint(name: 'Музей-усадьба Г.В. Юдина', latitude: 55.99613588296133, longitude: 92.80885099846493),
      MuseumPoint(name: 'Музей геологии Центральной Сибири', latitude: 56.032055, longitude: 92.922402),
      MuseumPoint(name: 'Музей-усадьба В.И. Сурикова', latitude: 56.013192°, longitude: 92.862019),
      MuseumPoint(name: 'Шестаков-Реставрация', latitude: 55.9941, longitude: 92.9068),
      MuseumPoint(name: 'Музей меда и этнографии', latitude: 53.368055556, longitude: 24.170277778),
      MuseumPoint(name: 'Ньютон Парк', latitude: 56.0105880, longitude: 92.8935620),
      MuseumPoint(name: 'Музей леса Красноярского края', latitude: 55.9885010, longitude: 92.7668730),
      MuseumPoint(name: 'Тасеевский краеведческий музей', latitude: 57.202622, longitude: 94.888199),


      // Новосибирская область
      MuseumPoint(name: 'Умревинский острог', latitude: 55.573704, longitude: 83.595186),
      MuseumPoint(name: 'Шипуновский мраморный карьер', latitude: 54.602640, longitude: 83.344840),
      MuseumPoint(name: 'Курганный комплекс Быстровка', latitude: 54.53870908854932, longitude: 82.58233929756462),
      MuseumPoint(name: 'Палеонтологический памятник природы Волчья грива', latitude: 54.40, longitude: 80.17),
      MuseumPoint(name: 'Городище Чичабург', latitude: 54.705833, longitude: 78.590000),
      MuseumPoint(name: 'Умревинский острог', latitude: 55.57559303386144, longitude: 83.5959165257112),
      MuseumPoint(name: 'Источник Святой ключ', latitude: 54.5742262726708, longitude: 83.35433333913059),
      MuseumPoint(name: 'Музей железнодорожной техники', latitude: 54.868637, longitude: 83.076014),
      MuseumPoint(name: 'Народный музей "Танкоград" под Новосибирском', latitude: 55.1586, longitude: 61.4680),
      MuseumPoint(name: 'Музей мировой погребальной культуры', latitude: 55.028739, longitude: 82.906928),



      // Томская область
      MuseumPoint(name: ' Усадьба Шишкова', latitude: 56.296495, longitude: 85.419978),
      MuseumPoint(name: 'Музей «Профессорская квартира»', latitude: 84.955199, longitude: 56.467354),
      MuseumPoint(name: 'Театр живых кукол «2+Ку»', latitude: 56.457154, longitude: 84.941917),
      MuseumPoint(name: 'Памятник «Щас спою…»', latitude: 56.477905, longitude: 84.991612),
      MuseumPoint(name: 'Лютеранская церковь святой Марии', latitude: 56.46935806, longitude: 84.96171611),
      MuseumPoint(name: 'Особняк архитектора С. В. Хомича', latitude: 56.47112, longitude: 84.95752),
      MuseumPoint(name: 'Дом с жар-птицами', latitude: 56.471075, longitude: 84.964732),
      MuseumPoint(name: 'Томский областной Российско-Немецкий Дом', latitude: 56.4696670, longitude: 84.9646640),
      MuseumPoint(name: 'Томский областной художественный музей', latitude: 56.48278, longitude: 84.94722),
      MuseumPoint(name: 'Томский областной краеведческий музей им. М.Б. Шатилова', latitude: 56.476551056, longitude: 84.950813293),
      MuseumPoint(name: 'Первый музей славянской мифологии', latitude: 56.48882311466737, longitude: 84.95424397666324),
      MuseumPoint(name: 'Музей истории Томска', latitude: 56.48891800, longitude: 84.952809),
      MuseumPoint(name: 'Дом с драконами', latitude: 56.472272, longitude: 84.966002),
      MuseumPoint(name: 'Кафедральный Богоявленский собор', latitude: 56.488577, longitude: 84.947249),
      MuseumPoint(name: 'Богородице-Алексеевский мужской монастырь', latitude: 56.481534, longitude: 84.955742),
      MuseumPoint(name: 'Томский областной театр драмы', latitude: 56.48769800, longitude: 84.94738),
      MuseumPoint(name: 'Музей деревянного зодчества', latitude: 56.466191, longitude: 84.956264),
      MuseumPoint(name: '«Усадьба Н.А. Лампсакова»', latitude: 57.058236, longitude: 86.044077),


      // республика Тыва
      MuseumPoint(name: 'Крепость Пор-Бажын', latitude: 50.615124, longitude: 97.384937),
      MuseumPoint(name: 'Монастырь Устуу-Хурээ', latitude: 51.257327, longitude: 91.656588),
      MuseumPoint(name: 'Алдын-Булак', latitude: 51.553458, longitude: 93.887711),
      MuseumPoint(name: 'Часовня Саска', latitude: 51.576182, longitude: 92.393910),
      MuseumPoint(name: 'Буддийская ниша Суме', latitude: 61.6584, longitude: 92.428187),
      MuseumPoint(name: 'Буддийский храм Цеченлинг', latitude: 51.723755, longitude: 94.450597),
      MuseumPoint(name: 'Драматический театр имени Виктора Кёк-оола', latitude: 51.720028, longitude: 94.439329),
      MuseumPoint(name: 'Музей Нади Рушевой', latitude: 51.721524, longitude: 94.450028),
      MuseumPoint(name: 'Национальный музей имени Алдан Маадыр', latitude: 51.719077, longitude: 94.429339),
      MuseumPoint(name: 'Национальный парк культуры и отдыха Республики Тыва', latitude: 51.723534, longitude: 94.461193),
      MuseumPoint(name: 'Обелиск «Центр Азии»', latitude: 51.724907, longitude: 94.443610),
      MuseumPoint(name: 'Памятник Кадарчы', latitude: 51.654699, longitude: 94.432915),
      MuseumPoint(name: 'Площадь Победы', latitude: 51.722500, longitude: 94.452600),
      MuseumPoint(name: 'Площадь Арата', latitude: 51.720068, longitude: 94.438655),
      MuseumPoint(name: 'Кызыл-Мажалыкский филиал Национального музея', latitude: 51.14920, longitude: 90.57640),
      MuseumPoint(name: 'Музей имени Сафьяновых в г. Туране', latitude: 52.14511, longitude: 93.92124),
      MuseumPoint(name: 'Кочетовский историко-мемориальный комплекс', latitude: 51.34312, longitude: 94.06124),
      MuseumPoint(name: 'Церковь Иннокентия, епископа Иркутского', latitude: 52.15007, longitude: 93.92453),
      MuseumPoint(name: 'Сарыг-Сепский историко-мемориальный музей', latitude: 51.50057, longitude: 95.53919),
      MuseumPoint(name: 'Чадаанский филиал Национального музея', latitude: 51.28401, longitude: 91.56525),


      // республика Хакасия
      MuseumPoint(name: 'Крепость Чебаки', latitude: 54.628889, longitude: 89.250278),
      MuseumPoint(name: 'Боярская писаница', latitude: 54.291584, longitude: 91.188234),
      MuseumPoint(name: 'Сулекская писаница', latitude: 54.967894, longitude: 89.582704),
      MuseumPoint(name: 'Малоарбатская писаница', latitude: 52.653923, longitude: 90.361582),
      MuseumPoint(name: 'Памятник Скифскому Оленю', latitude: 53.741742, longitude: 91.424377),
      MuseumPoint(name: 'Памятник маленькому принцу', latitude: 53.739216, longitude: 91.431676),
      MuseumPoint(name: 'Краеведческий музей им. Д.С. Лалетина', latitude: 54.487155, longitude: 89.962251),
      MuseumPoint(name: 'Хакасский национальный краеведческий музей', latitude: 53.71776500, longitude: 91.45508100),
      MuseumPoint(name: 'Ширинский районный краеведческий музей', latitude: 54.48849, longitude: 89.96276),
      MuseumPoint(name: 'Крепость Тарпиг', latitude: 54.76792, longitude: 89.81993),
      MuseumPoint(name: 'Оглахтинская крепость', latitude: 54.67411, longitude: 90.85743),














    ];
  }
  /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  List<ParkPoint> _getMapPointsP() {
    return const [

      // Северо-Западный округ

      // республика Коми
      ParkPoint(name: 'Югыд Ва', latitude: 63.9690289, longitude: 59.2200899),
      ParkPoint(name: 'Финно-угорский этнокультурный парк', latitude: 61.673248, longitude: 50.832223),
      ParkPoint(name: 'Печоро-Илычский биосферный заповедник', latitude: 61.822870, longitude: 56.824022),
      ParkPoint(name: 'Кажимский железоделательный завод', latitude: 60.333902, longitude: 51.556093),
      ParkPoint(name: 'Памятник букве О с точками', latitude: 61.6695989, longitude: 50.8271581),
      ParkPoint(name: 'Город-призрак Хальмер-Ю', latitude: 67.9666700, longitude: 64.8333300),
      ParkPoint(name: 'Девственные леса Коми', latitude: 65.056199, longitude: 60.082262),
      ParkPoint(name: 'Река Щугор', latitude: 63.1859, longitude: 59.2353),
      ParkPoint(name: 'Маньпупунер (мансийские болваны)', latitude: 62.221329, longitude: 59.305196),
      ParkPoint(name: 'Село Усть-Цильма', latitude: 65.43333, longitude: 52.15),
      ParkPoint(name: 'Село Усть-Вымь', latitude: 62.22587542933404, longitude: 50.397508999999914),

      // Ненецкий АО
      ParkPoint(name: 'Ненецкий природный заповедник', latitude: 68.602778, longitude: 53.663056),
      ParkPoint(name: 'Памятник природы «Каменный город»', latitude: 67.301472, longitude: 48.984090),
      ParkPoint(name: 'Природный заказник «Море-Ю»', latitude: 68.171733, longitude: 59.948972),
      ParkPoint(name: 'Нижнепечорский заказник', latitude: 67.840474, longitude: 52.689714),
      ParkPoint(name: 'Термальное урочище Пым-Ва-Шор', latitude: 67.189184, longitude: 60.865456),
      ParkPoint(name: 'Ортинское городище', latitude: 68.055118, longitude: 54.128906),
      ParkPoint(name: 'Центр арктического туризма', latitude: 67.633756, longitude: 53.24157),
      ParkPoint(name: 'Обдорский острог (Город мастеров)', latitude: 66.5222540, longitude: 66.5892110),
      ParkPoint(name: 'Пым-Ва-Шор', latitude: 67.1889, longitude: 60.873),

      // Архангельская область
      ParkPoint(name: 'Кенозерский национальный парк', latitude: 61.7709, longitude: 38.0473),
      ParkPoint(name: 'Земля Франца-Иосифа', latitude: 80.666667, longitude: 54.833333),
      ParkPoint(name: 'Пинежские пещеры', latitude: 64.405278, longitude: 43.156944),
      ParkPoint(name: 'Соловецкий ботанический сад', latitude: 65.052928, longitude: 35.659949),
      ParkPoint(name: 'Озерно-канальная система Соловков', latitude: 65.04651, longitude: 35.69470),
      ParkPoint(name: 'Ягринский пляж', latitude: 64.604683, longitude: 39.811770),
      ParkPoint(name: 'Лабиринты Большого Заяцкого острова', latitude: 64.970500, longitude: 35.664806),
      ParkPoint(name: 'Проспект Чумбарова-Лучинского', latitude: 64.53472, longitude: 40.52972),
      ParkPoint(name: 'Памятник Тюленю', latitude: 64.543962, longitude: 40.510753),
      ParkPoint(name: 'Памятник Ломоносову', latitude: 55.7011833, longitude: 37.5275917),
      ParkPoint(name: 'Водлозерский национальный парк', latitude: 62.5, longitude: 36.917),
      ParkPoint(name: 'Минеральные источники в Куртяеве', latitude: 64.405037, longitude: 43.169696),
      ParkPoint(name: 'село Ворзогоры', latitude: 63.89335776, longitude: 37.66756755),
      ParkPoint(name: 'Каргополь', latitude: 61.5071164, longitude: 38.9328096),
      ParkPoint(name: 'поселок Пинега', latitude: 64.7000006, longitude: 43.3910351),
      ParkPoint(name: 'Пинежский заповедник', latitude: 64.676670, longitude: 43.19917),
      ParkPoint(name: 'краеведческий музей в Вельске', latitude: 61.076304062648006, longitude: 42.11320899999989),

      // Вологодская область
      ParkPoint(name: 'Вотчина Деда Мороза', latitude: 60.749116, longitude: 46.183799),
      ParkPoint(name: 'Национальный парк «Русский Север»', latitude: 59.8535, longitude: 38.3676),
      ParkPoint(name: 'Дарвинский заповедник', latitude: 65.014714, longitude: 95.464412),
      ParkPoint(name: '«Древнерусское поселение Сугорье»', latitude: 58.983371, longitude: 36.583570),
      ParkPoint(name: 'Октябрьский мост в Череповце', latitude: 59.109844, longitude: 37.904559),
      ParkPoint(name: 'деревянный мост через р. Мологу в Устюжне', latitude: 58.839148, longitude: 36.418947),

      // Мурманская область
      ParkPoint(name: 'Кандалакшский заповедник', latitude: 66.766237, longitude: 33.632615),
      ParkPoint(name: 'Лапландский заповедник', latitude: 67.651389, longitude: 32.6475),
      ParkPoint(name: 'Атомный ледокол «Ленин»', latitude: 68.974691, longitude: 33.059653),
      ParkPoint(name: 'Канозерские петроглифы', latitude: 67.042039, longitude: 34.155448),
      ParkPoint(name: 'Природный парк «Полуостров Средний и Рыбачий»', latitude: 69.722194, longitude: 32.556514),
      ParkPoint(name: 'Мурманский лабиринт', latitude: 68.9458186, longitude: 33.1684032),
      ParkPoint(name: 'Полярно-альпийский ботанический сад-институт', latitude: 67.6514, longitude: 33.6722),
      ParkPoint(name: 'Водопад Мельничный каскад', latitude: 69.170744, longitude: 32.586617),
      ParkPoint(name: 'Горнолыжный курорт «Большой Вудъявр»', latitude: 67.5998375, longitude: 33.703715),
      ParkPoint(name: 'Заповедник «Пасвик»', latitude: 69.06667, longitude: 29.18611),
      ParkPoint(name: 'Национальный парк «Хибины»', latitude: 67.7252, longitude: 33.4738),
      ParkPoint(name: 'Памятник природы «Озеро Могильное»', latitude: 69.31955, longitude: 34.348556),
      ParkPoint(name: 'Памятник природы «Астрофиллиты горы Эвеслогчорр»', latitude: 67.664, longitude: 34.012),
      ParkPoint(name: 'Природный парк «Кораблекк»', latitude: 29.516268, longitude: 69.270355),
      ParkPoint(name: 'Природный парк «Терский берег»', latitude: 66.153056, longitude: 37.541944),
      ParkPoint(name: 'Природный парк «Кутса»', latitude: 66.686575, longitude: 30.248681),
      ParkPoint(name: 'Птичьи базары губы Дворовой', latitude: 68.4397389, longitude: 38.2198333),
      ParkPoint(name: 'Заказник «Колвицкий»', latitude: 67.186309, longitude: 33.412450),
      ParkPoint(name: 'Заказник «Сейдъявврь»', latitude: 67.666760, longitude: 33.395658),

      // Карелия
      ParkPoint(name: 'Онежская набережная', latitude: 61.7921508, longitude: 34.3811189),
      ParkPoint(name: 'Ботанический сад ПетрГУ', latitude: 61.840927, longitude: 34.410100),
      ParkPoint(name: 'Зоокомплекс «Три медведя»', latitude: 61.949212, longitude: 33.406829),
      ParkPoint(name: 'Горный парк «Рускеала»', latitude: 61.946111, longitude: 30.581389),
      ParkPoint(name: 'Национальный парк «Ладожские Шхеры»', latitude: 61.5218, longitude: 30.5039),
      ParkPoint(name: 'Национальный парк «Паанаярви»', latitude: 65.7645, longitude: 31.0759),
      ParkPoint(name: 'горнолыжный курорт «Ялгора»', latitude: 61.8547496, longitude: 34.456752),
      ParkPoint(name: 'Санаторий «Марциальные воды»', latitude: 62.155286, longitude: 33.897355),
      ParkPoint(name: 'Национальный парк «Водлозерский»', latitude: 62.236293, longitude: 36.885769),
      ParkPoint(name: 'Национальный парк «Калевальский»', latitude: 64.99167, longitude: 30.2125),
      ParkPoint(name: 'Национальный парк Водлозерский', latitude: 62.5, longitude: 36.917),
      ParkPoint(name: 'Национальный парк Калевальский', latitude: 64.99167, longitude: 30.2125),
      ParkPoint(name: 'Ландшафтный заказник Толвоярви', latitude: 62.066646, longitude: 35.225032),
      ParkPoint(name: 'Парк Ваккосалми', latitude: 61.705583, longitude: 30.677228),
      ParkPoint(name: 'Карельский Зоопарк', latitude: 61.994236, longitude: 30.778658),
      ParkPoint(name: 'Водохранилище Выгозеро', latitude: 63.60110943, longitude: 34.75592977),
      ParkPoint(name: 'Остров добрых духов', latitude: 64.836670, longitude: 33.713600),

      // Ленинградская область
      ParkPoint(name: 'Лабиринт на острове Крутояр', latitude: 60.474970, longitude: 27.866627),
      ParkPoint(name: '«Камень-голова», уходящая в землю', latitude: 59.894369, longitude: 29.84022),
      ParkPoint(name: 'Оредежские пещеры', latitude: 58.8442176, longitude: 30.363121),
      ParkPoint(name: 'Избушка Бабы-Яги', latitude: 59.616618, longitude: 30.740165),
      ParkPoint(name: 'Токсовский Зубропитомник', latitude: 60.152518, longitude: 30.456215),
      ParkPoint(name: 'Саблинские пещеры', latitude: 59.66719, longitude: 30.796787),
      ParkPoint(name: 'Заповедник «Монрепо»', latitude: 60.732939, longitude: 28.727617),
      ParkPoint(name: 'Дудергофские высоты', latitude: 59.697778, longitude: 30.133611),
      ParkPoint(name: 'Гатчинские гейзеры', latitude: 59.546808, longitude: 30.012693),
      ParkPoint(name: 'Линдуловская роща', latitude: 60.237994, longitude: 29.540083),
      ParkPoint(name: 'Святой источник при часовне', latitude: 60.007451, longitude: 32.295494),
      ParkPoint(name: 'Девонский обрыв', latitude: 59.129930, longitude: 29.298584),
      ParkPoint(name: 'Вепсский Лес', latitude: 60.5, longitude: 34.11667),
      ParkPoint(name: 'Карьер и известковые печи', latitude: 60.117882, longitude: 30.203168),
      ParkPoint(name: 'Карьер у деревни Питкелево', latitude: 59.166183, longitude: 30.360511),
      ParkPoint(name: 'Линия Маннергейма', latitude: 60.789018, longitude: 28.996747),
      ParkPoint(name: 'Невский лесопарк', latitude: 59.83333, longitude: 30.58333),
      ParkPoint(name: 'Каньон реки Лавы', latitude: 59.893945, longitude: 31.594464),
      ParkPoint(name: 'Тропа Хо Ши Мина', latitude: 61.144366, longitude: 29.759182),
      ParkPoint(name: 'БУС «Вертикаль»', latitude: 59.9073740, longitude: 29.0357260),
      ParkPoint(name: 'Назия — деревня-призрак', latitude: 59.8163941488237, longitude: 31.62927067714842),
      ParkPoint(name: 'Ребровские пещеры', latitude: 58.725111, longitude: 29.765385),
      ParkPoint(name: 'Пирамида в Екатерининском парке', latitude: 59.709444, longitude: 30.388611),

      // Санкт-Петербург
      ParkPoint(name: 'Невский проспект', latitude: 59.932473, longitude: 30.349169),
      ParkPoint(name: 'Дворцовая площадь', latitude: 59.938982, longitude: 30.315500),
      ParkPoint(name: 'Стрелка Васильевского острова', latitude: 59.944167, longitude: 30.306667),
      ParkPoint(name: 'Атланты', latitude: 33.7490, longitude: 84.3880),
      ParkPoint(name: 'Петропавловская крепость', latitude: 59.9500019, longitude: 30.3166718),
      ParkPoint(name: 'Казанский собор', latitude: 59.9342278, longitude: 30.3245944),
      ParkPoint(name: 'Александринский, latitude: театр', latitude: 59.93208400, longitude: 30.33637700),
      ParkPoint(name: 'Мариинский театр', latitude: 59.925919, longitude: 30.2975893),
      ParkPoint(name: 'Петергоф', latitude: 59.863400, longitude: 29.990947),
      ParkPoint(name: 'Павловск', latitude: 59.6811976, longitude: 30.44437629999999),
      ParkPoint(name: 'Царское Село', latitude: 59.717372321389085, longitude: 30.394497798612953),
      ParkPoint(name: '«Лахта Центр»', latitude: 59.9867525, longitude: 30.1787992),
      ParkPoint(name: 'Летний сад', latitude: 59.9439113, longitude: 30.3369781),
      ParkPoint(name: 'Чижик-Пыжик', latitude: 59.941716, longitude: 30.338026),
      ParkPoint(name: 'Форт «Константин»', latitude: 59.995353, longitude: 29.701168),
      ParkPoint(name: 'Ленинградский зоопарк', latitude: 59.9518703, longitude: 30.3072287),
      ParkPoint(name: 'Дворы и парадные', latitude: 59.925146, longitude: 30.325480),
      ParkPoint(name: 'Крестовский остров', latitude: 59.97211886667353, longitude: 30.244999913933405),
      ParkPoint(name: 'Александровская колонна', latitude: 59.93917, longitude: 30.31583),
      ParkPoint(name: 'Марсово поле', latitude: 59.94362, longitude: 30.331793),
      ParkPoint(name: 'Монетный двор', latitude: 59.9495552, longitude: 30.3146485),
      ParkPoint(name: 'Океанариум', latitude: 59.9189519, longitude: 30.339051),
      ParkPoint(name: 'Стадион «Газпром Арена»', latitude: 59.97278, longitude: 30.22056),
      ParkPoint(name: 'Сфинксы на Университетской набережной', latitude: 59.936969, longitude: 30.29086),
      ParkPoint(name: 'Михайловский сад', latitude: 59.939846, longitude: 30.332823),
      ParkPoint(name: 'Ботанический сад', latitude: 59.97028, longitude: 30.32361),
      ParkPoint(name: 'Ораниенбаум', latitude: 59.9149028, longitude: 29.7539556),
      ParkPoint(name: 'Каменноостровский проспект', latitude: 59.9622, longitude: 30.315),
      ParkPoint(name: 'Аничков мост', latitude: 59.9332357, longitude: 30.34341),
      ParkPoint(name: 'Английская набережная', latitude: 59.9332914, longitude: 30.2912202),
      ParkPoint(name: 'Памятник Николаю I на Исаакиевской площади', latitude: 59.932114, longitude: 30.308425),

      // Новгородская область
      ParkPoint(name: 'Валдайский национальный парк', latitude: 57.9855, longitude: 33.2535),
      ParkPoint(name: 'Рдейский заповедник', latitude: 57.159010, longitude: 31.180272),
      ParkPoint(name: 'Рюриково городище', latitude: 58.4942856, longitude: 31.2981459),
      ParkPoint(name: 'Ярославово дворище', latitude: 58.518886, longitude: 31.284647),
      ParkPoint(name: 'Ганзейский фонтан', latitude: 58.51922, longitude: 31.283976),
      ParkPoint(name: 'Природный фонтан в деревне Меглецы', latitude: 58.430391, longitude: 34.553933),
      ParkPoint(name: 'Парк-усадьба Горки', latitude: 54.283234, longitude: 30.995111),
      ParkPoint(name: 'Маловишерский лес', latitude: 58.839277, longitude: 32.186398),

      // Псковская область
      ParkPoint(name: 'Изборская крепость', latitude: 57.70833, longitude: 27.85833),
      ParkPoint(name: 'Порховская крепость', latitude: 56.567222, longitude: 28.775),
      ParkPoint(name: 'Словенские ключи в Изборске', latitude: 57.714344, longitude: 27.860846),
      ParkPoint(name: 'Себежский национальный парк', latitude: 56.164027, longitude: 28.347572),
      ParkPoint(name: 'Труворово городище', latitude: 57.716998, longitude: 27.85365),
      ParkPoint(name: 'Цепные мосты через рукава реки Великой', latitude: 56.304444, longitude: 30.474722),
      ParkPoint(name: 'Полистовский заповедник', latitude: 57.17083, longitude: 30.55694),
      ParkPoint(name: 'Никандрова пустынь', latitude: 57.823249, longitude: 29.259921),
      ParkPoint(name: 'Трутневская пещера', latitude: 44.14529, longitude: 40.05257),
      ParkPoint(name: 'Место встречи воздухоплавателей', latitude: 56.343104, longitude: 30.515312),

      // Калининградская область
      ParkPoint(name: 'Башня Бисмарка', latitude: 55.020153, longitude: 22.115297),
      ParkPoint(name: 'Руины замка Бальга', latitude: 54.552470, longitude: 19.969234),
      ParkPoint(name: 'Руины замка Бранденбург', latitude: 54.613787, longitude: 20.248433),
      ParkPoint(name: 'Замковое имение Лангендорф', latitude: 54.660882, longitude: 20.932057),
      ParkPoint(name: 'Сосновый бор в городе Пионерский', latitude: 54.956787, longitude: 20.252761),
      ParkPoint(name: 'Парк Фихтенвальде', latitude: 54.586667, longitude: 22.167500),
      ParkPoint(name: 'Роминтенская пуща (Красный лес)', latitude: 54.394582, longitude: 22.527403),
      ParkPoint(name: 'Виштынецкий лес', latitude: 54.435387, longitude: 22.521588),
      ParkPoint(name: 'Парк Три старых липы', latitude: 54.938028, longitude: 20.159168),
      ParkPoint(name: 'Старейшее дерево Калининградской области', latitude: 54.56933, longitude: 20.173125),
      ParkPoint(name: '500-летний дуб', latitude: 48.52819, longitude: 23.50056),
      ParkPoint(name: '«Окно в Европу»', latitude: 55.105065, longitude: 19.620257),
      ParkPoint(name: 'Балтийская коса', latitude: 54.537583, longitude: 19.765389),
      ParkPoint(name: 'Танцующий лес', latitude: 55.180734, longitude: 20.861803),
      ParkPoint(name: 'Камень лжи', latitude: 54.946904, longitude: 20.212209),
      ParkPoint(name: 'Поющие пески', latitude: 57.537095, longitude: 49.279752),
      ParkPoint(name: 'Высота Мюллера', latitude: 55.148374, longitude: 20.812023),
      ParkPoint(name: 'Высота Эфа', latitude: 55.221127, longitude: 20.906135),


      // Сибирь

      // Омская область
      ParkPoint(name: 'Деревня Окунево', latitude: 56.442976, longitude: 74.906802),
      ParkPoint(name: 'Археологический парк Батаково', latitude: 56.193504, longitude: 74.321414),
      ParkPoint(name: 'Черноозерье', latitude: 55.740147, longitude: 73.991301),
      ParkPoint(name: 'Баировский заказник', latitude: 56.091376, longitude: 73.331600),
      ParkPoint(name: 'Заказник Пойма Любинская', latitude: 55.223056, longitude: 72.965278),
      ParkPoint(name: 'Бор Чернолучье', latitude: 55.261805, longitude: 73.022148),
      ParkPoint(name: 'Камышловский лог', latitude: 55.023734, longitude: 71.041731),
      ParkPoint(name: 'Курумбельская степь', latitude: 54.416667, longitude: 75.416667),
      ParkPoint(name: 'Петропавловский сосновый бор', latitude: 56.417356, longitude: 75.298346),
      ParkPoint(name: 'Чертов палец', latitude: 55.715427, longitude: 74.304886),
      ParkPoint(name: 'Чудская гора', latitude: 57.177124, longitude: 73.762335),
      ParkPoint(name: 'Остров Кировский', latitude: 54.951870, longitude: 73.363532),
      ParkPoint(name: 'Святой источник Часовня', latitude: 56.201649, longitude: 73.271688),
      ParkPoint(name: 'Природный парк «Птичья гавань»', latitude: 54.972938, longitude: 73.351189),
      ParkPoint(name: 'Парк Победы', latitude: 54.9614, longitude: 73.358879),
      ParkPoint(name: 'Памятник сантехнику', latitude: 54.985364, longitude: 73.374412),
      ParkPoint(name: 'Сквер имени Дзержинского', latitude: 54.989546, longitude: 73.374065),
      ParkPoint(name: 'Тобольские ворота', latitude: 54.985184, longitude: 73.362476),
      ParkPoint(name: 'Государственный академический театр драмы', latitude: 54.987923, longitude: 73.371232),
      ParkPoint(name: 'Скульптура «Люба»', latitude: 54.986009, longitude: 73.374706),
      ParkPoint(name: 'Памятник Ф. М. Достоевскому', latitude: 54.985135, longitude: 73.367803),
      ParkPoint(name: 'Дендропарк', latitude: 54.733234, longitude: 73.640673),
      ParkPoint(name: 'Пешеходная улица Чокана Валиханова', latitude: 54.9747, longitude: 73.381202),
      ParkPoint(name: 'Филармония', latitude: 54.977102, longitude: 73.379007),
      ParkPoint(name: 'Тарские ворота', latitude: 54.987686, longitude: 73.368012),
      ParkPoint(name: 'Парк культуры и отдыха имени 30-летия ВЛКСМ', latitude: 54.970541, longitude: 73.422039),
      ParkPoint(name: 'Омские ворота', latitude: 54.984534, longitude: 73.370711),
      ParkPoint(name: 'Сад «Сибирь»', latitude: 55.01606, longitude: 73.420502),
      ParkPoint(name: 'Парк культуры и отдыха «Зелёный остров»', latitude: 55.004633, longitude: 73.33627),
      ParkPoint(name: 'Иртышская набережная', latitude: 54.960369, longitude: 73.378875),

      // республика Алтай
      ParkPoint(name: 'Чуйский тракт – Шелковый путь Сибири', latitude: 51.93813, longitude: 85.83996),
      ParkPoint(name: 'Манжерок', latitude: 51.83233, longitude: 85.78185),
      ParkPoint(name: 'Чемал ', latitude: 51.40975, longitude: 86.00080),
      ParkPoint(name: 'Долина Семи Озёр', latitude: 49.89914, longitude: 86.50682),
      ParkPoint(name: 'Озеро Горных Духов', latitude: 49.87791, longitude: 86.57321),
      ParkPoint(name: 'Мультинские озёра', latitude: 50.00575, longitude: 85.83103),
      ParkPoint(name: 'Село Верхний Уймон', latitude: 50.21316, longitude: 85.73954),
      ParkPoint(name: 'Петроглифы урочища Калбак-Таш', latitude: 50.40135, longitude: 86.81858),
      ParkPoint(name: 'Чуйские меандры', latitude: 50.26508, longitude: 87.70329),
      ParkPoint(name: 'Курайская степь', latitude: 50.17592, longitude: 87.94752),
      ParkPoint(name: 'Ледники долины Актру', latitude: 50.08138, longitude: 87.69682),
      ParkPoint(name: 'Каменные грибы в долине Чулышман', latitude: 51.11171, longitude: 87.97292),
      ParkPoint(name: 'Плато Укок', latitude: 49.26847, longitude: 87.41377),
      ParkPoint(name: 'Красные Ворота', latitude: 50.3645, longitude: 87.6336),
      ParkPoint(name: 'База Перевалка', latitude: 50.1457, longitude: 87.8105),
      ParkPoint(name: 'Гора Купол Трёх Озёр', latitude: 50.0478, longitude: 87.7933),
      ParkPoint(name: 'Альплагерь Актру', latitude: 50.0837, longitude: 87.7788),
      ParkPoint(name: 'Шавлинские, latitude: озёра', latitude: 50.1043, longitude: 87.4263),
      ParkPoint(name: 'Каменные ворота Айры-таш', latitude: 50.5110, longitude: 86.5635),
      ParkPoint(name: 'Усть-Канская пещера', latitude: 50.9117, longitude: 84.8144),
      ParkPoint(name: 'Джумалинские источники', latitude: 49.4581, longitude: 88.0535),

      // Алтайский край
      ParkPoint(name: 'Скала Четыре Брата', latitude: 51.953577, longitude: 84.982803),
      ParkPoint(name: 'Каменный останец Стожок', latitude: 51.355618, longitude: 83.718591),
      ParkPoint(name: 'Пещера Денисова', latitude: 51.397272, longitude: 84.676702),
      ParkPoint(name: 'Тавдинские пещеры', latitude: 51.777307, longitude: 85.731056),
      ParkPoint(name: 'Грот Ихтиандра', latitude: 51.775787, longitude: 85.735338),
      ParkPoint(name: 'Пещера Страшная', latitude: 51.170720, longitude: 83.020834),
      ParkPoint(name: 'Пещера Загонная', latitude: 51.444586, longitude: 83.121520),
      ParkPoint(name: 'Лебединый заказник', latitude: 52.292235, longitude: 85.655206),
      ParkPoint(name: 'Тигирекский заповедник', latitude: 51.000000, longitude: 82.916667),
      ParkPoint(name: 'Барнаульский ленточный бор', latitude: 52.130340, longitude: 81.189313),
      ParkPoint(name: 'Касмалинский ленточный бор', latitude: 52.821525, longitude: 81.898141),

      // Иркутская область
      ParkPoint(name: 'Остров Ольхон', latitude: 53.168162, longitude: 107.374305),
      ParkPoint(name: 'Прибайкальский национальный парк', latitude: 51.848799, longitude: 104.870458),
      ParkPoint(name: 'Байкало-Ленский заповедник', latitude: 54.226389, longitude: 107.893056),
      ParkPoint(name: 'Витимский заповедник', latitude: 57.202778, longitude: 116.807778),
      ParkPoint(name: 'Тофаларский заказник', latitude: 54.306944, longitude: 95.990556),
      ParkPoint(name: 'Заказник «Бойские болота»', latitude: 55.106944, longitude: 101.396944),
      ParkPoint(name: 'Родники горы Весёлой', latitude: 52.258611, longitude: 104.593889),
      ParkPoint(name: 'Шаманский мыс', latitude: 51.694808, longitude: 103.702972),
      ParkPoint(name: 'Нижнеудинские пещеры', latitude: 54.500000, longitude: 99.216667),
      ParkPoint(name: 'Глазковский некрополь', latitude: 52.288056, longitude: 104.251667),
      ParkPoint(name: 'Древняя стоянка Мальта', latitude: 52.838245, longitude: 103.522365),
      ParkPoint(name: 'Шишкинские писаницы', latitude: 54.006944, longitude: 105.700278),
      ParkPoint(name: 'Бухта Песчаная', latitude: 52.259688, longitude: 105.703933),
      ParkPoint(name: 'Гранатовый пляж', latitude: 51.460885, longitude: 104.492930),
      ParkPoint(name: 'Село Урик', latitude: 52.45803, longitude: 104.2487),
      ParkPoint(name: 'Село Усть-Куда', latitude: 52.43159, longitude: 104.1342),
      ParkPoint(name: 'Долины Шумакских,  источников', latitude: 51.96309, longitude: 101.8751),
      ParkPoint(name: 'Иркутская слобода', latitude: 52.275, longitude: 104.29167),

      // Кемеровская область
      ParkPoint(name: 'Заповедник «Кузнецкий Алатау»', latitude: 54.365000, longitude: 88.119722),
      ParkPoint(name: 'Шорский национальный парк', latitude: 52.772964, longitude: 87.926010),
      ParkPoint(name: 'Поднебесные Зубья', latitude: 54.133333, longitude: 88.750000),
      ParkPoint(name: 'Азасская пещера', latitude: 52.765790, longitude: 88.497888),
      ParkPoint(name: 'Большая Кизасская пещера', latitude: 52.642450, longitude: 88.683452),
      ParkPoint(name: 'Гавриловские пещеры', latitude: 54.257814, longitude: 85.858618),
      ParkPoint(name: 'Гавриловский святой источник', latitude: 54.254047, longitude: 85.846475),
      ParkPoint(name: 'Свято-Никольский источник', latitude: 54.973879, longitude: 86.717231),
      ParkPoint(name: 'Шестаковский археологический комплекс', latitude: 55.907449, longitude: 87.953523),
      ParkPoint(name: 'Томская писаница', latitude: 55.668870, longitude: 85.623606),
      ParkPoint(name: 'Новоромановские скалы', latitude: 55.682457, longitude: 85.338589),
      ParkPoint(name: 'Кузедеевская липовая роща', latitude: 53.352500, longitude: 87.296667),
      ParkPoint(name: 'Природный заказник «Антибесский»', latitude: 55.965490, longitude: 87.281271),
      ParkPoint(name: 'Композиция "Скамья здоровья"', latitude: 55.348731, longitude: 86.117694),
      ParkPoint(name: 'Скульптура "Облако в луже"', latitude: 55.356654, longitude: 86.091396),
      ParkPoint(name: 'Скульптура "Ради жизни"', latitude: 55.352275, longitude: 86.094906),
      ParkPoint(name: 'Скульптура "Усталый ковбой"', latitude: 55.351955, longitude: 86.075058),
      ParkPoint(name: '"Парк Чудес" (Бывший городской сад)', latitude: 55.360704, longitude: 86.078529),
      ParkPoint(name: 'Светомузыкальный фонтан "Сила шахтерских традиций"', latitude: 55.353576, longitude: 86.0934),
      ParkPoint(name: 'Нулевой километр', latitude: 55.35496, longitude: 86.087299),


      // Красноярский край
      ParkPoint(name: 'Национальный парк «Столбы»', latitude: 55.883333, longitude: 92.766667),
      ParkPoint(name: 'Ергаки', latitude: 52.805133, longitude: 93.293874),
      ParkPoint(name: 'Шушенский бор', latitude: 52.699424, longitude: 91.500547),
      ParkPoint(name: 'Большой Арктический заповедник', latitude: 75.777500, longitude: 98.253056),
      ParkPoint(name: 'Заповедник «Таймырский»', latitude: 74.100000, longitude: 98.000000),
      ParkPoint(name: 'Плато Путорана', latitude: 68.946100, longitude: 94.506252),
      ParkPoint(name: 'Анашенский бор', latitude: 54.891303, longitude: 91.032830),
      ParkPoint(name: 'Саяно-Шушенский заповедник', latitude: 52.168552, longitude: 91.861326),
      ParkPoint(name: 'Айдашенская пещера', latitude: 56.203885, longitude: 90.310091),
      ParkPoint(name: 'Большая Орешная пещера', latitude: 55.293056, longitude: 93.735833),
      ParkPoint(name: 'Бирюсинские пещеры', latitude: 55.843481, longitude: 92.185758),
      ParkPoint(name: 'Шалоболинская писаница', latitude: 53.905472, longitude: 92.208236),
      ParkPoint(name: 'Березово-муравьиная роща', latitude: 56.285620, longitude: 92.742695),
      ParkPoint(name: 'Остров Татышев', latitude: 56.027052, longitude: 92.943337),
      ParkPoint(name: 'Краснотуранское побережье', latitude: 54.3186100, longitude: 91.5638900),


      // Новосибирская область
      ParkPoint(name: 'Новосибирское водохранилище', latitude: 54.489278, longitude: 82.327003),
      ParkPoint(name: 'Караканский бор', latitude: 54.395563, longitude: 82.295597),
      ParkPoint(name: 'Елбанские ельники', latitude: 54.300000, longitude: 84.550000),
      ParkPoint(name: 'Кудряшовский бор', latitude: 55.169581, longitude: 82.685655),
      ParkPoint(name: 'Реликтовая липовая роща', latitude: 55.950000, longitude: 80.950000),
      ParkPoint(name: 'Святой ключ', latitude: 54.573949, longitude: 83.354765),
      ParkPoint(name: 'Новососедовская пещера', latitude: 54.650777, longitude: 83.986399),
      ParkPoint(name: 'Барсуковская пещера', latitude: 54.371087, longitude: 83.959672),
      ParkPoint(name: 'Талицкий заказник', latitude: 54.239633, longitude: 84.470382),
      ParkPoint(name: 'Мануйловский заказник', latitude: 55.500000, longitude: 84.300000),
      ParkPoint(name: 'Легостаевский заказник', latitude: 54.700000, longitude: 83.900000),
      ParkPoint(name: 'Кирзинский заказник', latitude: 54.672016, longitude: 78.232207),
      ParkPoint(name: 'Васюганский заповедник', latitude: 56.944299, longitude: 78.746275),
      ParkPoint(name: 'Пихтовый гребень', latitude: 54.71401606551393, longitude: 84.34527545448222),
      ParkPoint(name: 'Шипуновский (Искитимский) мраморный карьер', latitude: 54.60228151667749, longitude: 83.34464482563862),
      ParkPoint(name: 'Новососедовская пещера', latitude: 54.650767, longitude: 83.986319),


      // Томская область
      ParkPoint(name: ' Сельский парк «Околица»', latitude: 56.515261845931626, longitude: 84.75752522301502),
      ParkPoint(name: ' Лагерный сад', latitude: 56.45417, longitude: 84.95),
      ParkPoint(name: 'Парк Околица ', latitude: 56.515261845931626, longitude: 84.75752522301502),
      ParkPoint(name: 'Нагорный Иштан',, latitude: 56.747914, longitude: 84.563618),
      ParkPoint(name: 'Семилуженский казачий острог', latitude: 56.617541, longitude: 85.353229),
      ParkPoint(name: 'Каравай-парк', latitude: 56.264160, longitude: 83.957439),
      ParkPoint(name: 'Заварзинская лесная дача', latitude: 56.464614, longitude: 85.107504),
      ParkPoint(name: 'Белоусовский кедровник', latitude: 56.314772, longitude: 85.170839),
      ParkPoint(name: 'Лоскутовский кедровник', latitude: 56.385401, longitude: 85.145387),
      ParkPoint(name: 'Петуховский кедровник', latitude: 56.318333, longitude: 85.255833),
      ParkPoint(name: 'Суйгинский лесопарк', latitude: 57.910650, longitude: 84.658168),
      ParkPoint(name: 'Родник «Аннушкин»', latitude: 56.399600, longitude: 85.025605),
      ParkPoint(name: 'Скважина «Буровая»', latitude: 57.292583, longitude: 88.178028),
      ParkPoint(name: 'Малиновский термальный источник', latitude: 58.192743, longitude: 82.742441),
      ParkPoint(name: 'Родник свв. Петра и Февронии', latitude: 58.273896, longitude: 85.206734),
      ParkPoint(name: 'Чажемто', latitude: 58.077028, longitude: 82.835389),
      ParkPoint(name: 'Чистый яр', latitude: 58.835229, longitude: 81.501390),
      ParkPoint(name: 'Обь-Енисейский канал', latitude: 59.187513, longitude: 88.553606),
      ParkPoint(name: 'Польто', latitude: 59.592909, longitude: 81.452151),
      ParkPoint(name: 'Ларинский ландшафтный заказник', latitude: 56.214306, longitude: 85.043382),
      ParkPoint(name: 'Тугояковский травертиновый каскад', latitude: 56.234111, longitude: 84.980464),
      ParkPoint(name: 'Таловские чаши', latitude: 56.297217, longitude: 85.420784),



      // республика Тыва
      ParkPoint(name: 'Заповедник «Убсунурская котловина»', latitude: 50.637721, longitude: 93.191919),
      ParkPoint(name: 'Заповедник «Азас»', latitude: 52.464827, longitude: 96.119437),
      ParkPoint(name: 'Тарысские источники', latitude: 50.380951, longitude: 98.204379),
      ParkPoint(name: 'Кундустуг аржаан', latitude: 51.568754, longitude: 95.180832),
      ParkPoint(name: 'Курганы Аржаан', latitude: 52.095976, longitude: 93.711233),
      ParkPoint(name: 'Дорога Чингисхана ', latitude: 51.605473, longitude: 91.950313),
      ParkPoint(name: 'Кижи-Кожээ', latitude: 51.085277, longitude: 90.625741),
      ParkPoint(name: 'Писаница Мугур-Саргол', latitude: 51.516651, longitude: 92.332448),
      ParkPoint(name: 'Сквер Центр Азии', latitude: 51.724754, longitude: 94.444386),
      ParkPoint(name: ' Убсунурская котловина', latitude: 50.33805, longitude: 92.75749),


      // республика Хакасия













    ];
  }
  /// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
  List<OutsidePoint> _getMapPointsO() {
    return const [

      // Северо-Западный округ

      // республика Коми
      OutsidePoint(name: 'Столбы выветривания', latitude: 62.221329, longitude: 59.305196),
      OutsidePoint(name: 'Гора Народная', latitude: 65.0349, longitude: 60.1150),
      OutsidePoint(name: 'Гора Манарага', latitude: 65.039679, longitude: 59.76726),
      OutsidePoint(name: 'Водопад Буредан', latitude: 68.728056, longitude: 65.352222),
      OutsidePoint(name: 'Гора Еркусей (Шаман-Гора)', latitude: 65.221364, longitude: 60.348099),
      OutsidePoint(name: 'Урочище Медвежья Пещера', latitude: 62, longitude: 58.733),

      // Ненецкий АО
      OutsidePoint(name: 'Река Печора', latitude: 67.683622, longitude: 52.490428),
      OutsidePoint(name: 'Река Пеша', latitude: 66.793508, longitude: 47.726111),
      OutsidePoint(name: 'Река Ома', latitude: 66.686917, longitude: 46.374264),
      OutsidePoint(name: 'Река Индига', latitude: 67.459386, longitude: 49.378361),
      OutsidePoint(name: 'Чёшская губа', latitude: 67.330048, longitude: 46.500698),
      OutsidePoint(name: 'Печорская губа', latitude: 68.661447, longitude: 54.997287),
      OutsidePoint(name: 'Поморский пролив', latitude: 68.604739, longitude: 50.284267),
      OutsidePoint(name: 'Остров Колгуев', latitude: 69.107757, longitude: 49.119853),
      OutsidePoint(name: 'Озеро Голодная Губа', latitude: 67.863923, longitude: 52.721486),
      OutsidePoint(name: 'Озеро Урдюжское', latitude: 67.238474, longitude: 50.180269),
      OutsidePoint(name: 'Сульские водопады', latitude: 66.895059, longitude: 49.538057),
      OutsidePoint(name: 'Остров Вайгач', latitude: 70.016667, longitude: 59.55),
      OutsidePoint(name: 'Каньон «Большие ворота»', latitude: 67.314353, longitude: 49.314534),
      OutsidePoint(name: 'Памятник комару нефтянику', latitude: 65.987386, longitude: 57.563046),
      OutsidePoint(name: 'смотровая площадка в морпорту (Нарьян-Мар)', latitude: 67.64667, longitude: 52.99417),
      OutsidePoint(name: 'озеро Хутыто', latitude: 68.01827, longitude: 59.664273),
      OutsidePoint(name: 'озеро Сейзасрёто', latitude: 68.695883, longitude: 60.850163),
      OutsidePoint(name: 'озеро Большое Камбальничье', latitude: 68.6257, longitude: 52.6056),
      OutsidePoint(name: 'озеро Ошкото', latitude: 67.746175, longitude: 57.229256),

      // Архангельская область
      OutsidePoint(name: 'Кий-остров', latitude: 64.0022, longitude: 37.8783),
      OutsidePoint(name: 'Обсерватория им. Эрнста Кренкеля', latitude: 80.452222, longitude: 58.051758),
      OutsidePoint(name: 'р. Северная Двина', latitude: 62.730779, longitude: 43.258597),
      OutsidePoint(name: 'Мыс Пур-Наволок', latitude: 64.475624, longitude: 40.507180),
      OutsidePoint(name: 'Озеро Лача', latitude: 61.333333, longitude: 61.333333),
      OutsidePoint(name: 'Белое море', latitude: 66.1119, longitude: 38.2338),
      OutsidePoint(name: 'р. Пинега', latitude: 59.821, longitude: 33.506),

      // Вологодская область
      OutsidePoint(name: 'Водопад Падун', latitude: 63.882736, longitude: 34.310450),
      OutsidePoint(name: 'Урочище Опоки', latitude: 56.906, longitude: 30.816),
      OutsidePoint(name: 'Село Сизьма', latitude: 59.4142, longitude: 38.7083),
      OutsidePoint(name: 'село Горицы', latitude: 59.8711194, longitude: 38.2588892),

      // Мурманская область
      OutsidePoint(name: 'Кольский залив', latitude: 69.135, longitude: 33.466),
      OutsidePoint(name: 'село Териберка', latitude: 69.16417, longitude: 35.14056),
      OutsidePoint(name: 'Хибины (горы)', latitude: 67.730312, longitude: 33.710057),
      OutsidePoint(name: 'Юдычвумчорр', latitude: 67.734722, longitude: 33.726111),
      OutsidePoint(name: 'Мемориал «Алёша»', latitude: 68.993056, longitude: 33.071667),
      OutsidePoint(name: 'Сейдозеро', latitude: 67.814984, longitude: 34.848857),
      OutsidePoint(name: 'оз. Ловно', latitude: 66.84029700, longitude: 35.17272900),
      OutsidePoint(name: 'Аметисты мыса Корабль', latitude: 66.294072, longitude: 36.389342),
      OutsidePoint(name: 'Кузоменьские пески', latitude: 66.284025, longitude: 36.861819),
      OutsidePoint(name: 'Сейды', latitude: 69.186468, longitude: 35.127593),
      OutsidePoint(name: 'Семёновское озеро', latitude: 68.991556, longitude: 33.089920),
      OutsidePoint(name: 'Ловозерские тундры', latitude: 67.845833, longitude: 34.669722),
      OutsidePoint(name: 'Село Варзуга', latitude: 68.974749, longitude: 33.059807),
      OutsidePoint(name: 'Амазониты горы Парусная', latitude: 67.6491139, longitude: 37.1807667),
      OutsidePoint(name: 'Водопад на реке Шуонийок', latitude: 69.346, longitude: 30.046),
      OutsidePoint(name: 'Озеро Комсозеро', latitude: 67.7430389, longitude: 30.9230528),
      OutsidePoint(name: '«Юкспоррлак»', latitude: 67.6655583, longitude: 33.8548583),
      OutsidePoint(name: 'Бараний лоб у озера Семёновское', latitude: 68.99472, longitude: 33.07222),
      OutsidePoint(name: '«Гранитоиды острова Микков»', latitude: 66.706207, longitude: 33.011705),
      OutsidePoint(name: '«Лечебные грязи Палкиной губы»', latitude: 67.062575, longitude: 32.289436),
      OutsidePoint(name: 'Губа Воронья', latitude: 66.766237, longitude: 33.632615),
      OutsidePoint(name: 'Кандалакшский берег', latitude: 66.778056, longitude: 33.395278),

      // Карелия
      OutsidePoint(name: 'Водопад Кивач', latitude: 62.268000, longitude: 33.980384),
      OutsidePoint(name: 'Вулкан Гирвас', latitude: 62.484776, longitude: 33.670096),
      OutsidePoint(name: 'Гора Воттоваара', latitude: 63.074251, longitude: 32.623114),
      OutsidePoint(name: 'Ладожское озеро', latitude: 60.785, longitude: 31.715),
      OutsidePoint(name: 'Остров Валаам', latitude: 61.3899, longitude: 30.9471),
      OutsidePoint(name: 'Водопад «Белые мосты»', latitude: 61.7551484, longitude: 31.4160496),
      OutsidePoint(name: 'Беломорские петроглифы', latitude: 4.52247560835693, longitude: 34.76414969865403),
      OutsidePoint(name: 'Гора Нуорунен', latitude: 66.144722, longitude: 30.244722),
      OutsidePoint(name: 'Лахденпохья', latitude: 61.522222, longitude: 30.1925),
      OutsidePoint(name: 'Деревня Кинерма', latitude: 61.527222, longitude: 32.828889),
      OutsidePoint(name: 'Деревня Пегрема', latitude: 62.3265, longitude: 34.766),
      OutsidePoint(name: 'Гора Сампо', latitude: 62.039219, longitude: 34.096913),
      OutsidePoint(name: 'Гора Филина', latitude: 61.548857, longitude: 30.199141),
      OutsidePoint(name: 'Марциальные воды', latitude: 62.156608, longitude: 33.901688),
      OutsidePoint(name: 'Залив Ляппяярви', latitude: 61.695470, longitude: 30.696523),
      OutsidePoint(name: 'Шардонский архипелаг', latitude: 61.942343, longitude: 34.737697),
      OutsidePoint(name: 'Озеро Урозеро', latitude: 59.866879, longitude: 37.383157),
      OutsidePoint(name: 'Ильинский Водлозерский погост', latitude: 62.380093, longitude: 36.9078),
      OutsidePoint(name: 'Водопад «Воицкий Падун»', latitude: 62.268000, longitude: 33.980384),
      OutsidePoint(name: 'Водопад Куми-порог', latitude: 65.276142, longitude: 30.198763),
      OutsidePoint(name: 'Рускеальские водопады', latitude: 61.915509, longitude: 30.626539),
      OutsidePoint(name: 'Озеро Янисъярви', latitude: 61.966667, longitude: 30.916667),
      OutsidePoint(name: 'Водопад Киваккакоски', latitude: 62.268000, longitude: 33.980384),

      // Ленинградская область
      OutsidePoint(name: 'Радоновые озёра', latitude: 59.734545, longitude: 29.401247),
      OutsidePoint(name: 'Федоровский городок', latitude: 59.725456, longitude: 30.394112),
      OutsidePoint(name: 'Остров Коневец', latitude: 60.860160, longitude: 30.610129),
      OutsidePoint(name: 'Липовское озеро', latitude: 59.744134, longitude: 28.152419),
      OutsidePoint(name: 'Тосненский водопад', latitude: 59.644625, longitude: 30.808623),
      OutsidePoint(name: 'Лосевские Пороги', latitude: 60.680176, longitude: 29.998775),
      OutsidePoint(name: 'Водопад на реке Караста', latitude: 59.91490300, longitude: 29.75395600),
      OutsidePoint(name: '«Скала любви»', latitude: 61.0638, longitude: 28.8705),
      OutsidePoint(name: 'Староладожская пещера и Святой источник', latitude: 59.542303, longitude: 28.747203),
      OutsidePoint(name: 'Горчаковщинский водопад', latitude: 60.019167, longitude: 32.330792),
      OutsidePoint(name: 'Большие скалы', latitude: 61.166667, longitude: 29.7),
      OutsidePoint(name: 'Ястребиное озеро', latitude: 61.141847, longitude: 29.698131),
      OutsidePoint(name: 'Остров Маячный', latitude: 60.572191, longitude: 28.425085),
      OutsidePoint(name: 'Деревня Верхние Мандроги', latitude: 60.89842, longitude: 33.81942),

      // Санкт-Петербург
      OutsidePoint(name: 'Мосты', latitude: 59.942222, longitude: 30.338611),
      OutsidePoint(name: 'Остров «Новая Голландия»', latitude: 59.9292549, longitude: 30.2898002),
      OutsidePoint(name: 'Кронштадт', latitude: 59.9954100, longitude: 29.7666800),

      // Новгородская область
      OutsidePoint(name: 'Озеро Селигер', latitude: 57.239082, longitude: 33.034332),
      OutsidePoint(name: 'Озеро Ильмень', latitude: 58.2667, longitude: 31.2833),
      OutsidePoint(name: 'Боровичи', latitude: 58.3878, longitude: 33.9155),
      OutsidePoint(name: 'Река Понеретка', latitude: 58.283150, longitude: 34.039541),
      OutsidePoint(name: 'Водопад «Голубая лагуна»', latitude: 63.88031100, longitude: -22.44927000),
      OutsidePoint(name: 'Карамельный водопад', latitude: 58.464633, longitude: 30.970706),

      // Псковская область
      OutsidePoint(name: 'Чудское озеро', latitude: 58.688003, longitude: 27.443691),

      // Калининградская область
      OutsidePoint(name: 'Куршская коса', latitude: 54.9757564, longitude: 20.520279),
      OutsidePoint(name: 'Река Неман', latitude: 53.456437, longitude: 26.728486),
      OutsidePoint(name: 'Виштынецкое озеро', latitude: 54.426944, longitude: 22.725),
      OutsidePoint(name: 'Река Шешупе', latitude: 54.967581, longitude: 22.714524),
      OutsidePoint(name: 'Река Анграпа', latitude: 54.476646, longitude: 22.044280),
      OutsidePoint(name: 'Река Лава', latitude: 54.398260, longitude: 21.022336),
      OutsidePoint(name: 'Река Инструч', latitude: 54.812260, longitude: 22.072855),
      OutsidePoint(name: 'Река Преголя', latitude: 54.645994, longitude: 21.070219),
      OutsidePoint(name: 'Озеро Мариново', latitude: 54.413653, longitude: 22.507173),
      OutsidePoint(name: 'Красное озеро', latitude: 54.350511, longitude: 22.325138),
      OutsidePoint(name: 'Озеро Лебедь', latitude: 55.245163, longitude: 20.944248),
      OutsidePoint(name: 'Озеро Чайка', latitude: 55.151631, longitude: 20.828563),
      OutsidePoint(name: 'Озеро Янтарное', latitude: 54.887325, longitude: 19.948436),
      OutsidePoint(name: 'Голубые озера', latitude: 54.648146, longitude: 20.354639),
      OutsidePoint(name: 'Лесное озеро', latitude: 54.717142, longitude: 20.389574),
      OutsidePoint(name: 'Озеро Карповское', latitude: 54.698811, longitude: 20.406921),

      // Сибирь

      // Омская область
      OutsidePoint(name: 'Успенский собор в Омске', latitude: 54.990215, longitude: 73.366743),
      OutsidePoint(name: 'Пять озер', latitude: 56.406804, longitude: 75.623091),
      OutsidePoint(name: 'Берег Драверта', latitude: 55.465600, longitude: 73.435900),
      OutsidePoint(name: 'Озеро Эбейты', latitude: 54.666667, longitude: 71.750000),
      OutsidePoint(name: 'Озеро Ульжай', latitude: 54.252936, longitude: 75.108931),
      OutsidePoint(name: 'Река Иртыш', latitude: 54.785662, longitude: 73.582884),
      OutsidePoint(name: 'Река Оша', latitude: 56.905917, longitude: 73.881357),
      OutsidePoint(name: 'Река Яман', latitude: 56.027962, longitude: 71.316074),
      OutsidePoint(name: 'Корниловская балка', latitude: 55.015913, longitude: 73.941233),
      OutsidePoint(name: 'Озеро Ик', latitude: 56.055161, longitude: 71.550803),
      OutsidePoint(name: 'Лебединое озеро (Круглое)', latitude: 54.992575, longitude: 71.510235),
      OutsidePoint(name: 'Лебяжье озеро', latitude: 54.780556, longitude: 75.522778),

      // республика Алтай
      OutsidePoint(name: 'Телецкое озеро', latitude: 51.57366, longitude: 87.67227),
      OutsidePoint(name: 'Река Катунь', latitude: 51.39181, longitude: 86.00168),
      OutsidePoint(name: 'Гора Белуха', latitude: 49.80844, longitude: 86.58939),
      OutsidePoint(name: 'Аккемское озеро', latitude: 49.90696, longitude: 86.54696),
      OutsidePoint(name: 'Долина Ярлу ', latitude: 49.92125, longitude: 86.57646),
      OutsidePoint(name: 'Водопад Текелю', latitude: 49.98222, longitude: 86.52755),
      OutsidePoint(name: 'вершина Ак-Оюк', latitude: 49.89914, longitude: 86.50682),
      OutsidePoint(name: 'Слияние рек Чуя и Катунь', latitude: 50.39416, longitude: 86.67175),
      OutsidePoint(name: 'Гейзерное озеро', latitude: 50.28924, longitude: 87.66711),
      OutsidePoint(name: 'Акташский ретранслятор', latitude: 50.34133, longitude: 87.74969),
      OutsidePoint(name: 'Радужные горы урочища Кызыл-Чин', latitude: 50.05923, longitude: 88.29661),
      OutsidePoint(name: 'Перевал Кату-Ярык', latitude: 50.90991, longitude: 88.21790),
      OutsidePoint(name: 'Водопад Учар', latitude: 51.11775, longitude: 88.09055),
      OutsidePoint(name: 'Водопад Корбу', latitude: 51.7065, longitude: 87.6843),
      OutsidePoint(name: 'Река Чулышман', latitude: 51.3542, longitude: 87.7604),
      OutsidePoint(name: 'Водопад Куркуре', latitude: 50.9005, longitude: 88.2565),
      OutsidePoint(name: 'Голубое озеро в долине Актру', latitude: 50.0797, longitude: 87.7250),
      OutsidePoint(name: 'Водопад Ширлак', latitude: 50.3456, longitude: 87.2191),
      OutsidePoint(name: 'Калбак-Таш', latitude: 50.4014, longitude: 86.8181),
      OutsidePoint(name: 'Перевал Чике-Таман', latitude: 50.6449, longitude: 86.3120),
      OutsidePoint(name: 'Семинский перевал', latitude: 51.0452, longitude: 85.6043),
      OutsidePoint(name: 'Плато Укок', latitude: 49.3357, longitude: 87.5000),
      OutsidePoint(name: 'Аккемское озеро', latitude: 49.9113, longitude: 86.5441),

      // Алтайски край
      OutsidePoint(name: 'Река Катунь', latitude: 52.448069, longitude: 85.178460),
      OutsidePoint(name: 'Кулундинское озеро', latitude: 52.980044, longitude: 79.545513),
      OutsidePoint(name: 'Озеро Ая', latitude: 51.904532, longitude: 85.853654),
      OutsidePoint(name: 'Колыванское озеро', latitude: 51.365577, longitude: 82.194079),
      OutsidePoint(name: 'Озеро Моховое', latitude: 51.252746, longitude: 82.560115),
      OutsidePoint(name: 'Малиновое озеро', latitude: 51.701987, longitude: 79.746080),
      OutsidePoint(name: 'Озеро Горькое', latitude: 51.365971, longitude: 80.561588),
      OutsidePoint(name: 'Озеро Зеркальное', latitude: 52.514637, longitude: 81.857148),
      OutsidePoint(name: 'Белое озеро', latitude: 52.232509, longitude: 83.852405),
      OutsidePoint(name: 'Гора Синюха', latitude: 51.241431, longitude: 82.607293),
      OutsidePoint(name: 'Гора Очаровательная', latitude: 51.356768, longitude: 82.606683),
      OutsidePoint(name: 'Чертов палец', latitude: 51.893957, longitude: 85.826778),
      OutsidePoint(name: 'Каскады на реке Шинок', latitude: 51.355850, longitude: 84.555788),
      OutsidePoint(name: 'Пещерский водопад', latitude: 54.102110, longitude: 84.769930),

      // Иркутская область
      OutsidePoint(name: 'Байкал', latitude: 53.405332, longitude: 107.673058),
      OutsidePoint(name: 'Скала Шаманка', latitude: 53.203992, longitude: 107.338688),
      OutsidePoint(name: 'Река Лена', latitude: 53.874734, longitude: 107.151410),
      OutsidePoint(name: 'Река Ангара', latitude: 52.278340, longitude: 104.268385),
      OutsidePoint(name: 'Озеро Шара-Нур', latitude: 53.104633, longitude: 107.255027),
      OutsidePoint(name: 'Озеро Сердце', latitude: 51.509341, longitude: 103.625923),
      OutsidePoint(name: 'Соляной источник', latitude: 52.766184, longitude: 103.675775),
      OutsidePoint(name: 'Уковский водопад', latitude: 55.025081, longitude: 98.968164),
      OutsidePoint(name: 'Приморский хребет', latitude: 52.833333, longitude: 106.166667),
      OutsidePoint(name: 'Байкальский хребет', latitude: 55.058333, longitude: 108.691667),
      OutsidePoint(name: 'Кодарский хребет', latitude: 56.915132, longitude: 117.479772),
      OutsidePoint(name: 'Гора Пихтовая', latitude: 56.174777, longitude: 101.700009),
      OutsidePoint(name: 'Гора Ехэ-Ёрдо', latitude: 52.790978, longitude: 106.528851),
      OutsidePoint(name: 'Шаман-Камень', latitude: 51.875345, longitude: 104.821605),
      OutsidePoint(name: 'Мыс Хобой', latitude: 53.410625, longitude: 107.789507),
      OutsidePoint(name: 'Патомский кратер', latitude: 59.291529, longitude: 116.577034),
      OutsidePoint(name: ' Мыс Бурхан', latitude: 53.204189, longitude: 107.338578),

      // Кемеровская область
      OutsidePoint(name: 'Озеро Большой Берчикуль', latitude: 55.611043, longitude: 88.343891),
      OutsidePoint(name: 'Салаирский кряж', latitude: 54.089722, longitude: 85.827778),
      OutsidePoint(name: 'Гора Зелёная', latitude: 52.948556, longitude: 87.928537),
      OutsidePoint(name: 'Тутальские скалы', latitude: 55.708333, longitude: 85.006111),
      OutsidePoint(name: 'Царские ворота', latitude: 53.050987, longitude: 88.415012),
      OutsidePoint(name: 'Разрезы Кузбасса', latitude: 54.228056, longitude: 87.020278),
      OutsidePoint(name: 'Озеро Танай', latitude: 54.795328, longitude: 84.998784),
      OutsidePoint(name: 'Беловское водохранилище', latitude: 54.424582, longitude: 86.462406),
      OutsidePoint(name: 'Озеро Среднетерсинское', latitude: 54.386939, longitude: 88.359351),
      OutsidePoint(name: 'Озеро Рыбное', latitude: 54.329709, longitude: 88.403153),
      OutsidePoint(name: 'Водопад Сага', latitude: 52.986627, longitude: 88.370484),
      OutsidePoint(name: 'Иткаринский водопад', latitude: 55.967033, longitude: 84.979489),
      OutsidePoint(name: 'Кедровский угольный разрез', latitude: 55.519695282, longitude: 86.092903137),


      // Красноярский край
      OutsidePoint(name: 'Манская петля', latitude: 55.872348, longitude: 92.547230),
      OutsidePoint(name: 'Массив Борус', latitude: 52.789316, longitude: 91.542605),
      OutsidePoint(name: 'Караульная гора', latitude: 56.023574, longitude: 92.863263),
      OutsidePoint(name: 'Тальниковый водопад', latitude: 68.445556, longitude: 93.294444),
      OutsidePoint(name: 'Мраморный водопад', latitude: 52.820403, longitude: 93.379880),
      OutsidePoint(name: 'Водопад Красные камни', latitude: 69.481080, longitude: 88.531964),
      OutsidePoint(name: 'Красноярское море', latitude: 55.1098, longitude: 91.5772),
      OutsidePoint(name: 'Кутурчинское Белогорье', latitude: 54.7068, longitude: 94.6081),
      OutsidePoint(name: 'Богунайский водопад', latitude: 55.966511, longitude: 92.687425),
      OutsidePoint(name: 'Озера Шарыповского района', latitude: 55.352708, longitude: 89.116060),
      OutsidePoint(name: 'Озеро Инголь', latitude: 55.535728, longitude: 88.845026),
      OutsidePoint(name: 'Черная сопка', latitude: 55.917859, longitude: 93.070979),
      OutsidePoint(name: 'Сопка Метеоритная', latitude: 54.900000, longitude: 91.800000),
      OutsidePoint(name: 'Гора Тепсей', latitude: 53.949813, longitude: 91.566249),
      OutsidePoint(name: 'Озеро Таймыр', latitude: 74.558117, longitude: 102.221515),
      OutsidePoint(name: 'Озеро Виви', latitude: 66.726032, longitude: 93.968531),
      OutsidePoint(name: 'Монастырское озеро', latitude: 58.385478, longitude: 91.918908),
      OutsidePoint(name: 'Озеро Тиберкуль', latitude: 53.894034, longitude: 94.01682),



      // Новосибирская область
      OutsidePoint(name: 'Озеро Карачи', latitude: 55.355403, longitude: 76.944745),
      OutsidePoint(name: 'Салаирский кряж', latitude: 54.457453, longitude: 85.000337),
      OutsidePoint(name: 'Буготакские сопки', latitude: 55.092873, longitude: 83.884125),
      OutsidePoint(name: 'Бердские скалы', latitude: 54.609534, longitude: 84.006770),
      OutsidePoint(name: 'Улантова гора', latitude: 54.882803, longitude: 84.299987),
      OutsidePoint(name: 'Озеро Чаны', latitude: 54.866321, longitude: 77.619345),
      OutsidePoint(name: 'Убинское озеро', latitude: 55.467861, longitude: 80.060652),
      OutsidePoint(name: 'Озеро Горькое', latitude: 54.227414, longitude: 77.975600),
      OutsidePoint(name: 'Данилово озеро', latitude: 56.426343, longitude: 75.838992),
      OutsidePoint(name: 'Беловский водопад', latitude: 54.559800, longitude: 83.620666),
      OutsidePoint(name: 'Карпысакский водопад', latitude: 55.053096, longitude: 83.730956),
      OutsidePoint(name: 'Водопад Бучило', latitude: 54.629166, longitude: 83.830223),
      OutsidePoint(name: 'Волчья грива', latitude: 55.004215, longitude: 80.595922),
      OutsidePoint(name: 'Суенгинские водопады', latitude: 54.42504139769147, longitude: 84.54182788329612),
      OutsidePoint(name: 'Река Буготак', latitude: 55.066888445741704, longitude: 83.90990672974539),
      OutsidePoint(name: 'Буготакские сопки', latitude: 54.88333, longitude: 83.66666),
      OutsidePoint(name: 'Мраморное озеро Абрашино', latitude: 54.22810690815401, longitude: 81.70717615243939),
      OutsidePoint(name: 'Курумбельская степь', latitude: 54.416667, longitude: 75.416667),
      OutsidePoint(name: ' Озеро Тандово', latitude: 55.1552526143972, longitude: 77.98651042705598),
      OutsidePoint(name: ' Остров Таньвань', latitude: 54.81662469183576, longitude: 83.03725416798395),



      // Томская область
      OutsidePoint(name: 'Васюганские болота', latitude: 57.566667, longitude: 75.650000),
      OutsidePoint(name: 'Озеро Мирное', latitude: 57.721142, longitude: 79.098808),
      OutsidePoint(name: 'Река Обь', latitude: 56.700861, longitude: 84.362882),
      OutsidePoint(name: 'Озеро Варгато', latitude: 58.761642, longitude: 84.214983),
      OutsidePoint(name: 'Озеро Иллипех', latitude: 60.195841, longitude: 79.317673),
      OutsidePoint(name: 'Озеро Кирекское', latitude: 56.111644, longitude: 84.231512),
      OutsidePoint(name: 'Синие утёсы', latitude: 56.330716, longitude: 84.918347),
      OutsidePoint(name: 'Аникин Камень', latitude: 56.112347, longitude: 84.981623),
      OutsidePoint(name: 'Камень Боец', latitude: 56.138555, longitude: 84.963563),
      OutsidePoint(name: 'Колпашевский яр', latitude: 58.309630, longitude: 82.921121),
      OutsidePoint(name: 'Гора Кулайка', latitude: 57.777559, longitude: 82.632883),
      OutsidePoint(name: 'Самусь', latitude: 56.745937, longitude: 84.698151),
      OutsidePoint(name: 'Маяк на реке Обь', latitude: 56.146560, longitude: 83.955404),


      // республика Тыва
      OutsidePoint(name: 'Гора Монгун-Тайга', latitude: 50.275072, longitude: 90.126282),
      OutsidePoint(name: 'Озеро Чедер', latitude: 51.359143, longitude: 94.785746),
      OutsidePoint(name: 'Озеро Чагытай', latitude: 51.016115, longitude: 94.729431),
      OutsidePoint(name: 'Река Енисей', latitude: 51.642179, longitude: 94.241396),
      OutsidePoint(name: 'Озеро Дус-Холь', latitude: 50.336302, longitude: 95.016532),
      OutsidePoint(name: 'Озеро Кара-Холь', latitude: 50.528730, longitude: 95.203741),
      OutsidePoint(name: 'Озеро Сут-Холь', latitude: 51.518674, longitude: 91.166299),
      OutsidePoint(name: 'Озеро Торе-Холь', latitude: 50.064660, longitude: 95.082163),
      OutsidePoint(name: 'Уш-Белдир', latitude: 51.472229, longitude: 98.051297),
      OutsidePoint(name: 'Аржаан Чойган', latitude: 52.060988, longitude: 96.000086),
      OutsidePoint(name: 'Дургенский водопад', latitude: 51.145134, longitude: 94.010814),
      OutsidePoint(name: 'Гора Кежеге', latitude: 50.035397, longitude: 95.463646),
      OutsidePoint(name: 'Гора Хайыракан', latitude: 51.563245, longitude: 93.028420),
      OutsidePoint(name: 'Гора Догээ', latitude: 51.762082, longitude: 94.423686),
      OutsidePoint(name: 'Гора Кызыл-Тайга', latitude: 51.474474, longitude: 89.923141),
      OutsidePoint(name: 'Хребет Академика Обручева', latitude: 51.833333, longitude: 96.000000),
      OutsidePoint(name: 'Гора Уттуг-Хая', latitude: 51.133766, longitude: 90.726945),



      // республика Хакасия








    ];
  }

  /// Методы для генерации объектов маркеров для отображения на карте
  List<PlacemarkMapObject> _getPlacemarkObjectsM(BuildContext context) {
    return _getMapPointsM()
        .map(
          (point) =>
          PlacemarkMapObject(
            mapId: MapObjectId('MapObject $point'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/museum.png',
                ),
                scale: 0.15,
              ),
            ),
            onTap: (_, __) => showModalBottomSheet(
              context: context,
              builder: (context) => _ModalBodyViewM(
                point: point,
              ),
            ),
          ),
    )
        .toList();
  }


  List<PlacemarkMapObject> _getPlacemarkObjectsO(BuildContext context) {
    return _getMapPointsO()
        .map(
          (point) =>
          PlacemarkMapObject(
            mapId: MapObjectId('MapObject $point'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'assets/binoculars.png',
                ),
                scale: 0.15,
              ),
            ),
            onTap: (_, __) => showModalBottomSheet(
              context: context,
              builder: (context) => _ModalBodyViewO(
                point: point,
              ),
            ),
          ),
    )
        .toList();
  }

List<PlacemarkMapObject> _getPlacemarkObjectsP(BuildContext context) {
  return _getMapPointsP()
      .map(
        (point) => PlacemarkMapObject(
      mapId: MapObjectId('MapObject $point'),
      point: Point(latitude: point.latitude, longitude: point.longitude),
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            'assets/trees.png',
          ),
          scale: 0.15,
        ),
      ),
      onTap: (_, __) => showModalBottomSheet(
        context: context,
        builder: (context) => _ModalBodyView(
          point: point,
        ),
      ),
    ),
  )
      .toList();
}


/// Содержимое модального окна с информацией о точке на карте
class _ModalBodyView extends StatelessWidget {
  const _ModalBodyView({required this.point});


  final ParkPoint point;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(point.name, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text(
          '${point.latitude}, ${point.longitude}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ]),
    );
  }
}

class _ModalBodyViewM extends StatelessWidget {
  const _ModalBodyViewM({required this.point});


  final MuseumPoint point;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(point.name, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text(
          '${point.latitude}, ${point.longitude}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ]),
    );
  }
}

class _ModalBodyViewO extends StatelessWidget {
  const _ModalBodyViewO({required this.point});


  final OutsidePoint point;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(point.name, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text(
          '${point.latitude}, ${point.longitude}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ]),
    );
  }
}

