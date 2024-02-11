import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:russ_travel/map/domain/app_latitude_longitude.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/location_service.dart';
import '../../domain/museum_point.dart';
import '../../domain/outside_point.dart';
import '../../domain/park_point.dart';
import 'clusters_collection.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;
  double _mapZoom = 0.0;
  late Future<List<PlacemarkMapObject>> _placemarkObjectsFuture;

  @override
  void initState() {
    super.initState();
    _placemarkObjectsFuture = _getPlacemarkObjectsO(context);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта открытий')),
      body: FutureBuilder<List<PlacemarkMapObject>>(
        future: _placemarkObjectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return YandexMap(
              onMapCreated: (controller) {
                _mapController = controller;
                _moveCameraToInitialPosition();
              },
              onCameraPositionChanged: (cameraPosition, _, __) {
                setState(() {
                  _mapZoom = cameraPosition.zoom;
                });
              },
              mapObjects: [
                _getClusterizedCollection(placemarks: snapshot.data!),
              ],
            );
          }
        },
      ),
    );
  }

  void _moveCameraToInitialPosition() async {
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
/// Метод для получения коллекции кластеризованных маркеров
  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: placemarks,
      radius: 50,
      minZoom: 15,
      onClusterAdded: (self, cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1.0,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await ClusterPoints(cluster.size).getClusterIconBytes(),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        await _mapController.moveCamera(
          animation: const MapAnimation(
            type: MapAnimationType.linear,
            duration: 0.3,
          ),
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: cluster.placemarks.first.point,
              zoom: _mapZoom + 1,
            ),
          ),
        );
      },
    );
  }
}
  // /// Методы для генерации точек на карте
  // /// Музеи, исторические здания (икзампел: Спасская башня, Эрмитаж, Исакиевский собор, ...)
  // List<MuseumPoint> _getMapPointsM() {
  //   return const [
  //     // СЗФО
  //     // республика Коми
  //     MuseumPoint(name: 'Пожарная каланча Сыктывкара', latitude: 61.673001, longitude: 50.837413),
  //     MuseumPoint(name: 'Национальный музей Республики Коми' , latitude: 61.66909, longitude: 50.83829),
  //     // Ненецкий АО
  //     MuseumPoint(name: 'Музей-заповедник «Пустозерск»', latitude: 67.6413, longitude: 53.0070833),
  //     MuseumPoint(name: 'Ненецкий краеведческий музей', latitude: 67.640480, longitude: 53.010441),
  //     MuseumPoint(name: 'Этнокультурный центр Ненецкого автономного округа', latitude: 67.6404610, longitude: 53.0034470),
  //     // Архангельская область
  //     MuseumPoint(name: 'Космодром Плесецк', latitude: 62.96, longitude: 40.68),
  //     MuseumPoint(name: 'Малые Корелы', latitude: 64.452927, longitude: 40.931691),
  //     MuseumPoint(name: 'Историко-мемориальный музей М. В. Ломоносова', latitude: 64.22972, longitude: 41.73361),
  //     MuseumPoint(name: 'Музей деревянного зодчества «Малые Корелы»', latitude: 64.454843, longitude: 40.951519),
  //     MuseumPoint(name: 'музей полярного капитана Александра Кучина', latitude: 64.226920, longitude: 41.838274),
  //     MuseumPoint(name: 'Онежский историко-мемориальный музей', latitude: 63.898530715044, longitude: 38.129629777158),
  //     // Вологодская область
  //     MuseumPoint(name: 'Кирилло-Белозерский монастырь', latitude: 59.856507, longitude: 38.369435),
  //     MuseumPoint(name: 'Вологодский кремль', latitude: 59.224117, longitude: 39.881791),
  //     MuseumPoint(name: 'Ферапонтов Белозерский монастырь', latitude: 59.956496, longitude: 38.567472),
  //     MuseumPoint(name: 'Картуши в Тотьме', latitude: 59.9737800, longitude: 42.7651610),
  //     MuseumPoint(name: 'Белозерский кремль', latitude: 60.030953, longitude: 37.788606),
  //     MuseumPoint(name: 'Соборное дворище', latitude: 60.7608, longitude: 46.2972),
  //     MuseumPoint(name: 'Троице-Гледенский монастырь', latitude: 60.7177111, longitude: 46.3137944),
  //     MuseumPoint(name: 'Архитектурно-этнографический музей «Семёнково»', latitude: 59.2786646119338, longitude: 39.715944191154456),
  //     MuseumPoint(name: 'Дом-музей Петра I', latitude: 59.20998500, longitude: 39.90819100),
  //     MuseumPoint(name: 'Музей «Вологодская ссылка»', latitude: 59.215811, longitude: 39.884481),
  //     MuseumPoint(name: 'Музей металлургической промышленности', latitude: 59.133528533158405, longitude: 37.84594819858926),
  //     MuseumPoint(name: 'Музей «Подводная лодка Б-440»', latitude: 60.998236, longitude: 36.433181),
  //     MuseumPoint(name: 'Музей новогодней и рождественской игрушки', latitude: 60.7530, longitude: 46.3117),
  //     // Мурманская область
  //     MuseumPoint(name: 'Музей ВВС Северного флота', latitude: 69.065369, longitude: 33.294752),
  //     // Карелия
  //     MuseumPoint(name: 'Национальный музей Республики Карелия', latitude: 61.786944, longitude: 34.363889),
  //     MuseumPoint(name: 'Музей изобразительных искусств Республики Карелия', latitude: 61.787778, longitude: 34.382222),
  //     MuseumPoint(name: 'Музей-заповедник «Кижи»', latitude: 62.084948, longitude: 35.212189),
  //     MuseumPoint(name: 'Шелтозерский вепсский этнографический музей', latitude: 61.3687, longitude: 35.358),
  //     MuseumPoint(name: 'Морской музей «Полярный Одиссей»', latitude: 61.779906, longitude: 34.415936),
  //     // Ленинградская область
  //     MuseumPoint(name: 'Фондовая площадка списанных поездов «Пионерский парк»', latitude: 59.953224, longitude: 29.399258),
  //     MuseumPoint(name: 'Музей-диорама «Прорыв блокады Ленинграда»', latitude: 59.908545, longitude: 30.994313),
  //     MuseumPoint(name: 'Красногвардейский Укрепрайон', latitude: 59.635994, longitude: 30.033755),
  //     MuseumPoint(name: 'Форт Красная Горка', latitude: 59.973362, longitude: 29.327877),
  //     MuseumPoint(name: 'Мемориал «Разорванное кольцо»', latitude: 60.081502, longitude: 31.067323),
  //     MuseumPoint(name: 'Музей-усадьба Репина «Пенаты»', latitude: 60.155808, longitude: 29.896564),
  //     MuseumPoint(name: 'Крепость Корела', latitude: 61.029793, longitude: 30.122838),
  //     MuseumPoint(name: 'Парковый комплекс «Усадьба Богословка»', latitude: 59.8267166, longitude: 30.5689045),
  //     MuseumPoint(name: 'Большой гатчинский дворец', latitude: 59.5632, longitude: 30.1074),
  //     MuseumPoint(name: 'Родовое имение Строгановых-Голицыных – усадьба Марьино', latitude: 59.41806, longitude: 30.90278),
  //     MuseumPoint(name: 'Музей-усадьба «Рождествено»', latitude: 59.3251, longitude: 29.9359),
  //     MuseumPoint(name: 'Музей-усадьба Приютино', latitude: 60.03068924, longitude: 30.655017853),
  //     // Санкт-Петербург
  //     MuseumPoint(name: 'Исаакиевский собор', latitude: 59.933694, longitude: 30.3061425),
  //     MuseumPoint(name: 'Эрмитаж', latitude: 59.939844, longitude: 30.314557),
  //     MuseumPoint(name: 'Медный всадник', latitude: 59.9363783, longitude: 30.3022304),
  //     MuseumPoint(name: 'Кунсткамера', latitude: 59.9414967, longitude: 30.3045327),
  //     MuseumPoint(name: 'Собор Спаса-на-Крови', latitude: 59.940037, longitude: 30.328930),
  //     MuseumPoint(name: 'Русский музей', latitude: 59.9385918, longitude: 30.3322212),
  //     MuseumPoint(name: 'Крейсер «Аврора»', latitude: 59.9554045, longitude: 30.337833),
  //     MuseumPoint(name: 'Адмиралтейство', latitude: 59.9374583, longitude: 30.30855),
  //     MuseumPoint(name: 'Михайловский замок', latitude: 59.9399937, longitude: 30.3380463),
  //     MuseumPoint(name: 'Магазин купцов Елисеевых', latitude: 59.934263, longitude: 30.337982),
  //     MuseumPoint(name: 'Дом Зингера', latitude: 59.935667, longitude: 30.325917),
  //     MuseumPoint(name: 'Александро-Невская лавра', latitude: 59.922301, longitude: 30.387454),
  //     MuseumPoint(name: 'Морской Никольский собор в Кронштадте', latitude: 59.991672, longitude: 29.777801),
  //     MuseumPoint(name: 'Музей современного искусства Эрарта', latitude: 59.932029, longitude: 30.251525),
  //     MuseumPoint(name: 'Аптека Пеля и Башня грифонов', latitude: 59.93833, longitude: 30.28384),
  //     MuseumPoint(name: 'Петербург в миниатюре', latitude: 59.9386, longitude: 30.3141),
  //     MuseumPoint(name: 'Музей теней', latitude: 59.9403952, longitude: 30.3238216),
  //     MuseumPoint(name: 'Мемориальный музей Достоевского', latitude: 59.9270826, longitude: 30.3505176),
  //     MuseumPoint(name: 'Гранд макет «Россия»', latitude: 59.88741100, longitude: 30.32998900),
  //     MuseumPoint(name: 'Музей Фаберже', latitude: 59.93444, longitude: 30.34306),
  //     MuseumPoint(name: 'Музей обороны и блокады Ленинграда', latitude: 59.944444, longitude: 30.340833),
  //     MuseumPoint(name: 'Музей самоизоляции', latitude: 55.797661, longitude: 49.106815),
  //     MuseumPoint(name: 'Главный штаб', latitude: 59.939043, longitude: 30.318658),
  //     MuseumPoint(name: 'Смольный', latitude: 59.9461973, longitude: 30.3968174),
  //     MuseumPoint(name: 'Домик Петра I', latitude: 59.953333, longitude: 30.330833),
  //     MuseumPoint(name: 'Музей Пушкина на Мойке', latitude: 59.941209, longitude: 30.32124),
  //     MuseumPoint(name: 'Консерватория имени Н.А. Римского-Корсакова', latitude: 59.92583, longitude: 30.29806),
  //     MuseumPoint(name: 'Академия художеств', latitude: 59.93749400, longitude: 30.29020500),
  //     MuseumPoint(name: 'Малый Эрмитаж', latitude: 59.9412470, longitude: 30.3157100),
  //     MuseumPoint(name: 'Новый Эрмитаж', latitude: 59.939844, longitude: 30.314557),
  //     MuseumPoint(name: 'Инженерный замок', latitude: 59.940371, longitude: 30.337798),
  //     MuseumPoint(name: 'Воронцовский дворец', latitude: 59.93139, longitude: 30.33194),
  //     MuseumPoint(name: 'Строгановский дворец', latitude: 59.9357046, longitude: 30.320118),
  //     MuseumPoint(name: 'Ледовый дворец', latitude: 59.921670, longitude: 30.466390),
  //     MuseumPoint(name: 'Военно-исторический музей артиллерии, инженерных войск и войск связи', latitude: 59.9539, longitude: 30.3138),
  //     // Новгородская область
  //     MuseumPoint(name: 'Новгородский детинец', latitude: 58.521667, longitude: 31.276111),
  //     MuseumPoint(name: 'Музей деревянного зодчества «Витославлицы»', latitude: 58.49153, longitude: 31.272311),
  //     MuseumPoint(name: 'Музейный комплекс «Славянская деревня Х века»', latitude: 58.812776, longitude: 33.371713),
  //     MuseumPoint(name: 'Музей-усадьба Александра Суворова', latitude: 58.652958, longitude: 34.066157),
  //     MuseumPoint(name: 'Музей колоколов в Валдае', latitude: 57.96764900, longitude: 33.25003600),
  //     MuseumPoint(name: 'Урочище Перынь', latitude: 58.47315400, longitude: 31.2732320),
  //     MuseumPoint(name: 'Дом-музей Некрасова «Чудовская Лука»', latitude: 59.117583, longitude: 31.662985),
  //     MuseumPoint(name: 'Свято-Юрьев монастырь', latitude: 58.486606, longitude: 31.284708),
  //     MuseumPoint(name: 'Храм Спаса Преображения в Великом Новгороде', latitude: 58.517455, longitude: 31.295528),
  //     MuseumPoint(name: 'Музей Северо-Западного фронта в Старой Руссе', latitude: 57.992706, longitude: 31.363169),
  //     MuseumPoint(name: 'Музей уездного города в Валдае', latitude: 57.977625, longitude: 33.256659),
  //     // Псковская область
  //     MuseumPoint(name: 'Псковский Кремль', latitude: 57.8220008, longitude: 28.3289796),
  //     MuseumPoint(name: 'Псково-Печерский монастырь', latitude: 57.8100631, longitude: 27.6149939),
  //     MuseumPoint(name: 'Музей-усадьба «Михайловское»', latitude: 56.25670200, longitude: 31.34997700),
  //     MuseumPoint(name: 'Музей-усадьба «Петровское»', latitude: 57.07988700, longitude: 28.948374),
  //     MuseumPoint(name: 'Музей-усадьба «Тригорское»', latitude: 57.16305700, longitude: 28.839111),
  //     MuseumPoint(name: 'Палаты Меньшиковых в Пскове', latitude: 57.812261, longitude: 28.335448),
  //     MuseumPoint(name: 'Гдовский кремль', latitude: 56.567222, longitude: 28.775),
  //     // Калининградская область
  //     MuseumPoint(name: 'Замок Шаакен', latitude: 54.90583, longitude: 20.66889),
  //     MuseumPoint(name: 'Музей «Вальдавский замок»', latitude: 54.700544, longitude: 20.742786),
  //     MuseumPoint(name: 'Музей «Средневековое городище Ушкуй»', latitude: 54.471680, longitude: 21.066061),
  //     MuseumPoint(name: 'Музей «Поселение викингов Кауп»', latitude: 54.878422, longitude: 20.278862),
  //     MuseumPoint(name: 'Музей филинов и сов «ФилоСовия»', latitude: 54.956090, longitude: 20.477775),
  //     MuseumPoint(name: 'Музей «Старая немецкая школа Вальдвинкель»', latitude: 54.867357, longitude: 21.248785),
  //     MuseumPoint(name: 'Музей пыток в Орловке', latitude: 54.793098, longitude: 20.533545),
  //     MuseumPoint(name: 'Музей кошек «Мурариум» в Зеленоградске', latitude: 54.959795, longitude: 20.482545),
  //     // ЦФО
  //     // Москва
  //     MuseumPoint(name: 'Государственная Третьяковская галерея', latitude: 55.741556, longitude: 37.620028),
  //     MuseumPoint(name: 'Государственная Третьяковская галерея, галерея Новая Третьяковка', latitude: 55.734719, longitude: 37.605976),
  //     MuseumPoint(name: 'Оружейная палата', latitude: 55.749455, longitude: 37.613473),
  //     MuseumPoint(name: 'Музей космонавтики', latitude: 55.822710, longitude: 37.639743),
  //     MuseumPoint(name: 'Выставка Алмазный фонд Гохрана России', latitude: 55.749593, longitude: 37.613807),
  //     MuseumPoint(name: 'Государственный музей А. С. Пушкина', latitude: 55.743575, longitude: 37.597736),
  //     MuseumPoint(name: 'Государственный Дарвиновский музей', latitude: 55.690797, longitude: 37.561547),
  //     MuseumPoint(name: 'Музей-Диорама Царь-Макет', latitude: 55.817173, longitude: 37.655321),
  //     MuseumPoint(name: 'Государственный музей Владимира Высоцкого', latitude: 55.744448, longitude: 37.651790),
  //     MuseumPoint(name: 'Музей Михаила Афанасьевича Булгакова', latitude: 55.766996, longitude: 37.593880),
  //     MuseumPoint(name: 'научно-исследовательский музей архитектуры имени А.В. Щусева', latitude: 55.752481, longitude: 37.607368),
  //     MuseumPoint(name: 'Государственный музей Востока', latitude: 55.756432, longitude: 37.599815),
  //     MuseumPoint(name: 'Музей Победы', latitude: 55.730588, longitude: 37.504063),
  //     MuseumPoint(name: 'Музей Вооружённых Сил ', latitude: 55.784916, longitude: 37.617124),
  //     MuseumPoint(name: 'Государственный музей обороны Москвы', latitude: 55.676652, longitude: 37.467568),
  //     MuseumPoint(name: 'Музей-панорама Бородинская битва', latitude: 55.738752, longitude: 37.523187),
  //     MuseumPoint(name: 'Музей Отечественной войны 1812 года', latitude: 55.756234, longitude: 37.618696),
  //     MuseumPoint(name: 'Павильон Макет Москвы', latitude: 55.834390, longitude: 37.630086),
  //     MuseumPoint(name: 'ГЭС-2', latitude: 55.742751, longitude: 37.612732),
  //     // Подмосковье
  //     MuseumPoint(name: 'Музей коломенской пастилы', latitude: 55.104594, longitude: 38.769860),
  //     MuseumPoint(name: 'Музей "Калачная"', latitude: 55.105801, longitude: 38.763801),
  //     MuseumPoint(name: 'Музейный комплекс "Конный двор"', latitude: 56.313635, longitude: 38.133183),
  //     MuseumPoint(name: 'Музей Арт-Макет', latitude: 56.312128, longitude: 38.137571),
  //     MuseumPoint(name: 'Музей Аэрофлота', latitude: 55.982753, longitude: 37.407782),
  //     MuseumPoint(name: 'Дом-Музей Чайковского П.И.', latitude: 56.328918, longitude: 36.747430),
  //     MuseumPoint(name: 'Клинское Подворье', latitude: 56.337918, longitude: 36.721691),
  //     MuseumPoint(name: 'Интерактивный музей имени Героев-панфиловцев', latitude: 55.981099, longitude: 36.035060),
  //     MuseumPoint(name: 'Музей Дмитровской лягушки', latitude: 56.344531, longitude: 37.522309),
  //     // Рязанская область
  //     MuseumPoint(name: 'Музей истории Воздушно-десантных войск', latitude: 54.633091, longitude: 39.736315),
  //     MuseumPoint(name: 'Рязанский музей дальней авиации', latitude: 54.653798, longitude: 39.588518),
  //     // Тамбовская область
  //     MuseumPoint(name: 'Усадьба Асеевых', latitude: 52.707157, longitude: 41.477798),
  //     MuseumPoint(name: 'Тамбовский областной краеведческий музей', latitude: 52.725193, longitude: 41.453714),
  //     // Воронежская область
  //     MuseumPoint(name: 'Петровские корабли', latitude: 51.661738, longitude: 39.188083),
  //     MuseumPoint(name: 'Воронежский областной краеведческий музей', latitude: 51.666628, longitude: 39.193560),
  //     // Белгородская область
  //     MuseumPoint(name: 'Музей-диорама «Курская битва»', latitude: 50.591283, longitude: 36.587800),
  //     MuseumPoint(name: 'Музей «Прохоровское поле»', latitude: 51.042701, longitude: 36.749264),
  //     // Курская область
  //     MuseumPoint(name: 'Курский областной краеведческий музей', latitude: 51.727587, longitude: 36.191589),
  //     MuseumPoint(name: 'Курск – город воинской славы', latitude: 51.756923, longitude: 36.187768),
  //     MuseumPoint(name: 'Историко-мемориальный музей КП Центрального фронта', latitude: 51.971378, longitude: 36.310867),
  //     // Орловская область
  //     MuseumPoint(name: 'Орловский краеведческий музей', latitude: 52.964147, longitude: 36.068431),
  //     // Липецкая область
  //     MuseumPoint(name: 'Липецкий областной краеведческий музей', latitude: 52.613984, longitude: 39.608564),
  //     MuseumPoint(name: 'Автолегенда', latitude: 52.583095, longitude: 39.566307),
  //     MuseumPoint(name: 'Музей Елецкого кружева', latitude: 52.619734, longitude: 38.501905),
  //     // Тульская область
  //     MuseumPoint(name: 'Тульский государственный музей оружия', latitude: 54.204272, longitude: 37.616499),
  //     MuseumPoint(name: 'Музей Тульский пряник', latitude: 54.211566, longitude: 37.622105),
  //     MuseumPoint(name: 'Музей гармони Деда Филимона', latitude: 54.192505, longitude: 37.621713),
  //     MuseumPoint(name: 'Музей станка', latitude: 54.191087, longitude: 37.612136),
  //     MuseumPoint(name: 'Тульский Историко-архитектурный музей', latitude: 54.190004, longitude: 37.614505),
  //     MuseumPoint(name: 'Исторический музей', latitude: 54.197853, longitude: 37.617136),
  //     MuseumPoint(name: 'Музейно-мемориальный комплекс героям Куликовской битвы', latitude: 53.670591, longitude: 38.642492),
  //     MuseumPoint(name: 'Музей-заповедник Куликово поле', latitude: 53.623942, longitude: 38.672613),
  //     // Калужская область
  //     MuseumPoint(name: 'Музей истории космонавтики', latitude: 54.516970, longitude: 36.230691),
  //     MuseumPoint(name: 'Мемориальный дом-музей К.Э. Циолковского', latitude: 54.511175, longitude: 36.230194),
  //     MuseumPoint(name: 'Музейно-краеведческий комплекс Усадьба Золотарёвых', latitude: 54.510688, longitude: 36.245533),
  //     MuseumPoint(name: 'Военно-исторический центр Маршал Победы - Георгий Константинович Жуков', latitude: 54.516493, longitude: 36.283567),
  //     MuseumPoint(name: 'Музей-диорама Великое Стояние на реке Угре', latitude: 54.614173, longitude: 35.999558),
  //     MuseumPoint(name: 'Бузеон', latitude: 54.738701, longitude: 35.995741),
  //     // Смоленская область
  //     MuseumPoint(name: 'Музей Великой Отечественной войны', latitude: 54.779374, longitude: 32.047485),
  //     MuseumPoint(name: 'Музей Смоленская крепость, Башня Громовая', latitude: 54.780070, longitude: 32.043756),
  //     // Тверская область
  //     MuseumPoint(name: 'Музей козла', latitude:56.853323 , longitude: 35.910438),
  //     MuseumPoint(name: 'Музей Плюшкина', latitude: 56.855986, longitude: 35.917648),
  //     MuseumPoint(name: 'Музей тверского быта', latitude: 56.866496, longitude: 35.910294),
  //     // Ярославская область
  //     MuseumPoint(name: 'Музыка и время', latitude: 57.630078, longitude: 39.895167),
  //     MuseumPoint(name: 'Ярославский художественный музей', latitude: 57.628289, longitude: 39.897206),
  //     MuseumPoint(name: 'Музей истории города Ярославля', latitude: 57.627059, longitude: 39.898601),
  //     MuseumPoint(name: 'Мультимедийный музей нового взгляда на историю', latitude: 57.632396, longitude: 39.893411),
  //     MuseumPoint(name: 'Музей боевой славы', latitude: 57.633218, longitude: 39.831700),
  //     MuseumPoint(name: 'Музей им. В. Ю. Орлова', latitude: 57.626421, longitude: 39.899205),
  //     MuseumPoint(name: 'Рыбинский музей-заповедник', latitude: 58.049425, longitude: 38.856285),
  //     MuseumPoint(name: 'Музей кожевенного ремесла', latitude: 57.529793, longitude: 38.321620),
  //     MuseumPoint(name: 'Музей Царевны-лягушки', latitude: 57.182759, longitude: 39.405209),
  //     MuseumPoint(name: 'Музей Народного Искусства', latitude: 57.181900, longitude: 39.403927),
  //     MuseumPoint(name: 'Богатырское подворье Алёши Поповича и мастерская Марьи Искусницы', latitude: 57.183159, longitude: 39.402175),
  //     MuseumPoint(name: 'Музей Ростовское подворье', latitude: 57.186380, longitude: 39.416443),
  //     MuseumPoint(name: 'Ростовская пряница', latitude: 57.181641, longitude: 39.400977),
  //     MuseumPoint(name: 'Шоу-макет Золотое кольцо', latitude: 57.626970, longitude: 39.897280),
  //     MuseumPoint(name: 'Музей баклуши и библиотека варенья', latitude: 57.311617, longitude: 39.518694),
  //     MuseumPoint(name: 'Мышкины палаты', latitude: 57.785626, longitude: 38.453800),
  //     // Костромская область
  //     MuseumPoint(name: 'Музей-усадьба льна и бересты', latitude: 57.778283, longitude: 40.912275),
  //     // Ивановская область
  //     MuseumPoint(name: 'Музей Ивановского ситца', latitude: 57.004843, longitude: 40.973890),
  //     // Владимирская область
  //     MuseumPoint(name: 'Музей Старый Владимир', latitude: 56.125151, longitude: 40.398685),
  //     MuseumPoint(name: 'Кузница-музей Бородиных', latitude:56.126805, longitude: 40.402610),
  //     MuseumPoint(name: 'Музей-сказка Бабуся-Ягуся', latitude: 56.127675, longitude: 40.402115),
  //     MuseumPoint(name: 'Нескучный Mузей Изба Трактир', latitude: 56.417028, longitude: 40.448934),
  //     MuseumPoint(name: 'Музей восковых фигур', latitude: 56.418694, longitude: 40.448229),
  //     MuseumPoint(name: 'Музей Огни Владимира', latitude: 56.127620, longitude: 40.399929),
  //     // СКФО
  //     // Ставропольский край
  //     MuseumPoint(name: 'Ставропольский государственный историко-культурный и природно-ландшафтный музей-заповедник имени Г. Н. Прозрителева и Г. К. Праве', latitude: 45.044704, longitude: 41.968207),
  //     MuseumPoint(name: 'Пятигорский краеведческий музей', latitude: 44.036116, longitude: 43.079856),
  //     MuseumPoint(name: 'Домик М. Ю. Лермонтова', latitude: 44.039582, longitude: 43.078808),
  //     MuseumPoint(name: 'Кисловодский историко-краеведческий музей Крепость', latitude: 43.894760, longitude: 42.716415),
  //     MuseumPoint(name: 'Музей истории и природы национального парка Кисловодский', latitude: 43.900446, longitude: 42.717017),
  //     // Карачаево-Черкесская республика
  //     MuseumPoint(name: 'Планетарий САО', latitude: 43.675582, longitude: 41.457283),
  //     // Кабардино-Балкарская республика
  //     MuseumPoint(name: 'Национальный музей КБР', latitude: 43.486557, longitude: 43.608177),
  //     MuseumPoint(name: 'Минеральная питьевая галерея «Источник Нальчик»', latitude: 43.456847, longitude: 43.584925),
  //     MuseumPoint(name: 'Музей Обороны Приэльбрусья', latitude: 43.290087, longitude: 42.460457),
  //     // Республика Северная Осетия — Алания
  //     MuseumPoint(name: 'Национальный музей Республики Северная Осетия-Алания', latitude: 43.027313, longitude: 44.680652),
  //     MuseumPoint(name: 'Художественный музей имени М. С. Туганова', latitude: 43.028980, longitude: 44.681150),
  //     MuseumPoint(name: 'Музей истории Владикавказа', latitude: 43.034926, longitude: 44.682355),
  //     // Чечня
  //     MuseumPoint(name: 'Музей Чеченской Республики', latitude: 43.324217, longitude: 45.682400),
  //     // Дагестан
  //     MuseumPoint(name: 'Национальный музей Республики Дагестан', latitude: 42.982774, longitude: 47.510731),
  //     MuseumPoint(name: 'Дагестанский музей изобразительных искусств имени П.С. Гамзатовой', latitude: 42.982373, longitude: 47.510807),
  //     MuseumPoint(name: 'Музей-заповедник – этнографический комплекс Дагестанский аул', latitude: 42.982669, longitude: 47.510925),
  //     MuseumPoint(name: 'Музей ковры и декоративно-прикладное искусство Дагестана', latitude: 42.057105, longitude: 48.287133),
  //     MuseumPoint(name: 'Этно Дом Кубачи', latitude: 42.061562, longitude: 48.304272),
  //     MuseumPoint(name: 'Хунзахский музей', latitude: 42.538085, longitude: 46.702862),
  //     //ПФО
  //     // Казань
  //     MuseumPoint(name: 'Национальный музей Республики Татарстан',
  //         latitude: 55.795712,
  //         longitude: 49.109801),
  //     MuseumPoint(name: 'Музей Чак-Чака',
  //         latitude: 55.782046,
  //         longitude: 49.112496),
  //     MuseumPoint(name: 'Музей иллюзий',
  //         latitude: 55.791638,
  //         longitude: 49.113556),
  //     MuseumPoint(name: 'Дом-Музей Василия Аксенова',
  //         latitude: 55.795444,
  //         longitude: 49.135196),
  //     MuseumPoint(name: 'Литературно-мемориальный музей А.М. Горького',
  //         latitude: 55.793505,
  //         longitude: 49.129653),
  //     MuseumPoint(name: 'Музей чая',
  //         latitude: 55.781008,
  //         longitude: 49.115685),
  //     MuseumPoint(name: 'Музей Е. А. Боратынского, филиал Национального музея Республики Татарстан',
  //         latitude: 55.79387,
  //         longitude: 49.135421),
  //     MuseumPoint(name: 'Музей-квартира Мусы Джалиля',
  //         latitude: 55.794072,
  //         longitude: 49.132214),
  //     MuseumPoint(name: 'Музей "Городская панорама"',
  //         latitude: 55.796273,
  //         longitude: 49.114247),
  //     MuseumPoint(name: 'Дом-музей В.И. Ленина',
  //         latitude: 55.786915,
  //         longitude: 49.138807),
  //     MuseumPoint(name: 'Государственный музей изобразительных искусств Республики Татарстан',
  //         latitude: 55.794953,
  //         longitude: 49.134909),
  //
  //     // Самара
  //     MuseumPoint(name: 'Самарский областной историко-краеведческий музей им. П.В. Алабина',
  //         latitude: 53.192765,
  //         longitude: 50.10906),
  //     MuseumPoint(name: 'Музей модерна',
  //         latitude: 53.194238,
  //         longitude: 50.096214),
  //     MuseumPoint(name: 'Музей-усадьба А. Толстого. Самарский литературно-мемориальный музей им. М. Горького. Музей Буратино',
  //         latitude: 53.193574,
  //         longitude: 50.095729),
  //     MuseumPoint(name: 'Дом-музей В.И.Ленина в г. Самаре',
  //         latitude: 53.193116,
  //         longitude: 50.11082),
  //     MuseumPoint(name: 'Дом-музей М.В. Фрунзе',
  //         latitude: 53.191546,
  //         longitude: 50.093752),
  //     MuseumPoint(name: 'Музей Эльдара Рязанова',
  //         latitude: 53.192695,
  //         longitude: 50.094507),
  //     MuseumPoint(name: 'Поволжский музей железнодорожной техники',
  //         latitude: 53.222897,
  //         longitude: 50.293232),
  //     MuseumPoint(name: 'Музей авиации и космонавтики имени С.П. Королёва Московское ш.',
  //         latitude: 53.195878,
  //         longitude: 50.100202),
  //     MuseumPoint(name: 'Самарский военно-исторический музей',
  //         latitude: 53.196682,
  //         longitude: 50.095261),
  //     MuseumPoint(name: 'Зоологический музей им. В.Н. Темнохолмова СГСПУ Antonova-Ovseyenko',
  //         latitude: 53.195658629268216,
  //         longitude: 50.09953186911404),
  //     MuseumPoint(name: 'Самарский областной художественный музей',
  //         latitude: 53.189431,
  //         longitude: 50.089845),
  //     MuseumPoint(name: 'Музей лягушки',
  //         latitude: 53.179799,
  //         longitude: 50.075166),
  //     MuseumPoint(name: 'Военно-исторический музей ПУРВО Рабочая',
  //         latitude: 53.195878,
  //         longitude: 50.100202),
  //     MuseumPoint(name: 'Музей истории города Самары им. М.Д. Челышова',
  //         latitude: 53.18329,
  //         longitude: 50.088973),
  //     MuseumPoint(name: 'Самарский епархиальный церковно-исторический музей',
  //         latitude: 53.205803,
  //         longitude: 50.141372),
  //     MuseumPoint(name: 'Музей Археологии Поволжья',
  //         latitude: 53.192301,
  //         longitude: 50.110281),
  //
  //     // Нижний Новгород
  //     MuseumPoint(name: 'Музей истории художественных промыслов Нижегородской Большая Покровская',
  //         latitude: 56.326797,
  //         longitude: 44.006516),
  //     MuseumPoint(name: 'Музей А.М.Горького',
  //         latitude: 56.325918,
  //         longitude: 44.026046),
  //     MuseumPoint(name: 'Государственный Русский музей фотографии',
  //         latitude: 56.323897,
  //         longitude: 44.003139),
  //     MuseumPoint(name: 'Технический музей Большая Покровская',
  //         latitude: 56.326797,
  //         longitude: 44.006516),
  //     MuseumPoint(name: 'Музей А. Д. Сахарова',
  //         latitude: 56.232419,
  //         longitude: 43.95056),
  //     MuseumPoint(name: 'Нижегородский государственный художественный музей (русская и советская живопись)',
  //         latitude: 56.329552,
  //         longitude: 44.0064),
  //     MuseumPoint(name: 'Музей речного флота',
  //         latitude: 56.327985,
  //         longitude: 44.015931),
  //     MuseumPoint(name: 'Музей старинной техники и инструментов',
  //         latitude: 56.318136,
  //         longitude: 43.995234),
  //     MuseumPoint(name: 'Нижегородский Городской Музей Техники И Оборонной Промышленности',
  //         latitude: 56.32482,
  //         longitude: 44.018716),
  //     MuseumPoint(name: 'Музей истории завода "Красное Сормово"',
  //         latitude: 56.359813,
  //         longitude: 43.870026),
  //     MuseumPoint(name: 'Музей Истории и Трудовой славы ГАЗ',
  //         latitude: 56.254727,
  //         longitude: 43.893176),
  //
  //     //Уфа
  //     MuseumPoint(name: 'Музей истории города Уфы',
  //         latitude: 54.7336360735005,
  //         longitude: 55.951346541664044),
  //     MuseumPoint(name: 'Дом-музей В.И. Ленина',
  //         latitude: 54.732881,
  //         longitude: 55.953211),
  //     MuseumPoint(name: 'Республиканский историко-культурный музей-заповедник Древняя Уфа',
  //         latitude: 54.733974025182896,
  //         longitude: 55.9468867281723),
  //     MuseumPoint(name: 'Музей археологии и этнографии Института этнологических исследований им. Р.Г. Кузеева',
  //         latitude: 54.721068,
  //         longitude: 55.939216),
  //     MuseumPoint(name: 'Зоологический музей Башкирского государственного университета',
  //         latitude: 54.72013821117435,
  //         longitude: 55.933894135075825),
  //     MuseumPoint(name: 'Музей Башкирского государственного театра оперы и балета',
  //         latitude: 54.722418853265495,
  //         longitude: 55.9453068657455),
  //     MuseumPoint(name: 'Национальный музей Республики Башкортостан',
  //         latitude: 54.72013389739121,
  //         longitude: 55.946777949073734),
  //     MuseumPoint(name: 'Дом-музей Ш. Худайбердина',
  //         latitude: 54.719368,
  //         longitude: 55.955825),
  //     MuseumPoint(name: 'Музей истории парламента Республики Башкортостан',
  //         latitude: 54.717792,
  //         longitude: 55.946339),
  //
  //     // Пермь
  //     MuseumPoint(name: 'Музей Пермского отделения Свердловской железной дороги',
  //         latitude: 57.996482,
  //         longitude: 56.188732),
  //     MuseumPoint(name: 'Пермская государственная художественная галерея',
  //         latitude: 58.016414,
  //         longitude: 56.234689),
  //     MuseumPoint(name: 'Музей пермских древностей',
  //         latitude: 58.014126,
  //         longitude: 56.24546),
  //     MuseumPoint(name: 'ГБУК Пермского края Мемориальный музей-заповедник истории политических репрессий Пермь-36',
  //         latitude: 58.020128,
  //         longitude: 56.270874),
  //
  //     // Саратов
  //     MuseumPoint(name: 'МУЗЕЙ ИСТОРИИ САРАТОВСКОЙ МИТРОПОЛИИ',
  //         latitude: 51.525679,
  //         longitude: 46.027295),
  //     MuseumPoint(name: 'Музей самоваров',
  //         latitude: 51.536996,
  //         longitude: 46.030852),
  //     MuseumPoint(name: 'Саратовский областной музей краеведения',
  //         latitude: 51.527567,
  //         longitude: 46.056023),
  //     MuseumPoint(name: 'Музей речного флота',
  //         latitude: 51.521095,
  //         longitude: 46.006301),
  //     MuseumPoint(name: 'Музей истории саратовской полиции',
  //         latitude: 51.5441676271089,
  //         longitude: 46.00809231349183),
  //
  //     // Тольятти
  //     MuseumPoint(name: 'Тольяттинский краеведческий музей',
  //         latitude: 53.501935997704685,
  //         longitude: 49.42072019577029),
  //     MuseumPoint(name: 'Музей ОАО "АВТОВАЗ"',
  //         latitude: 53.552367,
  //         longitude: 49.272153),
  //     MuseumPoint(name: 'Тольяттинский художественный музей',
  //         latitude: 53.50314492328798,
  //         longitude: 49.420269589627814),
  //     MuseumPoint(name: 'Музей Тольяттинского Государственного Университета',
  //         latitude: 53.500665,
  //         longitude: 49.397908),
  //
  //     // Ижевск
  //     MuseumPoint(name: 'Национальный Музей Удмуртской Республики',
  //         latitude: 56.842393,
  //         longitude: 53.228504),
  //     MuseumPoint(name: 'Музей Хлеба',
  //         latitude: 56.872826,
  //         longitude: 53.260026),
  //     MuseumPoint(name: 'Музей Ижевского Автомобильного Завода',
  //         latitude: 56.886263,
  //         longitude: 53.309631),
  //     MuseumPoint(name: 'Музей Ижевска',
  //         latitude: 56.84676,
  //         longitude: 53.19789),
  //     MuseumPoint(name: 'Музейно-выставочный комплекс стрелкового оружия им. М.Т. Калашникова',
  //         latitude: 56.850742,
  //         longitude: 53.20672),
  //
  //     // Ульяновск
  //     MuseumPoint(name: 'Ульяновский областной краеведческий музей им. И.А. Гончарова',
  //         latitude: 54.315363,
  //         longitude: 48.405557),
  //     MuseumPoint(name: 'Литературный музей "Дом Языковых" ',
  //         latitude: 54.318341,
  //         longitude: 48.403482),
  //     MuseumPoint(name: 'Симбирская Классическая Гимназия Музей',
  //         latitude: 54.31609496725722,
  //         longitude: 48.40299244113913),
  //     MuseumPoint(name: 'Ульяновский областной художественный музей',
  //         latitude: 54.315363,
  //         longitude: 48.405557),
  //
  //     //Набережные Челны
  //     MuseumPoint(name: 'Музей воды',
  //         latitude: 55.663116,
  //         longitude: 52.276326),
  //     MuseumPoint(name: 'Историко-краеведческий музей города Набережные Челны',
  //         latitude: 55.685762,
  //         longitude: 52.295568),
  //     MuseumPoint(name: 'Музей истории пожарной охраны',
  //         latitude: 55.75725408838926,
  //         longitude: 52.451413280426),
  //     MuseumPoint(name: 'Музей Боевой Славы (ВОВ, Афганистан, Кавказ)',
  //         latitude: 55.728991,
  //         longitude: 52.406627),
  //
  //     // Оренбург
  //     MuseumPoint(name: 'Оренбургский губернаторский историко-краеведческий музей',
  //         latitude: 51.762057,
  //         longitude: 55.102219),
  //     MuseumPoint(name: 'Музей истории Оренбурга',
  //         latitude: 51.755523,
  //         longitude: 55.10849),
  //     MuseumPoint(name: 'Народный музей защитников Отечества',
  //         latitude: 51.77948103958744,
  //         longitude: 55.086406881614664),
  //     MuseumPoint(name: 'Мемориальный музей-гауптвахта Тараса Шевченко',
  //         latitude: 51.76051735005804,
  //         longitude: 55.10328859391786),
  //     MuseumPoint(name: 'Галерея выдающихся оренбуржцев',
  //         latitude: 51.764453,
  //         longitude: 55.100108),
  //
  //     // Пенза
  //     MuseumPoint(name: 'Пензенский государственный краеведческий музей',
  //         latitude: 53.186361,
  //         longitude: 45.007545),
  //     MuseumPoint(name: 'ГБУК Пензенская областная картинная галерея имени К.А. Савицкого',
  //         latitude: 53.184958,
  //         longitude: 45.010168),
  //     MuseumPoint(name: 'ГБУК Объединение государственных литературно-мемориальных музеев Пензенской области',
  //         latitude: 53.185379,
  //         longitude: 45.016214),
  //     MuseumPoint(name: 'Музей народного творчества',
  //         latitude: 53.175238,
  //         longitude: 45.005551),
  //     MuseumPoint(name: 'Дом-музей В. О. Ключевского',
  //         latitude: 53.191988,
  //         longitude: 45.007707),
  //
  //     // Чебоксары
  //     MuseumPoint(name: 'Чувашский государственный художественный музей',
  //         latitude: 56.141147,
  //         longitude: 47.261167),
  //     MuseumPoint(name: 'Центр современного искусства',
  //         latitude: 56.14565,
  //         longitude: 47.248168),
  //     MuseumPoint(name: 'Музей академика-кораблестроителя А.Н. Крылова',
  //         latitude: 56.131782,
  //         longitude: 47.24515),
  //     MuseumPoint(name: 'Археолого-этнографический музей имени профессора Каховского Василия Филипповича',
  //         latitude: 56.139095,
  //         longitude: 47.244916),
  //     MuseumPoint(name: 'Музей В.И. Чапаева',
  //         latitude: 56.116167,
  //         longitude: 47.257376),
  //     // ЮФО
  //     // Ростовская область
  //     MuseumPoint(name: 'Ростовский музей космонавтики', // Название точки
  //         latitude: 47.211245, // Координаты
  //         longitude: 39.619703),
  //     MuseumPoint(name: 'Ростовский областной музей изобразительных искусств', // Название точки
  //         latitude: 47.225709, // Координаты
  //         longitude: 39.715807),
  //     MuseumPoint(name: 'Музей железнодорожной техники Северо-Кавказской железной дороги', // Название точки
  //         latitude: 47.190481, // Координаты
  //         longitude: 39.636225),
  //     MuseumPoint(name: 'Археологический музей-заповедник «Танаис»', // Название точки
  //         latitude: 47.269111, // Координаты
  //         longitude: 39.334555),
  //     MuseumPoint(name: 'Новочеркасский музей истории Донского казачества', // Название точки
  //         latitude: 47.412306, // Координаты
  //         longitude: 40.104314),
  //     MuseumPoint(name: 'Аксайский военно-исторический музей', // Название точки
  //         latitude: 47.271300, // Координаты
  //         longitude: 39.891289),
  //     MuseumPoint(name: 'Волгодонский музей истории донской народной культуры «Казачий курень»', // Название точки
  //         latitude: 47.496935, // Координаты
  //         longitude: 42.185392),
  //     MuseumPoint(name: 'Усадьба-музей М. А. Шолохова в станице Вёшенской', // Название точки
  //         latitude: 49.626463, // Координаты
  //         longitude: 41.728758),
  //
  //   ];
  // }
  // /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  // List<ParkPoint> _getMapPointsP() {
  //   return const [
  //
  //     // Северо-Западный округ
  //
  //     // республика Коми
  //     ParkPoint(name: 'Югыд Ва', latitude: 63.9690289, longitude: 59.2200899),
  //     ParkPoint(name: 'Финно-угорский этнокультурный парк', latitude: 61.673248, longitude: 50.832223),
  //     ParkPoint(name: 'Печоро-Илычский биосферный заповедник', latitude: 61.822870, longitude: 56.824022),
  //     // Ненецкий АО
  //     ParkPoint(name: 'Ненецкий природный заповедник', latitude: 68.602778, longitude: 53.663056),
  //     ParkPoint(name: 'Памятник природы «Каменный город»', latitude: 67.301472, longitude: 48.984090),
  //     ParkPoint(name: 'Природный заказник «Море-Ю»', latitude: 68.171733, longitude: 59.948972),
  //     ParkPoint(name: 'Обдорский острог (Город мастеров)', latitude: 66.5222540, longitude: 66.5892110),
  //     ParkPoint(name: 'Пым-Ва-Шор', latitude: 67.1889, longitude: 60.873),
  //     // Архангельская область
  //     ParkPoint(name: 'Кенозерский национальный парк', latitude: 61.7709, longitude: 38.0473),
  //     ParkPoint(name: 'Земля Франца-Иосифа', latitude: 80.666667, longitude: 54.833333),
  //     ParkPoint(name: 'Пинежские пещеры', latitude: 64.405278, longitude: 43.156944),
  //     ParkPoint(name: 'Соловецкий ботанический сад', latitude: 65.052928, longitude: 35.659949),
  //     ParkPoint(name: 'Водлозерский национальный парк', latitude: 62.5, longitude: 36.917),
  //     ParkPoint(name: 'Минеральные источники в Куртяеве', latitude: 64.405037, longitude: 43.169696),
  //     ParkPoint(name: 'Пинежский заповедник', latitude: 64.676670, longitude: 43.19917),
  //     // Вологодская область
  //     ParkPoint(name: 'Вотчина Деда Мороза', latitude: 60.749116, longitude: 46.183799),
  //     ParkPoint(name: 'Национальный парк «Русский Север»', latitude: 59.8535, longitude: 38.3676),
  //     // Мурманская область
  //     ParkPoint(name: 'Кандалакшский заповедник', latitude: 66.766237, longitude: 33.632615),
  //     ParkPoint(name: 'Лапландский заповедник', latitude: 67.651389, longitude: 32.6475),
  //     ParkPoint(name: 'Природный парк «Полуостров Средний и Рыбачий»', latitude: 69.722194, longitude: 32.556514),
  //     ParkPoint(name: 'Горнолыжный курорт «Большой Вудъявр»', latitude: 67.5998375, longitude: 33.703715),
  //     ParkPoint(name: 'Заповедник «Пасвик»', latitude: 69.06667, longitude: 29.18611),
  //     ParkPoint(name: 'Национальный парк «Хибины»', latitude: 67.7252, longitude: 33.4738),
  //     // Карелия
  //     ParkPoint(name: 'Онежская набережная', latitude: 61.7921508, longitude: 34.3811189),
  //     ParkPoint(name: 'Ботанический сад ПетрГУ', latitude: 61.840927, longitude: 34.410100),
  //     ParkPoint(name: 'Зоокомплекс «Три медведя»', latitude: 61.949212, longitude: 33.406829),
  //     ParkPoint(name: 'Горный парк «Рускеала»', latitude: 61.946111, longitude: 30.581389),
  //     ParkPoint(name: 'Национальный парк «Ладожские Шхеры»', latitude: 61.5218, longitude: 30.5039),
  //     ParkPoint(name: 'Национальный парк «Паанаярви»', latitude: 65.7645, longitude: 31.0759),
  //     ParkPoint(name: 'горнолыжный курорт «Ялгора»', latitude: 61.8547496, longitude: 34.456752),
  //     ParkPoint(name: 'Санаторий «Марциальные воды»', latitude: 62.155286, longitude: 33.897355),
  //     ParkPoint(name: 'Национальный парк «Водлозерский»', latitude: 62.236293, longitude: 36.885769),
  //     ParkPoint(name: 'Национальный парк «Калевальский»', latitude: 64.99167, longitude: 30.2125),
  //     ParkPoint(name: 'Национальный парк Водлозерский', latitude: 62.5, longitude: 36.917),
  //     ParkPoint(name: 'Национальный парк Калевальский', latitude: 64.99167, longitude: 30.2125),
  //     ParkPoint(name: 'Парк Ваккосалми', latitude: 61.705583, longitude: 30.677228),
  //     ParkPoint(name: 'Карельский Зоопарк', latitude: 61.994236, longitude: 30.778658),
  //     ParkPoint(name: 'Беломорские петроглифы', latitude: 64.498089, longitude: 34.674721
  //     // Ленинградская область
  //     ParkPoint(name: 'Заповедник «Монрепо»', latitude: 60.732939, longitude: 28.727617),
  //     ParkPoint(name: 'Дудергофские высоты', latitude: 59.697778, longitude: 30.133611),
  //     ParkPoint(name: 'Гатчинские гейзеры', latitude: 59.546808, longitude: 30.012693),
  //     ParkPoint(name: 'Линдуловская роща', latitude: 60.237994, longitude: 29.540083),
  //     ParkPoint(name: 'Вепсский Лес', latitude: 60.5, longitude: 34.11667),
  //     ParkPoint(name: 'Карьер и известковые печи', latitude: 60.117882, longitude: 30.203168),
  //     ParkPoint(name: 'Карьер у деревни Питкелево', latitude: 59.166183, longitude: 30.360511),
  //     ParkPoint(name: 'Невский лесопарк', latitude: 59.83333, longitude: 30.58333),
  //     ParkPoint(name: 'Ребровские пещеры', latitude: 58.725111, longitude: 29.765385),
  //     // Санкт-Петербург
  //     ParkPoint(name: 'Невский проспект', latitude: 59.932473, longitude: 30.349169),
  //     ParkPoint(name: 'Дворцовая площадь', latitude: 59.938982, longitude: 30.315500),
  //     ParkPoint(name: 'Стрелка Васильевского острова', latitude: 59.944167, longitude: 30.306667),
  //     ParkPoint(name: 'Петропавловская крепость', latitude: 59.9500019, longitude: 30.3166718),
  //     ParkPoint(name: 'Казанский собор', latitude: 59.9342278, longitude: 30.3245944),
  //     ParkPoint(name: 'Александринский, latitude: театр', latitude: 59.93208400, longitude: 30.33637700),
  //     ParkPoint(name: 'Мариинский театр', latitude: 59.925919, longitude: 30.2975893),
  //     ParkPoint(name: 'Петергоф', latitude: 59.863400, longitude: 29.990947),
  //     ParkPoint(name: 'Павловск', latitude: 59.6811976, longitude: 30.44437629999999),
  //     ParkPoint(name: 'Царское Село', latitude: 59.717372321389085, longitude: 30.394497798612953),
  //     ParkPoint(name: '«Лахта Центр»', latitude: 59.9867525, longitude: 30.1787992),
  //     ParkPoint(name: 'Летний сад', latitude: 59.9439113, longitude: 30.3369781),
  //     ParkPoint(name: 'Чижик-Пыжик', latitude: 59.941716, longitude: 30.338026),
  //     ParkPoint(name: 'Форт «Константин»', latitude: 59.995353, longitude: 29.701168),
  //     ParkPoint(name: 'Ленинградский зоопарк', latitude: 59.9518703, longitude: 30.3072287),
  //     ParkPoint(name: 'Дворы и парадные', latitude: 59.925146, longitude: 30.325480),
  //     ParkPoint(name: 'Крестовский остров', latitude: 59.97211886667353, longitude: 30.244999913933405),
  //     ParkPoint(name: 'Александровская колонна', latitude: 59.93917, longitude: 30.31583),
  //     ParkPoint(name: 'Марсово поле', latitude: 59.94362, longitude: 30.331793),
  //     ParkPoint(name: 'Монетный двор', latitude: 59.9495552, longitude: 30.3146485),
  //     ParkPoint(name: 'Океанариум', latitude: 59.9189519, longitude: 30.339051),
  //     ParkPoint(name: 'Стадион «Газпром Арена»', latitude: 59.97278, longitude: 30.22056),
  //     ParkPoint(name: 'Сфинксы на Университетской набережной', latitude: 59.936969, longitude: 30.29086),
  //     ParkPoint(name: 'Михайловский сад', latitude: 59.939846, longitude: 30.332823),
  //     ParkPoint(name: 'Ботанический сад', latitude: 59.97028, longitude: 30.32361),
  //     ParkPoint(name: 'Ораниенбаум', latitude: 59.9149028, longitude: 29.7539556),
  //     ParkPoint(name: 'Каменноостровский проспект', latitude: 59.9622, longitude: 30.315),
  //     ParkPoint(name: 'Аничков мост', latitude: 59.9332357, longitude: 30.34341),
  //     ParkPoint(name: 'Английская набережная', latitude: 59.9332914, longitude: 30.2912202),
  //     ParkPoint(name: 'Памятник Николаю I на Исаакиевской площади', latitude: 59.932114, longitude: 30.308425),
  //     // Новгородская область
  //     ParkPoint(name: 'Валдайский национальный парк', latitude: 57.9855, longitude: 33.2535),
  //     ParkPoint(name: 'Рдейский заповедник', latitude: 57.159010, longitude: 31.180272),
  //     ParkPoint(name: 'Рюриково городище', latitude: 58.4942856, longitude: 31.2981459),
  //     ParkPoint(name: 'Ярославово дворище', latitude: 58.518886, longitude: 31.284647),
  //     ParkPoint(name: 'Парк-усадьба Горки', latitude: 54.283234, longitude: 30.995111),
  //     ParkPoint(name: 'Маловишерский лес', latitude: 58.839277, longitude: 32.186398),
  //     // Псковская область
  //     ParkPoint(name: 'Себежский национальный парк', latitude: 56.164027, longitude: 28.347572),
  //     ParkPoint(name: 'Полистовский заповедник', latitude: 57.17083, longitude: 30.55694),
  //     // Калининградская область
  //     ParkPoint(name: 'Сосновый бор в городе Пионерский', latitude: 54.956787, longitude: 20.252761),
  //     ParkPoint(name: 'Парк Фихтенвальде', latitude: 54.586667, longitude: 22.167500),
  //     ParkPoint(name: 'Роминтенская пуща (Красный лес)', latitude: 54.394582, longitude: 22.527403),
  //     ParkPoint(name: 'Виштынецкий лес', latitude: 54.435387, longitude: 22.521588),
  //     ParkPoint(name: 'Парк Три старых липы', latitude: 54.938028, longitude: 20.159168),
  //     ParkPoint(name: 'Танцующий лес', latitude: 55.180734, longitude: 20.861803),
  //     ParkPoint(name: 'Высота Мюллера', latitude: 55.148374, longitude: 20.812023),
  //     ParkPoint(name: 'Высота Эфа', latitude: 55.221127, longitude: 20.906135),
  //     // ЦФО
  //     // Москва
  //     ParkPoint(name: 'Парк Зарядье', latitude: 55.751238, longitude: 37.627762),
  //     ParkPoint(name: 'Парк Горького', latitude: 55.731474, longitude: 37.603431),
  //     ParkPoint(name: 'Парк Сокольники', latitude: 55.792648, longitude: 37.677681),
  //     ParkPoint(name: 'Парк Победы на Поклонной горе', latitude: 55.731233, longitude: 37.506585),
  //     ParkPoint(name: 'Московский зоопарк', latitude: 55.761092, longitude: 37.578308),
  //     ParkPoint(name: 'ВДНХ', latitude: 55.826310, longitude: 37.637855),
  //     ParkPoint(name: 'музей-заповедник Царицыно', latitude: 55.615670, longitude: 37.688789),
  //     ParkPoint(name: 'Музей-заповедник Коломенское', latitude: 55.667650, longitude: 37.670862),
  //     ParkPoint(name: 'Музеон', latitude: 55.733055, longitude: 37.604646),
  //     ParkPoint(name: 'Измайловский парк культуры и отдыха', latitude: 55.772451, longitude: 37.753986),
  //     ParkPoint(name: 'Лианозовский парк культуры и отдыха', latitude: 55.900325, longitude: 37.567154),
  //     ParkPoint(name: 'Музейно-парковый комплекс Северное Тушино', latitude: 55.850676, longitude: 37.455103),
  //     ParkPoint(name: 'Бабушкинский парк', latitude: 55.865978, longitude: 37.680594),
  //     ParkPoint(name: 'Таганский парк', latitude: 55.737711, longitude: 37.667363),
  //     ParkPoint(name: 'Сад имени Н. Э. Баумана', latitude: 55.765690, longitude: 37.660774),
  //     ParkPoint(name: 'Нескучный сад', latitude: 55.718356, longitude: 37.591445),
  //     ParkPoint(name: 'Парк Фили', latitude: 55.745565, longitude: 37.488091),
  //     ParkPoint(name: 'Ландшафтный заказник Тёплый Стан', latitude: 55.634939, longitude: 37.489573),
  //     ParkPoint(name: 'Битцевский лес', latitude: 55.597407, longitude: 37.557439),
  //     ParkPoint(name: 'Сказка', latitude: 55.772178, longitude: 37.435196),
  //     // Подмосковье
  //     ParkPoint(name: 'Коломенский кремль', latitude:  55.103325, longitude: 38.752522),
  //     ParkPoint(name: 'Свято-Троицкая Сергиева лавра', latitude: 56.311120, longitude: 38.130492),
  //     ParkPoint(name: 'Государственный историко-художественный и литературный музей-заповедник Абрамцево', latitude: 56.234583, longitude: 37.965156),
  //     ParkPoint(name: 'Этнопарк Кочевник', latitude: 56.241326, longitude: 38.051608),
  //     ParkPoint(name: 'Усадьба Введенское', latitude: 55.707168, longitude: 36.872188),
  //     ParkPoint(name: 'Парк Патриот', latitude: 55.563465, longitude: 36.816774),
  //     ParkPoint(name: 'Парк культуры и отдыха имени Л.Н. Толстого', latitude: 55.894013, longitude: 37.458965),
  //     ParkPoint(name: 'Киногород Пилигрим Порто', latitude: 55.925659, longitude: 37.232484),
  //     ParkPoint(name: 'Парк Эко-Берег', latitude: 55.899850, longitude: 37.470783),
  //     ParkPoint(name: 'Экзотик парк', latitude: 55.414518, longitude: 37.270044),
  //     ParkPoint(name: 'Парк Мира', latitude: 55.910528, longitude: 37.742207),
  //     ParkPoint(name: 'Перловский парк', latitude: 55.895942, longitude: 37.733629),
  //     ParkPoint(name: 'Парк Яуза', latitude: 55.898463, longitude: 37.716329),
  //     ParkPoint(name: 'Zooландия', latitude: 55.879849, longitude: 36.795201),
  //     ParkPoint(name: 'парк Зелёная Зона', latitude: 54.831983, longitude: 37.617088),
  //     ParkPoint(name: 'Пехорка', latitude: 55.801501, longitude: 37.942108),
  //     ParkPoint(name: 'Усадьба Пехра-Яковлевское', latitude: 55.792378, longitude: 37.953172),
  //     ParkPoint(name: 'парк Заречная', latitude: 55.821931, longitude: 37.964305),
  //     ParkPoint(name: 'Городской парк Ёлочки', latitude: 55.420065, longitude: 37.777010),
  //     ParkPoint(name: 'Музей сказок', latitude: 55.411014, longitude: 37.782155),
  //     ParkPoint(name: 'Музей-усадьба Архангельское', latitude: 55.784558, longitude: 37.284041),
  //     ParkPoint(name: 'Сестрорецкий парк', latitude: 56.324999, longitude: 36.736576),
  //     ParkPoint(name: 'Вальс цветов', latitude: 56.323394, longitude:  36.744152),
  //     ParkPoint(name: 'Музейно-выставочный комплекс Волоколамский кремль', latitude: 56.037940, longitude: 35.957310),
  //     ParkPoint(name: 'Серпуховский кремль', latitude: 54.915325, longitude: 37.405279),
  //     ParkPoint(name: 'Музей-заповедник Дмитровский кремль', latitude: 56.345018, longitude: 37.520050),
  //     ParkPoint(name: 'Березовая роща', latitude: 56.333695, longitude: 37.516873),
  //     ParkPoint(name: 'Парк 30-летия Победы', latitude: 55.802110, longitude: 38.969766),
  //     ParkPoint(name: 'Государственный музей заповедник Зарайский кремль', latitude: 54.757432, longitude: 38.870865),
  //     ParkPoint(name: 'Центральный парк культуры и отдыха', latitude: 54.756968, longitude: 38.886056),
  //     ParkPoint(name: 'Можайский кремль', latitude: 55.509753, longitude: 36.010863),
  //     ParkPoint(name: 'Парк птиц Воробьи', latitude: 55.158957, longitude: 36.778894),
  //     ParkPoint(name: 'Парк приключений Дикие белки', latitude: 55.156920, longitude: 37.632110),
  //     ParkPoint(name: 'Парк усадьбы Кривякино', latitude: 55.319883, longitude: 38.672473),
  //     // Рязанская область
  //     ParkPoint(name: 'Рязанский кремль', latitude: 54.635804, longitude: 39.748336),
  //     ParkPoint(name: 'Центральный парк культуры и отдыха Рюмина Роща', latitude: 54.611198, longitude: 39.731983),
  //     ParkPoint(name: 'Бульвар Победы', latitude: 54.644015, longitude: 39.658590),
  //     ParkPoint(name: 'Окская жемчужина', latitude: 54.695515, longitude: 39.798664),
  //     ParkPoint(name: 'Государственный музей-заповедник С. А. Есенина', latitude: 54.863263, longitude: 39.602017),
  //     // Тамбовская область
  //     ParkPoint(name: 'парк 50-летия Победы', latitude: 52.750076, longitude: 41.414629),
  //     ParkPoint(name: 'Лесопарк «Дружба»', latitude: 52.707534, longitude: 41.493820),
  //     ParkPoint(name: 'ландшафтный парк-набережная Мичуринское подгорье', latitude: 52.893581, longitude: 40.521064),
  //     // Воронежская область
  //     ParkPoint(name: 'Интерактивный музей Дом Бобра', latitude: 51.876766, longitude: 39.657800),
  //     ParkPoint(name: 'Парк Орлёнок', latitude: 51.675241, longitude: 39.208387),
  //     ParkPoint(name: 'Алые Паруса', latitude: 51.657489, longitude: 39.236773),
  //     ParkPoint(name: 'Парк Победа', latitude: 51.706358, longitude: 39.161421),
  //     ParkPoint(name: 'Дельфин', latitude: 51.685853, longitude: 39.253000),
  //     ParkPoint(name: 'Музей-заповедник Дивногорье', latitude: 50.963659, longitude: 39.294938),
  //     // Белгородская область
  //     ParkPoint(name: 'Парк культуры и отдыха им. В.И. Ленина', latitude: 50.606887, longitude: 36.586744),
  //     ParkPoint(name: 'парк Котофей', latitude: 50.589664, longitude: 36.584702),
  //     ParkPoint(name: 'Комсомольский парк', latitude: 51.280213, longitude: 37.800783),
  //     ParkPoint(name: 'Старооскольский зоопарк', latitude: 51.322957, longitude: 37.999321),
  //     // Курская область
  //     ParkPoint(name: 'Парк Боева дача', latitude: 51.742198, longitude: 36.211259),
  //     ParkPoint(name: 'Новая Боевка', latitude: 51.743542, longitude: 36.214585),
  //     ParkPoint(name: 'парк КЗТЗ', latitude: 51.705550, longitude: 36.156164),
  //     ParkPoint(name: 'Железногорский дендрологический парк', latitude: 52.338536, longitude: 35.339032),
  //     // Орловская область
  //     ParkPoint(name: 'ландшафтный парк Дворянское Гнездо', latitude: 52.967326, longitude: 36.052006),
  //     ParkPoint(name: 'музей-заповедник И.С. Тургенева Спасское-Лутовиново', latitude: 53.372268, longitude: 36.631877),
  //     // Липецкая область
  //     ParkPoint(name: 'Парк Металлургов', latitude: 52.583551, longitude: 39.625548),
  //     ParkPoint(name: 'Городские парки г. Ельца', latitude: 52.626508, longitude: 38.495667),
  //     ParkPoint(name: 'парк 40-летия Великой Октябрьской Социалистической Революции', latitude: 52.616178, longitude: 38.466862),
  //     ParkPoint(name: 'Петровский парк', latitude: 52.606753, longitude: 38.506837),
  //     ParkPoint(name: 'Старая гидромельница купца Талдыкина', latitude: 52.572653, longitude: 38.361530),
  //     ParkPoint(name: 'Заповедник Галичья Гора', latitude: 52.601510, longitude: 38.928741),
  //     ParkPoint(name: 'Кудыкина гора', latitude: 52.367879, longitude: 38.769908),
  //     // Тулькая область
  //     ParkPoint(name: 'Тульский кремль', latitude: 54.195825, longitude: 37.619855),
  //     ParkPoint(name: 'Музей Козлова Засека', latitude: 54.096342, longitude: 37.569444),
  //     ParkPoint(name: 'Центральный парк культуры и отдыха имени П. П. Белоусова', latitude: 54.181642, longitude: 37.588449),
  //     ParkPoint(name: 'Рогожинский парк', latitude: 54.172101, longitude: 37.616127),
  //     ParkPoint(name: 'Комсомольский парк', latitude: 54.230559, longitude: 37.622821),
  //     ParkPoint(name: 'Платоновский парк', latitude: 54.150517, longitude: 37.574402),
  //     ParkPoint(name: 'Парк Патриот - Тула', latitude: 54.188276, longitude: 37.657889),
  //     ParkPoint(name: 'Баташевский сад', latitude: 54.221874, longitude: 37.645693),
  //     ParkPoint(name: 'Кремлёвский сад', latitude: 54.193961, longitude: 37.622706),
  //     ParkPoint(name: 'Музей-усадьба Ясная Поляна', latitude: 54.075501, longitude: 37.526409),
  //     ParkPoint(name: 'музей усадьба В. Д. Поленова', latitude: 54.748552, longitude: 37.236656),
  //     ParkPoint(name: 'Богородицкий дворец-музей и парк', latitude: 53.771625, longitude: 38.139179),
  //     // Калужская область
  //     ParkPoint(name: 'Центральный городской парк культуры и отдыха', latitude: 54.506944, longitude: 36.248147),
  //     ParkPoint(name: 'Парк имени Циолковского', latitude: 54.515207, longitude: 36.233873),
  //     ParkPoint(name: 'парк Три богатыря', latitude: 54.033479, longitude: 35.794259),
  //     ParkPoint(name: 'Вихляндия', latitude: 54.039196, longitude: 35.795892),
  //     ParkPoint(name: 'Арт-парк Никола-Ленивец', latitude: 54.757546, longitude: 35.604235),
  //     // Брянская область
  //     ParkPoint(name: 'Тридевятое Царство', latitude: 53.300842, longitude: 34.236799),
  //     // Смоленская область
  //     ParkPoint(name: 'Музей-заповедник Гнёздово', latitude: 54.785732, longitude: 31.879890),
  //     ParkPoint(name: 'Лопатинский сад', latitude: 54.781649, longitude: 32.041711),
  //     ParkPoint(name: 'Мемориальный комплекс Катынь', latitude: 54.774122, longitude: 31.789684),
  //     ParkPoint(name: 'Историко-архитектурный комплекс Теремок', latitude: 54.659180, longitude: 32.209065),
  //     // Тверская область
  //     ParkPoint(name: 'Городской сад', latitude: 56.867060, longitude: 35.892022),
  //     ParkPoint(name: 'Дворцовый сад', latitude: 56.863401, longitude: 35.901760),
  //     ParkPoint(name: 'Китайский парк', latitude: 56.844248, longitude: 35.819148),
  //     ParkPoint(name: 'Новоторжский Кремль', latitude: 57.036734, longitude: 34.955408),
  //     ParkPoint(name: 'Архитектурно-этнографический музей Василёво', latitude: 57.097736, longitude: 34.971522),
  //     // Ярославская область
  //     ParkPoint(name: 'Ярославский музей-заповедник', latitude: 57.630078, longitude: 39.895167),
  //     ParkPoint(name: 'Нефтяник', latitude: 57.583245, longitude: 39.848711),
  //     ParkPoint(name: 'Даманский парк', latitude: 57.618402, longitude: 39.899573),
  //     ParkPoint(name: 'Парк 1000-летия Ярославля', latitude: 57.617275, longitude: 39.871435),
  //     ParkPoint(name: 'Парк Стрелка', latitude: 57.618611, longitude: 39.904638),
  //     ParkPoint(name: 'Набережная р. Волги', latitude: 57.622598, longitude: 39.903585),
  //     ParkPoint(name: 'Угличский кремль', latitude: 57.528446, longitude: 38.317633),
  //     ParkPoint(name: 'Ростовский кремль', latitude: 57.184438, longitude: 39.415193),
  //     ParkPoint(name: 'Городской сад', latitude: 57.185701, longitude: 39.425190),
  //     ParkPoint(name: 'Митрополичий сад', latitude: 57.183695, longitude: 39.416635),
  //     ParkPoint(name: 'Музей Рождение Сказки', latitude: 56.561126, longitude: 38.580521),
  //     ParkPoint(name: 'Переславский музей-заповедник', latitude: 56.721597, longitude: 38.824697),
  //     ParkPoint(name: 'Русский парк', latitude: 56.711133, longitude: 38.802436),
  //     ParkPoint(name: 'Музей Александра Невского', latitude: 56.720250, longitude: 38.825506),
  //     ParkPoint(name: 'Переславский дендрологический сад имени С. Ф. Харитонова', latitude: 56.718205, longitude: 38.829315),
  //     // Костромская область
  //     ParkPoint(name: 'Костромская слобода', latitude: 57.775402, longitude: 40.889537),
  //     ParkPoint(name: 'парк Берендеевка', latitude: 57.792929, longitude: 40.959878),
  //     ParkPoint(name: 'парк Победы', latitude: 57.732793, longitude: 40.992504),
  //     ParkPoint(name: 'Парк культуры и отдыха им. В.И. Ленина', latitude: 57.764125, longitude: 40.928335),
  //     // Ивановская область
  //     ParkPoint(name: 'Серебряный парк', latitude: 57.005073, longitude: 40.988532),
  //     ParkPoint(name: 'Парк культуры и отдыха имени Революции 1905 года', latitude: 57.029602, longitude: 41.003927),
  //     ParkPoint(name: 'Плёсский государственный историко-архитектурный и художественный музей-заповедник', latitude: 57.458744, longitude: 41.514018),
  //     ParkPoint(name: 'Парк Плёс', latitude: 57.454599, longitude: 41.502015),
  //     // Владимирская область
  //     ParkPoint(name: 'Национальный парк Мещёра', latitude: 55.634348, longitude: 40.689810),
  //     ParkPoint(name: 'парк имени 50-летия Советской власти', latitude: 55.578096, longitude: 42.022630),
  //     ParkPoint(name: 'Парк имени В.А. Дегтярёва', latitude: 56.358697, longitude: 41.325848),
  //     ParkPoint(name: 'Ковровский историко-мемориальный парк Иоанно-Воинский некрополь', latitude: 56.375464, longitude: 41.303430),
  //     ParkPoint(name: 'Музейный комплекс Спасо-Евфимиев монастырь', latitude: 56.433238, longitude: 40.440025),
  //     ParkPoint(name: 'Суздальский Кремль', latitude: 56.415948, longitude: 40.442851),
  //     ParkPoint(name: 'Александровская Слобода', latitude: 56.400607, longitude: 38.740469),
  //     ParkPoint(name: 'Юрьевский Кремль', latitude: 56.497888, longitude: 39.681595),
  //     // СКФО
  //     // Ставропольский край
  //     ParkPoint(name: 'Археологический природный музей-заповедник Татарское Городище', latitude: 44.979635, longitude: 41.942739),
  //     ParkPoint(name: 'Парк Культуры и Отдыха Центральный', latitude: 45.043756, longitude: 41.976442),
  //     ParkPoint(name: 'Парк Победы', latitude: 45.022886, longitude: 41.924389),
  //     ParkPoint(name: 'парк Патриот', latitude: 45.024806, longitude: 41.896981),
  //     ParkPoint(name: 'Емануелевский парк', latitude: 44.041186, longitude: 43.083070),
  //     ParkPoint(name: 'Провал', latitude: 44.046672, longitude: 43.098839),
  //     ParkPoint(name: 'Курортный парк', latitude: 43.894141, longitude: 42.725039),
  //     ParkPoint(name: 'Нижний парк', latitude: 43.896675, longitude: 42.719176),
  //     ParkPoint(name: 'Берёзовское ущелье', latitude: 43.884808, longitude: 42.698399),
  //     ParkPoint(name: 'Долина роз', latitude: 43.895481, longitude: 42.738632),
  //     ParkPoint(name: 'Национальный парк Кисловодский', latitude: 43.897461, longitude: 42.735017),
  //     ParkPoint(name: 'Парк Цветник', latitude: 44.036808, longitude: 43.081792),
  //     ParkPoint(name: 'Ессентукский курортный парк', latitude: 44.046423, longitude: 42.864104),
  //     ParkPoint(name: 'Курортный парк Железноводска', latitude: 44.140371, longitude: 43.032841),
  //     ParkPoint(name: 'Пещера летней мерзлоты', latitude: 44.156823, longitude: 43.030464),
  //     // Карачаево-Черкесская Республика
  //     ParkPoint(name: 'Зелёный Остров', latitude: 44.227926, longitude: 42.038894),
  //     ParkPoint(name: 'парк РТИ', latitude: 44.248651, longitude: 42.043345),
  //     ParkPoint(name: 'Тебердинский национальный парк', latitude: 43.354679, longitude: 41.688047),
  //     // Кабардино-Балкарская республика
  //     ParkPoint(name: 'Городской парк', latitude: 43.461545, longitude: 43.589887),
  //     ParkPoint(name: 'Атажукинский сад', latitude: 43.475853, longitude: 43.603052),
  //     ParkPoint(name: 'Водопад Терскол', latitude: 43.288654, longitude: 42.500164),
  //     ParkPoint(name: 'Национальный парк Приэльбрусье', latitude: 43.242585, longitude: 42.561713),
  //     ParkPoint(name: 'Чегемские водопады', latitude: 43.415851, longitude: 43.215971),
  //     ParkPoint(name: 'Голубое озеро Чирик–Кёль', latitude: 43.233573, longitude: 43.538337),
  //     ParkPoint(name: 'Водопад Азау', latitude: 43.266020, longitude: 42.472609),
  //     ParkPoint(name: 'Терренкур «1000 ступеней»', latitude: 43.453772, longitude: 43.593267),
  //     // Республика Северная Осетия — Алания
  //     ParkPoint(name: 'ЦПКиО им. К.Л. Хетагурова', latitude: 43.025717, longitude: 44.678760),
  //     ParkPoint(name: 'парк Нартон', latitude: 42.983045, longitude: 44.671206),
  //     ParkPoint(name: 'Высокогорный курорт "Цей"', latitude: 42.785798, longitude: 43.905108),
  //     ParkPoint(name: 'Мидаграбинские водопады', latitude: 42.753544, longitude: 44.363297),
  //     ParkPoint(name: 'Некрополь «Город мертвых»', latitude: 42.841273, longitude: 44.445322),
  //     ParkPoint(name: 'Кармадонское ущелье', latitude: 42.842944, longitude: 44.517878),
  //     // Республика Ингушетия
  //     ParkPoint(name: 'Мемориал памяти и славы Республики Ингушетия', latitude: 43.196502, longitude: 44.771608),
  //     ParkPoint(name: 'Ляжгинский водопад', latitude: 42.798681, longitude: 44.719752),
  //     ParkPoint(name: 'Эрзи', latitude: 42.803477, longitude: 44.759501),
  //     ParkPoint(name: 'Башенный комплекс Эгикал', latitude: 42.833637, longitude: 44.918690),
  //     ParkPoint(name: 'Башенный комплекс Вовнушки', latitude: 42.800853, longitude: 44.994718),
  //     // Чечня
  //     ParkPoint(name: 'Цветочный парк', latitude: 43.313911, longitude: 45.698648),
  //     ParkPoint(name: 'Озеро Казеной-Ам', latitude: 42.772359, longitude: 46.152050),
  //     // Дагестан
  //     ParkPoint(name: 'Парк им. Ленинского Комсомола', latitude: 42.985216, longitude: 47.492396),
  //     ParkPoint(name: 'Парк 50-летия Октября', latitude: 42.958956, longitude: 47.503000),
  //     ParkPoint(name: 'Городской парк культуры и отдыха имени Магомеда Рабадановича Халилова', latitude: 42.891983, longitude: 47.641715),
  //     ParkPoint(name: 'Дербентский государственный историко-архитектурный и археологический музей-заповедник', latitude: 42.057303, longitude: 48.287009),
  //     ParkPoint(name: 'парк Боевой Славы имени Шамсуллы Алиева', latitude: 42.057771, longitude: 48.291362),
  //     ParkPoint(name: 'парк Революционной Славы', latitude: 42.055975, longitude: 48.297227),
  //     ParkPoint(name: 'Бархан Сарыкум', latitude: 43.008512, longitude: 47.234587),
  //     ParkPoint(name: 'Салтинский водопад', latitude: 42.390001, longitude: 47.066585),
  //     // ПФО
  //     // Казань
  //     ParkPoint(
  //         name: 'Парк Тысячелетия Казани', latitude: 55.783094, longitude: 49.126446),
  //     ParkPoint(
  //         name: 'Парк Победы', latitude: 55.829309210570905, longitude: 49.108129074096674),
  //     ParkPoint(
  //         name: 'Центральный парк культуры и отдыха имени Горького', latitude: 55.793414, longitude: 49.167023),
  //     // Самара
  //     ParkPoint(
  //         name: 'Парк Юрия Гагарина (детский парк культуры и отдыха)', latitude:53.229557133967695, longitude: 50.20058978592961),
  //     ParkPoint(
  //         name: 'Парк Победы', latitude: 53.192646, longitude: 50.200787),
  //     ParkPoint(
  //         name: 'Парк Дружбы', latitude: 53.203769524388285, longitude: 50.21815191284176),
  //     // Нижний Новгород
  //     ParkPoint(
  //         name: 'Парк "Швейцария" ', latitude: 56.28031539677496, longitude: 43.97497322064267),
  //     ParkPoint(
  //         name: 'Парк им. А. С. Пушкина', latitude: 56.30836253698265, longitude: 43.99708115249622),
  //     ParkPoint(
  //         name: 'Автозаводский парк', latitude: 56.235851, longitude: 43.855986),
  //     ParkPoint(
  //         name: 'Парк Победы', latitude: 56.32776344392905, longitude: 44.03511141454527),
  //     // Уфа
  //     ParkPoint(
  //         name: 'Сквер имени Мидхата Закировича Шакирова', latitude: 54.725034290461515, longitude: 55.95708130125798),
  //     ParkPoint(
  //         name: 'Театральный сквер', latitude: 54.72573335200597, longitude: 55.946387571505134),
  //     ParkPoint(
  //         name: 'Сквер Ленина', latitude: 54.72573945293541, longitude: 55.94639159614707),
  //     ParkPoint(
  //         name: 'Аллея современной городской скульптуры ArtTerria', latitude: 54.72058152767348, longitude: 55.9448115553253),
  //     ParkPoint(
  //         name: 'Парк имени Ленина', latitude: 54.718078, longitude: 55.943231),
  //     ParkPoint(
  //         name: 'Сквер им. Зии Нуриева', latitude: 54.715976328703334, longitude: 55.94415207011409),
  //     ParkPoint(
  //         name: 'Сад Салавата Юлаева', latitude: 54.71222766045911, longitude: 55.952360950401285),
  //     // Пермь
  //     ParkPoint(
  //         name: 'Особо охраняемая природная территория местного значения – охраняемый природный ландшафт Черняевский лес', latitude: 57.983754, longitude: 56.153778),
  //     ParkPoint(
  //         name: 'Сад имени В. Л. Миндовского', latitude: 57.982495980767176, longitude: 56.20489978339288),
  //     ParkPoint(
  //         name: 'Слудская горка', latitude: 58.009997, longitude: 56.218798),
  //     ParkPoint(
  //         name: 'Сад имени Гоголя', latitude: 58.014965, longitude: 56.220936),
  //     ParkPoint(
  //         name: 'Театральный сад', latitude: 58.015018, longitude: 56.246763),
  //     ParkPoint(
  //         name: 'Сад Декабристов', latitude: 58.013435, longitude: 56.260543),
  //     // Самара
  //     ParkPoint(
  //         name: 'Детский парк', latitude: 51.53173866070316, longitude: 46.00755361143541),
  //     ParkPoint(
  //         name: 'сквер им. О. И. Янковского', latitude: 51.532377893910734, longitude: 46.03449699755856),
  //     ParkPoint(
  //         name: 'Городской парк культуры и отдыха', latitude: 51.52003, longitude: 45.997399),
  //     ParkPoint(
  //         name: 'Сквер Имени 1905 Года', latitude: 51.533562, longitude: 46.034266),
  //     // Тольятти
  //     ParkPoint(
  //         name: 'Центральный парк культуры и отдыха', latitude: 53.50983118817226, longitude: 49.41875647148436),
  //     ParkPoint(
  //         name: 'ФАННИ Парк', latitude: 53.517501, longitude: 49.266467),
  //     ParkPoint(
  //         name: 'Дендропарк', latitude: 53.540618, longitude: 49.370941),
  //     ParkPoint(
  //         name: 'Сквер "32 квартал"', latitude: 53.574606569327216, longitude: 49.07816719279854),
  //     // Ижевск
  //     ParkPoint(
  //         name: 'парк имени Горького', latitude: 56.846981, longitude: 53.198528),
  //     ParkPoint(
  //         name: 'Козий парк', latitude: 56.858587, longitude: 53.233391),
  //     ParkPoint(
  //         name: 'Сквер им. Татьяны Барамзиной', latitude: 56.86258773286028, longitude: 53.27932299964397),
  //     // Ульяновск
  //     ParkPoint(
  //         name: 'Сквер Ивана Яковлева', latitude: 54.309744785613546, longitude:48.37957619957372),
  //     ParkPoint(
  //         name: 'Сквер Строителей', latitude: 54.30548518073345, longitude: 48.38218070240778),
  //     ParkPoint(
  //         name: 'Парк Газовиков и Нефтяков', latitude: 54.339829451150635, longitude: 48.37591619999099),
  //     //Набережные Челны
  //     ParkPoint(
  //         name: 'Парк Культуры И Отдыха', latitude: 55.682869, longitude: 52.28477),
  //     ParkPoint(
  //         name: 'Парк Гренада', latitude: 55.73320327385288, longitude: 52.41746245401297),
  //     ParkPoint(
  //         name: 'Парк Прибрежный ', latitude: 55.75782, longitude: 52.384537),
  //     // Оренбург
  //     ParkPoint(
  //         name: 'Парк "Тополя"', latitude: 51.769702089470414, longitude: 55.092514966903636),
  //     ParkPoint(
  //         name: 'Железнодорожный парк имени В.И. Ленина', latitude: 51.77175782876066, longitude: 55.08496659790034),
  //     ParkPoint(
  //         name: 'Сквер у Дома Советов', latitude: 51.767473594252415, longitude: 55.09761894893012),
  //     // Пенза
  //     ParkPoint(
  //         name: 'Парк Союз', latitude: 53.18406092970557, longitude: 44.97629661932136),
  //     ParkPoint(
  //         name: 'Аллея 70-летия Великой Победы', latitude: 53.165587, longitude: 44.999694),
  //     ParkPoint(
  //         name: 'Пионерский сквер', latitude: 53.211897,longitude: 44.990495 ),
  //     ParkPoint(
  //         name: 'Сквер имени М. Ю. Лермонтова', latitude: 53.18289315407612, longitude: 45.0124893134918),
  //     // Чебоксары
  //     ParkPoint(
  //         name: 'Парк Роща Гузовского', latitude: 56.136983, longitude: 47.176976),
  //     ParkPoint(
  //         name: 'Центральный парк культуры и отдыха Лакреевский лес', latitude: 56.117321, longitude: 47.24117),
  //     ParkPoint(
  //         name: 'Мемориальный Парк Победы', latitude: 56.14742850642577, longitude: 47.26801031877135),
  //     ParkPoint(
  //         name: 'сквер имени Н.И. Пирогова', latitude: 56.141578, longitude: 47.21829),
  //     // ЮФО
  //     // Ростовская область
  //     ParkPoint(
  //         name: 'Гинкго Парк', latitude: 47.401337, longitude: 40.071135),
  //     ParkPoint(
  //         name: 'Парк «Малинки»', latitude: 47.745672, longitude: 40.088963),
  //     ParkPoint(
  //         name: 'Этно-археологический комплекс «Затерянный Мир»', latitude: 47.518159, longitude: 40.610807),
  //     ParkPoint(
  //         name: 'Парк Лога в хуторе Старая Станица', latitude: 48.351304, longitude: 40.295224),
  //     ParkPoint(
  //         name: 'Самбекские высоты', latitude: 47.317856, longitude: 39.012731),
  //     ParkPoint(
  //         name: 'Набережная Ростова-на-Дону', latitude: 47.217242, longitude: 39.726807),
  //     ParkPoint(
  //         name: 'Ботанический сад ЮФУ', latitude: 47.231051, longitude: 39.659632),
  //     ParkPoint(
  //         name: 'Мемориальный комплекс «Кумженская роща»', latitude: 47.185104, longitude: 39.618411),
  //     ParkPoint(
  //         name: 'Заповедник «Золотые горки»', latitude: 47.441969, longitude: 40.390649),
  //     ParkPoint(
  //         name: 'Природный парк Цимлянские пески', latitude: 48.169465, longitude: 42.676384),
  //
  //   ];
  // }
