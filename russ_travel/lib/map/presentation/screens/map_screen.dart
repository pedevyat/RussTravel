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
      MuseumPoint(name: 'Богоявленский собор', latitude: 55.772655, longitude: 37.674772),
      MuseumPoint(name: 'Памятник «Подвигу участников оленно-транспортных батальонов»', latitude: 67.64, longitude: 53.01056),
      MuseumPoint(name: 'Памятник труженикам Печорского лесозавода', latitude: 67.66982400, longitude: 53.09680900),
      MuseumPoint(name: 'Памятник Яку-7Б', latitude: 67.66982400, longitude: 53.09680900),
      MuseumPoint(name: 'Этнокультурный центр Ненецкого автономного округа', latitude: 67.6404610, longitude: 53.0034470),
      MuseumPoint(name: 'Несская церковь', latitude: 54.163797755081,longitude: 26.14351272583),

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








    ];
  }
  /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  List<ParkPoint> _getMapPointsP() {
    return const [
      // республика Коми
      ParkPoint(name: 'Югыд Ва', latitude: 63.9690289, longitude: 59.2200899),
      ParkPoint(name: 'Финно-угорский этнокультурный парк', latitude: 61.673248, longitude: 50.832223),
      ParkPoint(name: 'Печоро-Илычский биосферный заповедник', latitude: 61.822870, longitude: 56.824022),
      ParkPoint(name: 'Кажимский железоделательный завод', latitude: 60.333902, longitude: 51.556093),
      ParkPoint(name: 'Памятник букве ?', latitude: 61.6695989, longitude: 50.8271581),
      ParkPoint(name: 'Город-призрак Хальмер-Ю', latitude: 67.9666700, longitude: 64.8333300),
      ParkPoint(name: 'Девственные леса Коми', latitude: 65.056199, longitude: 60.082262),
      ParkPoint(name: 'Река Щугор', latitude: 63.1859, longitude: 59.2353),
      ParkPoint(name: 'Маньпупунер (мансийские болваны)', latitude: 62.221329, longitude: 59.305196),
      ParkPoint(name: '«Сад камней» на берегу Ижмы', latitude: 56.731043, longitude: 35.504124),
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
      ParkPoint(name: 'Каменный город', latitude: 58.722733, longitude: 57.6329),
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







    ];
  }
  /// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
  List<OutsidePoint> _getMapPointsO() {
    return const [
      // республика Коми
      OutsidePoint(name: 'Столбы выветривания', latitude: 62.221329, longitude: 59.305196),
      OutsidePoint(name: 'Гора Народная', latitude: 65.0349, longitude: 60.1150),
      OutsidePoint(name: 'Гора Манарага', latitude: 65.039679, longitude: 59.76726),
      OutsidePoint(name: 'Водопад Буредан', latitude: 68.728056, longitude: 65.352222),
      OutsidePoint(name: 'Гора Еркусей (Шаман-Гора)', latitude: 65.221364, longitude: 60.348099),
      OutsidePoint(name: 'Урочище Медвежья Пещера', latitude: 62, longitude: 58.733),
      OutsidePoint(name: 'Пик Масленникова', latitude: 53.9, longitude: 27.5667),
      OutsidePoint(name: 'Гора Тельпос', latitude: 46.6912400, longitude: 21.8033500),

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
      OutsidePoint(name: 'озеро Хыйропское', latitude: 43.3771, longitude: 41.6568),

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