/*/// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
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
    // СаНкт-Петербург
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
    // ЦФО
    // Москва
    OutsidePoint(name: 'Останкинская башня', latitude: 55.819721, longitude: 37.611704),
    OutsidePoint(name: 'Смотровая площадка PANORAMA360 в ММДЦ «Москва-Сити»', latitude: 55.749900, longitude: 37.537237),
    OutsidePoint(name: 'Воробьёвы горы', latitude: 55.709382, longitude: 37.542250),
    OutsidePoint(name: 'Смотровая площадка «Выше Только Любовь»', latitude: 55.749310, longitude: 37.534445),
    OutsidePoint(name: 'Центральная Смотровая ЦДМ', latitude: 55.760094, longitude: 37.624905),
    OutsidePoint(name: 'Московская монорельсовая транспортная система', latitude: 55.821831, longitude: 37.611940),
    OutsidePoint(name: 'Солнце Москвы', latitude: 55.826726, longitude: 37.626548),
    OutsidePoint(name: 'Колесо обозрения в парке развлечений «Сказка»', latitude: 55.772172, longitude: 37.434791),
    OutsidePoint(name: 'Колесо обозрения в парке «Сокольники»', latitude: 55.793959, longitude: 37.673886),
    OutsidePoint(name: 'Колесо обозрения у Измайловского Кремля', latitude: 55.770178, longitude: 37.750795),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.744499, longitude: 37.605863),
    OutsidePoint(name: 'Парящий мост', latitude: 55.749475, longitude: 37.629421),
    OutsidePoint(name: 'Смотровая площадка гостиницы Украина', latitude: 55.751226, longitude: 37.565686),
    OutsidePoint(name: 'Смотровая площадка РАН', latitude: 55.712352, longitude: 37.578231),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.667756, longitude: 37.671868),
    // Подмосковье
    OutsidePoint(name: 'Колесо Обозрения в Коломне', latitude: 55.085006, longitude: 38.779664),
    OutsidePoint(name: 'Блинная Гора', latitude: 56.307346, longitude: 38.134955),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.729114, longitude: 36.814617),
    OutsidePoint(name: 'Смотровая площадка на Мясиной горе с видом на Монастырь', latitude: 55.722621, longitude: 36.823454),
    OutsidePoint(name: 'Смотровая площадка «Взлетка»', latitude: 55.978974, longitude: 37.454069),
    OutsidePoint(name: 'Колесо обозрения', latitude: 55.894169, longitude: 37.459792),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.837026, longitude: 38.142562),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.894859, longitude: 37.773021),
    OutsidePoint(name: 'Колесо обозрения', latitude: 55.825835, longitude: 37.329516),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.037966, longitude: 35.957746),
    OutsidePoint(name: 'Смотровая Площадка Серпуховского Кремля', latitude: 54.916198, longitude: 37.403439),
    OutsidePoint(name: 'Колесо обозрения', latitude: 54.928715, longitude: 37.443329),
    OutsidePoint(name: 'Смотровая площадка на Оке', latitude: 54.883552, longitude: 37.426449),
    OutsidePoint(name: 'Смотровая площадка у Высоцкого монастыря', latitude: 54.901623, longitude: 37.417605),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.303821, longitude: 37.499183),
    OutsidePoint(name: 'Водонапорная башня 1916 года', latitude: 54.763601, longitude: 38.876740),
    // Рязанская область
    OutsidePoint(name: 'Трубежная набережная Рязани', latitude: 54.635996, longitude: 39.747434),
    OutsidePoint(name: 'Колесо обозрения', latitude: 54.695335, longitude: 39.799284),
    // Тамбовская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 52.725928, longitude: 41.458772),
    OutsidePoint(name: 'Колесо обозрения', latitude: 52.886222, longitude: 40.517541),
    // Воронежская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 51.707600, longitude: 39.161592),
    OutsidePoint(name: 'Смотровая площадка', latitude: 51.670493, longitude: 39.210597),
    OutsidePoint(name: 'Смотровая площадка', latitude: 51.753602, longitude: 39.228816),
    OutsidePoint(name: 'Белая Гора', latitude: 51.775253, longitude: 39.238990),
    OutsidePoint(name: 'Смотровая площадка', latitude: 51.709187, longitude: 39.253297),
    OutsidePoint(name: 'Второй трамвайный уровень Северного моста', latitude: 51.691492, longitude: 39.241238),
    OutsidePoint(name: 'Смотровая площадка', latitude: 51.647532, longitude: 39.232054),
    OutsidePoint(name: 'Смотровая площадка', latitude: 50.966712, longitude: 39.292588),
    // Белгородская область
    OutsidePoint(name: 'Смотровая площадка', latitude: 50.580618, longitude: 36.583857),
    OutsidePoint(name: 'Смотровая площадка', latitude: 50.582189, longitude: 36.595646),
    OutsidePoint(name: 'Смотровая площадка', latitude: 51.283608, longitude: 37.660532),
    // Курская область
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.313456, longitude: 35.405467),
    // Орловская область
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.984178, longitude: 36.097789),
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.971773, longitude: 36.068362),
    // Липецкая область
    OutsidePoint(name: 'Колесо обозрения', latitude: 52.604598, longitude: 39.605584),
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.609591, longitude: 39.602388),
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.613811, longitude: 39.610487),
    OutsidePoint(name: 'Колесо обозрения', latitude: 52.627619, longitude: 38.497407),
    OutsidePoint(name: 'Аргамачья гора', latitude: 52.625200, longitude: 38.519176),
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.618708, longitude: 38.508967),
    OutsidePoint(name: 'Смотровая площадка', latitude: 52.636722, longitude: 38.499774),
    OutsidePoint(name: 'Вид с железнодорожного моста', latitude: 52.605626, longitude: 38.512191),
    OutsidePoint(name: 'Воронов камень', latitude: 52.568691, longitude: 38.385172),
    OutsidePoint(name: 'Скальный массив Звонари', latitude: 52.575115, longitude: 38.352527),
    // Тульская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 54.191777, longitude: 37.637566),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.502984, longitude: 37.106730),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.516678, longitude: 37.082329),
    OutsidePoint(name: 'Смотровая площадка', latitude: 53.771506, longitude: 38.138270),
    // Калужская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 54.505699, longitude: 36.248211),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.505671, longitude: 36.246033),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.510171, longitude: 36.249716),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.517460, longitude: 36.229544),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.510430, longitude: 36.234764),
    OutsidePoint(name: 'Смотровая вышка', latitude: 54.514107, longitude: 36.223148),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.173965, longitude: 36.644671),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.016143, longitude: 36.456460),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.205880, longitude: 36.487609),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.026094, longitude: 35.795081),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.615112, longitude: 35.996058),
    // Брянская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 53.271217, longitude: 34.366968),
    OutsidePoint(name: 'Смотровая площадка', latitude: 53.239101, longitude: 34.373795),
    OutsidePoint(name: 'Покровская гора', latitude: 53.244345, longitude: 34.373596),
    OutsidePoint(name: 'Смотровая площадка', latitude: 53.272183, longitude: 34.364794),
    // Смоленская область
    OutsidePoint(name: 'Соборная гора', latitude: 54.788160, longitude: 32.053921),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.785733, longitude: 32.043963),
    OutsidePoint(name: 'Смотровая площадка', latitude: 54.790954, longitude: 32.046370),
    OutsidePoint(name: 'Колесо обозрения', latitude: 54.781745, longitude: 32.037866),
    // Тверская область
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.862765, longitude: 35.904145),
    OutsidePoint(name: 'Гора Соборная', latitude: 56.259488, longitude: 34.340268),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.256536, longitude: 34.317113),
    // Ярославская область
    OutsidePoint(name: 'Колесо обозрения Золотое кольцо', latitude: 57.614730, longitude: 39.867405),
    OutsidePoint(name: 'Смотровая площадка', latitude: 57.621222, longitude: 39.889858),
    OutsidePoint(name: 'Парк аттракционов', latitude: 58.044766, longitude: 38.851037),
    OutsidePoint(name: 'Смотровая площадка', latitude: 58.046750, longitude: 38.855976),
    OutsidePoint(name: 'Молодёжная лестница', latitude: 57.533495, longitude: 38.323581),
    OutsidePoint(name: 'Смотровая площадка Ростовского Кремля', latitude: 57.184805, longitude: 39.417399),
    OutsidePoint(name: 'Смотровая площадка Спасо-Яковлевского Димитриевого монастыря', latitude: 57.173740, longitude: 39.391197),
    OutsidePoint(name: 'Александрова гора', latitude: 56.781946, longitude: 38.831655),
    // Костромская область
    OutsidePoint(name: 'Смотровая площадка', latitude: 57.759683, longitude: 40.940846),
    OutsidePoint(name: 'Смотровая площадка на Лысой горе', latitude: 57.746661, longitude: 40.895281),
    // Ивановская область
    OutsidePoint(name: 'Колесо обозрения', latitude: 57.002970, longitude: 40.976711),
    // Владимирская область
    OutsidePoint(name: 'Небо 33', latitude: 56.141940, longitude: 40.415969),
    OutsidePoint(name: 'Круговой обзор', latitude: 55.578913, longitude: 42.059214),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.580540, longitude: 42.061504),
    OutsidePoint(name: 'Смотровая площадка', latitude: 55.542278, longitude: 42.089961),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.128752, longitude: 40.411607),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.127195, longitude: 40.402835),
    OutsidePoint(name: 'Смотровая площадка водонапорной башни', latitude: 56.125157, longitude: 40.398710),
    OutsidePoint(name: 'Смотровая площадка', latitude: 56.126437, longitude: 40.402649),
    OutsidePoint(name: 'Лысая гора', latitude: 56.192535, longitude: 42.653795),
    // СКФО
    // Ставропольский край
    OutsidePoint(name: 'Колесо обозрения', latitude: 45.043220, longitude: 41.974087),
    OutsidePoint(name: 'Солдатская площадь', latitude: 45.049111, longitude: 41.973722),
    OutsidePoint(name: 'Кафедральная площадь', latitude: 45.050200, longitude: 41.978990),
    OutsidePoint(name: 'Смотровая площадка', latitude: 45.013711, longitude: 41.806532),
    OutsidePoint(name: 'Михайловская гора', latitude: 44.040272, longitude: 43.086749),
    OutsidePoint(name: 'Ленинские скалы', latitude: 44.047067, longitude: 43.081855),
    OutsidePoint(name: 'Смотровая площадка', latitude: 44.054264, longitude: 43.075622),
    OutsidePoint(name: 'Смотровая площадка', latitude: 44.040264, longitude: 43.091367),
    OutsidePoint(name: 'гора Машук', latitude: 44.051173, longitude: 43.086021),
    OutsidePoint(name: 'Колесо обозрения', latitude: 43.903138, longitude: 42.718733),
    OutsidePoint(name: 'Красное солнышко', latitude: 43.899595, longitude: 42.750645),
    OutsidePoint(name: 'Гора Крестовая', latitude: 43.899077, longitude: 42.720327),
    OutsidePoint(name: 'Гора Сосновая 912 метров', latitude: 43.893118, longitude: 42.723574),
    OutsidePoint(name: 'Солдатская горка 930 м', latitude: 43.891076, longitude: 42.713399),
    OutsidePoint(name: 'Серые камни', latitude: 43.898425, longitude: 42.733343),
    OutsidePoint(name: 'Скала Человек', latitude: 43.889208, longitude: 42.753648),
    OutsidePoint(name: 'Гора Пикет', latitude: 43.884246, longitude: 42.731947),
    OutsidePoint(name: 'Малое Седло', latitude: 43.885329, longitude: 42.767483),
    OutsidePoint(name: 'Гора Шульгач', latitude: 43.883650, longitude: 42.782546),
    OutsidePoint(name: 'Лермонтовская скала', latitude: 43.868414, longitude: 42.737716),
    OutsidePoint(name: 'Большое Седло', latitude: 43.886953, longitude: 42.788444),
    OutsidePoint(name: 'Гора Кольцо', latitude: 43.941463, longitude: 42.693632),
    OutsidePoint(name: 'Гора Железная', latitude: 44.138927, longitude: 43.030363),
    OutsidePoint(name: 'Селитряные скалы', latitude: 44.156088, longitude: 43.044073),
    OutsidePoint(name: 'Гора Медовая', latitude: 44.134700, longitude: 43.009238),
    OutsidePoint(name: 'Гора Бештау', latitude: 44.098030, longitude: 43.022101),
    OutsidePoint(name: 'Гора Малый Бештау', latitude: 44.106559, longitude: 43.017597),
    OutsidePoint(name: 'Гора Острая', latitude: 44.118432, longitude: 42.997505),
    // Карачаево-Черкесская республика
    OutsidePoint(name: 'Смотровая площадка в парке «Зеленый остров» ', latitude: 44.229066, longitude: 42.042612),
    OutsidePoint(name: 'Плато Бермамыт', latitude: 43.711662, longitude: 42.441171),
    OutsidePoint(name: 'Архыз', latitude: 43.543067, longitude: 41.181210),
    OutsidePoint(name: 'Домбай', latitude: 43.285625, longitude: 41.636821),
    // Кабардино-Балкарская республика
    OutsidePoint(name: 'Гора Малая Кизиловка', latitude: 43.460676, longitude: 43.599715),
    OutsidePoint(name: 'Гора Эльбрус 5642 м', latitude: 43.352469, longitude: 42.437890),
    OutsidePoint(name: 'Гора Чегет', latitude: 43.245183, longitude: 42.522966),
    OutsidePoint(name: 'Старая канатка', latitude: 43.437437, longitude: 43.593747),
    // Республика Северная Осетия - Алания
    OutsidePoint(name: 'Колесо обозрения', latitude: 43.027721, longitude: 44.677123),
    OutsidePoint(name: 'Лысая гора', latitude: 42.987858, longitude: 44.640031),
    OutsidePoint(name: 'Перевал Архонский', latitude: 42.831182, longitude: 44.212334),
    OutsidePoint(name: 'Колесо Балсага', latitude: 42.850126, longitude: 44.442852),
    // Республика Ингушетия
    OutsidePoint(name: 'Горнолыжный комплекс Армхи', latitude: 42.806741, longitude: 44.704836),
    // Чечня
    OutsidePoint(name: 'Лестница в небеса', latitude: 43.267089, longitude: 45.717265),
    // Дагестан
    OutsidePoint(name: 'Гора Тарки-тау', latitude: 42.940136, longitude: 47.453922),
    OutsidePoint(name: 'Гора Пушкин Тау', latitude: 42.559511, longitude: 47.843461),
    OutsidePoint(name: 'Сулакский Каньон', latitude: 43.021772, longitude: 46.826379),
    OutsidePoint(name: 'Смотровая площадка', latitude: 43.016592, longitude: 46.832421),
    OutsidePoint(name: 'Смотровая площадка', latitude: 43.028861, longitude: 46.823990),
    OutsidePoint(name: 'Водопад Тобот', latitude: 42.554626, longitude: 46.719536),
    OutsidePoint(name: 'Смотровая площадка на Хунзахский каньон', latitude: 42.553516, longitude: 46.721629),

    // ПФО
    // Самара
    OutsidePoint(name: 'Колесо обозрения "Очень большое"',
        latitude: 53.23052682641655,
        longitude: 50.19808242858878),

    // Казань
    OutsidePoint(name: 'Колесо обозрения "Вокруг света"',
        latitude: 55.815461656463896,
        longitude: 49.132394811916576),

    // Нижний Новгород
    OutsidePoint(name: 'Колесо обозрения "НиНо"',
        latitude: 56.32414999756274,
        longitude: 44.03585564133977),

    // Уфа
    OutsidePoint(name: 'Висячий мост',
        latitude: 54.71192834078426,
        longitude: 55.95434360517114),
    OutsidePoint(name: 'Водонапорная башня',
        latitude: 54.722108,
        longitude: 55.918878),

    // Пермь
    OutsidePoint(name: 'Башня смерти',
        latitude: 57.994908,
        longitude: 56.25394),
    OutsidePoint(name: 'Пермская телебашня',
        latitude: 58.005672,
        longitude: 56.291185),

    // Ижевск
    OutsidePoint(name: 'Водонапорная башня 1915 года',
        latitude: 56.850934,
        longitude: 53.207708),

    // Ульяновск
    OutsidePoint(name: 'Башня Ульяновск',
        latitude: 54.31421523455141,
        longitude: 48.501870608675546),

    // Оренбург
    OutsidePoint(name: 'Бывшая водонапорная башня',
        latitude: 51.77502,
        longitude: 55.107466),

    // Пенза
    OutsidePoint(name: 'Оборонительный вал',
        latitude: 53.1826740251631,
        longitude: 45.01523053110502),

    // Чебоксары
    OutsidePoint(name: 'Шупашкар',
        latitude: 56.14849686323186,
        longitude: 47.25917475335799),
  ];
} */


Future<List<PlacemarkMapObject>> _getPlacemarkObjectsO(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/out_points.json');
    final List<dynamic> pointsData = json.decode(jsonString);
    return pointsData.map((data) {
      final point = OutsidePoint.fromJson(data);
      return PlacemarkMapObject(
        mapId: MapObjectId('MapObject $point'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/binoculars.png'),
            scale: 0.15,
          ),
        ),
        onTap: (_, __) => showModalBottomSheet(
          context: context,
          builder: (context) => _ModalBodyViewO(
            point: point,
          ),
        ),
      );
    }).toList();
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

// List<PlacemarkMapObject> _getPlacemarkObjectsP(BuildContext context) {
//   return _getMapPointsP()
//       .map(
//         (point) => PlacemarkMapObject(
//       mapId: MapObjectId('MapObject $point'),
//       point: Point(latitude: point.latitude, longitude: point.longitude),
//       opacity: 1,
//       icon: PlacemarkIcon.single(
//         PlacemarkIconStyle(
//           image: BitmapDescriptor.fromAssetImage(
//             'assets/trees.png',
//           ),
//           scale: 0.15,
//         ),
//       ),
//       onTap: (_, __) => showModalBottomSheet(
//         context: context,
//         builder: (context) => _ModalBodyView(
//           point: point,
//         ),
//       ),
//     ),
//   )
//       .toList();
// }


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

