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
      // ЦФО
        // Москва
      MuseumPoint(name: 'Мавзолей В.И. Ленина', // Название точки
          latitude: 55.753605, // Координаты
          longitude: 37.619773),
      MuseumPoint(name: 'Государственная Третьяковская галерея', latitude: 55.741556, longitude: 37.620028),
      MuseumPoint(name: 'Государственная Третьяковская галерея, галерея Новая Третьяковка', latitude: 55.734719, longitude: 37.605976),
      MuseumPoint(name: 'Оружейная палата', latitude: 55.749455, longitude: 37.613473),
      MuseumPoint(name: 'Музей космонавтики', latitude: 55.822710, longitude: 37.639743),
      MuseumPoint(name: 'Выставка Алмазный фонд Гохрана России', latitude: 55.749593, longitude: 37.613807),
      MuseumPoint(name: 'Государственный музей А. С. Пушкина', latitude: 55.743575, longitude: 37.597736),
      MuseumPoint(name: 'Государственный Дарвиновский музей', latitude: 55.690797, longitude: 37.561547),
      MuseumPoint(name: 'Музей-Диорама Царь-Макет', latitude: 55.817173, longitude: 37.655321),
      MuseumPoint(name: 'Музей "Московский транспорт"', latitude: 55.742534, longitude: 37.678120),
      MuseumPoint(name: 'Исторический парк Россия – моя история', latitude: 55.834244, longitude: 37.626269),
      MuseumPoint(name: 'Музей Холодной войны в Бункер-42 на Таганке', latitude: 55.741754, longitude: 37.649256),
      MuseumPoint(name: 'Государственный музей Владимира Высоцкого', latitude: 55.744448, longitude: 37.651790),
      MuseumPoint(name: 'Музей Михаила Афанасьевича Булгакова', latitude: 55.766996, longitude: 37.593880),
      MuseumPoint(name: 'Музей автомобильных историй В. Попова', latitude: 55.832010, longitude: 37.518757),
      MuseumPoint(name: 'Ломаковский музей старинных автомобилей и мотоциклов', latitude: 55.674730, longitude: 37.771688),
      MuseumPoint(name: 'Московский музей современного искусства', latitude: 55.767011, longitude: 37.614227),
      MuseumPoint(name: 'Государственный музей истории ГУЛАГа', latitude: 55.777088, longitude: 37.613561),
      MuseumPoint(name: 'Музей Москвы', latitude: 55.736390, longitude: 37.593596),
      MuseumPoint(name: 'научно-исследовательский музей архитектуры имени А.В. Щусева', latitude: 55.752481, longitude: 37.607368),
      MuseumPoint(name: 'Государственный музей Востока', latitude: 55.756432, longitude: 37.599815),
      MuseumPoint(name: 'Музей Победы', latitude: 55.730588, longitude: 37.504063),
      MuseumPoint(name: 'Музей Вооружённых Сил ', latitude: 55.784916, longitude: 37.617124),
      MuseumPoint(name: 'Государственный музей обороны Москвы', latitude: 55.676652, longitude: 37.467568),
      MuseumPoint(name: 'Музей-панорама Бородинская битва', latitude: 55.738752, longitude: 37.523187),
      MuseumPoint(name: 'Музей Отечественной войны 1812 года', latitude: 55.756234, longitude: 37.618696),
      MuseumPoint(name: 'Центр современного искусства Винзавод', latitude: 55.755556, longitude: 37.664613),
      MuseumPoint(name: 'Павильон Макет Москвы', latitude: 55.834390, longitude: 37.630086),
      MuseumPoint(name: 'Центр творческих индустрий Фабрика', latitude: 55.779214, longitude: 37.689679),
      MuseumPoint(name: 'Культурный центр ЗИЛ', latitude: 55.714571, longitude: 37.657863),
      MuseumPoint(name: 'ГЭС-2', latitude: 55.742751, longitude: 37.612732),
      MuseumPoint(name: 'Музей Собаки', latitude: 55.716696, longitude: 37.595652),
      MuseumPoint(name: 'Еврейский музей и центр толерантности', latitude: 55.789271, longitude: 37.607867),
      // Подмосковье
      MuseumPoint(name: 'Музей коломенской пастилы', latitude: 55.104594, longitude: 38.769860),
      MuseumPoint(name: 'Музей "Калачная"', latitude: 55.105801, longitude: 38.763801),
      MuseumPoint(name: 'Музейная Фабрика Пастилы', latitude: 55.102318, longitude: 38.770315),
      MuseumPoint(name: 'Музей-резиденция Арткоммуналка. Ерофеев и другие', latitude: 55.100945, longitude: 38.756741),
      MuseumPoint(name: 'Музей Любимой Игрушки', latitude: 55.100945, longitude: 38.756741),
      MuseumPoint(name: 'Душистыя радости', latitude: 55.105534, longitude: 38.763729),
      MuseumPoint(name: 'Тайны Коломенской медовуши', latitude: 55.102541, longitude: 38.752147),
      MuseumPoint(name: 'Музей Сергиевская кухмистерская и ландринная лавка', latitude: 56.312235, longitude: 38.138408),
      MuseumPoint(name: 'Музей советского детства', latitude: 56.312261, longitude: 38.138397),
      MuseumPoint(name: 'Музей современного искусства Кибер Зона', latitude: 56.339176, longitude: 38.126295),
      MuseumPoint(name: 'Музейный комплекс "Конный двор"', latitude: 56.313635, longitude: 38.133183),
      MuseumPoint(name: 'Музей Арт-Макет', latitude: 56.312128, longitude: 38.137571),
      MuseumPoint(name: 'Музей впечатлений', latitude: 56.332259, longitude: 38.132504),
      MuseumPoint(name: 'Музей Назад в СССР', latitude: 55.730600, longitude: 36.852440),
      MuseumPoint(name: 'Музей истории русского десерта', latitude: 55.731011, longitude: 36.848045),
      MuseumPoint(name: 'Музей Лего LEts Go', latitude: 55.733327, longitude: 36.824724),
      MuseumPoint(name: 'Музей Аэрофлота', latitude: 55.982753, longitude: 37.407782),
      MuseumPoint(name: 'Химкинская картинная галерея им. С.Н. Горшина', latitude: 55.889104, longitude: 37.445551),
      MuseumPoint(name: 'Дом-музей Николая Седнина', latitude: 55.970945, longitude: 37.315202),
      MuseumPoint(name: 'Мытищинский историко-художественный музей', latitude: 55.911310, longitude: 37.735419),
      MuseumPoint(name: 'МУК Музейно-выставочный комплекс', latitude: 55.676853, longitude: 37.894330),
      MuseumPoint(name: 'Дом-Музей Чайковского П.И.', latitude: 56.328918, longitude: 36.747430),
      MuseumPoint(name: 'Клинское Подворье', latitude: 56.337918, longitude: 36.721691),
      MuseumPoint(name: 'Музей Аркадия Гайдара', latitude: 56.336707, longitude: 36.724668),
      MuseumPoint(name: 'музей Героев-панфиловцев', latitude: 55.985072, longitude: 36.017115),
      MuseumPoint(name: 'Ярополецкий народный краеведческий музей', latitude: 56.130489, longitude: 35.823193),
      MuseumPoint(name: 'Интерактивный музей имени Героев-панфиловцев', latitude: 55.981099, longitude: 36.035060),
      MuseumPoint(name: 'Музей печати', latitude: 54.917825, longitude: 37.424173),
      MuseumPoint(name: 'Дом-музей П. А. Кропоткина', latitude: 56.341182, longitude: 37.521146),
      MuseumPoint(name: 'Музей Дмитровской лягушки', latitude: 56.344531, longitude: 37.522309),
      MuseumPoint(name: 'Дом-музей священномученика Серафима Звездинского, епископа Дмитровского', latitude: 56.338350, longitude: 37.528386),
      MuseumPoint(name: 'Орехово-Зуевский городской историко-краеведческий музей', latitude: 55.813600, longitude: 38.999664),
      MuseumPoint(name: 'Дом-музей скульптора А.С. Голубкиной', latitude: 54.759416, longitude: 38.881574),
      MuseumPoint(name: 'Можайский историко-краеведческий музей', latitude: 55.509646, longitude: 536.014863),
      MuseumPoint(name: 'Дом-музей С.В. Герасимова', latitude: 55.521269, longitude: 36.010818),
      MuseumPoint(name: 'Музей боевой славы', latitude: 55.509672, longitude: 36.015323),
      MuseumPoint(name: 'Музей техники Вадима Задорожного', latitude: 55.795833, longitude: 37.296648),
      MuseumPoint(name: 'Музейно-выставочный комплекс Новый Иерусалим', latitude: 55.926575, longitude: 36.845210),
      MuseumPoint(name: 'Центральный музей ВВС', latitude: 55.832871, longitude: 38.182575),
      // Рязанская область
      MuseumPoint(name: 'Музей истории Воздушно-десантных войск', latitude: 54.633091, longitude: 39.736315),
      MuseumPoint(name: 'Рязанский государственный областной художественный музей имени И. П. Пожалостина', latitude: 54.627273, longitude: 39.751188),
      MuseumPoint(name: 'Мемориальный музей-усадьба академика И.П. Павлова', latitude: 54.631759, longitude: 39.727231),
      MuseumPoint(name: 'Рязанский музей дальней авиации', latitude: 54.653798, longitude: 39.588518),
      MuseumPoint(name: 'Музей истории рязанского леденца', latitude: 54.633637, longitude: 39.743662),
      MuseumPoint(name: 'Историко-мемориальный зал боевой техники и вооружения ВДВ', latitude: 54.613783, longitude: 39.667641),
      MuseumPoint(name: 'Интерактивный музей сказок Забава', latitude: 54.627272, longitude: 39.744274),
      MuseumPoint(name: 'Аромат времени', latitude: 54.629799, longitude: 39.736157),
      // Тамбовская область
      MuseumPoint(name: 'Усадьба Асеевых', latitude: 52.707157, longitude: 41.477798),
      MuseumPoint(name: 'Тамбовский областной краеведческий музей', latitude: 52.725193, longitude: 41.453714),
      MuseumPoint(name: 'Дом-музей Г.В. Чичерина', latitude: 52.715248, longitude: 41.460724),
      MuseumPoint(name: 'Музей истории шоколада Такф', latitude: 52.723877, longitude: 41.441458),
      MuseumPoint(name: 'Музейно-выставочный центр Тамбовской области', latitude: 52.722934, longitude: 41.451026),
      MuseumPoint(name: 'Тамбовская областная картинная галерея', latitude: 52.724682, longitude: 41.456062),
      MuseumPoint(name: 'Мичуринский краеведческий музей', latitude: 52.894011, longitude: 40.507838),
      MuseumPoint(name: 'Дом-музей И.В. Мичурина', latitude: 52.898384, longitude: 40.525992),
      // Воронежская область
      MuseumPoint(name: 'Воронежский областной художественный музей имени И.Н. Крамского', latitude: 51.673911, longitude: 39.209867),
      MuseumPoint(name: 'Петровские корабли', latitude: 51.661738, longitude: 39.188083),
      MuseumPoint(name: 'Воронежский областной краеведческий музей', latitude: 51.666628, longitude: 39.193560),
      MuseumPoint(name: 'Музей природы Воронежского заповедника', latitude: 51.875599, longitude: 39.652909),
      MuseumPoint(name: 'Музей И. А. Бунина', latitude: 51.679787, longitude: 39.215283),
      // Белгородская область
      MuseumPoint(name: 'Музей-диорама «Курская битва»', latitude: 50.591283, longitude: 36.587800),
      MuseumPoint(name: 'Белгородский художественный музей', latitude: 50.592766, longitude: 36.586711),
      MuseumPoint(name: 'Белгородский государственный историко-краеведческий музей', latitude: 50.592369, longitude: 36.588039),
      MuseumPoint(name: 'Белгородский государственный музей народной культуры', latitude: 50.594849, longitude: 36.589697),
      MuseumPoint(name: 'Белгородский государственный литературный музей', latitude: 50.597632, longitude: 36.598884),
      MuseumPoint(name: 'Центр народных промыслов', latitude: 51.281342, longitude: 37.793572),
      MuseumPoint(name: 'Музей «Прохоровское поле»', latitude: 51.042701, longitude: 36.749264),
      // Курская область
      MuseumPoint(name: 'Курский областной краеведческий музей', latitude: 51.727587, longitude: 36.191589),
      MuseumPoint(name: 'Литературный музей', latitude: 51.742082, longitude: 36.188181),
      MuseumPoint(name: 'Курск – город воинской славы', latitude: 51.756923, longitude: 36.187768),
      MuseumPoint(name: 'Историко-мемориальный музей КП Центрального фронта', latitude: 51.971378, longitude: 36.310867),
      MuseumPoint(name: 'Железногорский краеведческий музей', latitude: 52.343717, longitude: 35.348376),
      // Орловская область
      MuseumPoint(name: 'Орловский краеведческий музей', latitude: 52.964147, longitude: 36.068431),
      MuseumPoint(name: 'Орловский военно-исторический музей', latitude: 52.953142, longitude: 36.063875),
      MuseumPoint(name: 'Музей коллекционных кукол', latitude: 52.967462, longitude: 36.128420),
      MuseumPoint(name: 'музей И.С. Тургенева', latitude: 52.967111, longitude: 36.061254),
      MuseumPoint(name: 'Дом-музей В. А. Русанова', latitude: 52.963290, longitude: 36.087411),
      MuseumPoint(name: 'Музей И. А. Бунина', latitude: 52.965983, longitude: 36.060983),
      MuseumPoint(name: 'Дом-музей Леонида Андреева', latitude: 52.961264, longitude: 36.048971),
      MuseumPoint(name: 'Орловский музей изобразительных искусств', latitude: 52.972268, longitude: 36.058220),
      // Липецкая область
      MuseumPoint(name: 'Липецкий областной краеведческий музей', latitude: 52.613984, longitude: 39.608564),
      MuseumPoint(name: 'Автолегенда', latitude: 52.583095, longitude: 39.566307),
      MuseumPoint(name: 'Музей НЛМК', latitude: 52.573166, longitude: 39.621266),
      MuseumPoint(name: 'Липецкий историко-культурный музей', latitude: 52.617903, longitude: 39.582812),
      MuseumPoint(name: 'Художественный музей имени В.С. Сорокина - Дом Мастера', latitude: 52.609651, longitude: 39.601860),
      MuseumPoint(name: 'Музей купечества и сословий', latitude: 52.627139, longitude: 38.498348),
      MuseumPoint(name: 'Литературно-мемориальный музей И. А. Бунина', latitude: 52.618694, longitude: 38.493767),
      MuseumPoint(name: 'Музей Елецкого кружева', latitude: 52.619734, longitude: 38.501905),
      // Тульская область
      MuseumPoint(name: 'Тульский государственный музей оружия', latitude: 54.204272, longitude: 37.616499),
      MuseumPoint(name: 'Музей Тульский пряник', latitude: 54.211566, longitude: 37.622105),
      MuseumPoint(name: 'Музей гармони Деда Филимона', latitude: 54.192505, longitude: 37.621713),
      MuseumPoint(name: 'Музей станка', latitude: 54.191087, longitude: 37.612136),
      MuseumPoint(name: 'Тульский Историко-архитектурный музей', latitude: 54.190004, longitude: 37.614505),
      MuseumPoint(name: 'Музей «Тульские древности»', latitude: 54.186354, longitude: 37.610586),
      MuseumPoint(name: 'Исторический музей', latitude: 54.197853, longitude: 37.617136),
      MuseumPoint(name: 'Художественно-краеведческий музей', latitude: 54.513200, longitude: 37.093721),
      MuseumPoint(name: 'Музейно-мемориальный комплекс героям Куликовской битвы', latitude: 53.670591, longitude: 38.642492),
      MuseumPoint(name: 'Тульские самовары', latitude: 54.194319, longitude: 37.618821),
      MuseumPoint(name: 'Музей-лаборатория', latitude: 54.197638, longitude: 37.617157),
      MuseumPoint(name: 'Музей Мото-Авто-АРТ', latitude: 54.154436, longitude: 37.482534),
      MuseumPoint(name: 'Музей-заповедник Куликово поле', latitude: 53.623942, longitude: 38.672613),
      MuseumPoint(name: 'Музей купеческого быта', latitude: 53.827551, longitude: 38.554383),
      MuseumPoint(name: 'Музей Филимоновская игрушка', latitude: 53.936195, longitude: 36.687622),
      MuseumPoint(name: 'Усадьба Дворяниново', latitude: 54.704284, longitude: 37.557130),
      MuseumPoint(name: 'Военно-исторический музей', latitude: 54.195905, longitude: 37.619724),
      // Калужская область
      MuseumPoint(name: 'Музей истории космонавтики', latitude: 54.516970, longitude: 36.230691),
      MuseumPoint(name: 'Мемориальный дом-музей К.Э. Циолковского', latitude: 54.511175, longitude: 36.230194),
      MuseumPoint(name: 'Музейно-краеведческий комплекс Усадьба Золотарёвых', latitude: 54.510688, longitude: 36.245533),
      MuseumPoint(name: 'Дом-музей А. Л. Чижевского', latitude: 54.518204, longitude: 36.262700),
      MuseumPoint(name: 'Калужский музей изобразительных искусств', latitude: 54.508683, longitude: 36.256678),
      MuseumPoint(name: 'Музей стекла Алексея Зеля', latitude: 54.507302, longitude: 36.254671),
      MuseumPoint(name: 'Музейно-краеведческий центр Палаты Коробовых', latitude: 54.510564, longitude: 36.242695),
      MuseumPoint(name: 'Военно-исторический центр Маршал Победы - Георгий Константинович Жуков', latitude: 54.516493, longitude: 36.283567),
      MuseumPoint(name: 'Обнинский музей', latitude: 55.110739, longitude: 36.589871),
      MuseumPoint(name: 'Художественный музей мусора МУ МУ', latitude: 55.123313, longitude: 36.825582),
      MuseumPoint(name: 'Планетарий', latitude: 54.516892, longitude: 36.230838),
      MuseumPoint(name: 'Музей 1812 года', latitude: 55.012118, longitude: 36.473574),
      MuseumPoint(name: 'Музей-диорама Великое Стояние на реке Угре', latitude: 54.614173, longitude: 35.999558),
      MuseumPoint(name: 'Тарусский музей семьи Цветаевых', latitude: 54.730868, longitude: 37.175487),
      MuseumPoint(name: 'Музей Сергея Жарова', latitude: 54.723248, longitude: 37.181724),
      MuseumPoint(name: 'Мастерская Эдуарда Штейнберга', latitude: 54.715525, longitude: 37.187720),
      MuseumPoint(name: 'Бузеон', latitude: 54.738701, longitude: 35.995741),
      MuseumPoint(name: 'Музей Kомпьютеров', latitude: 55.208550, longitude: 36.486071),
      MuseumPoint(name: 'Музейно-выставочный центр', latitude: 55.203667, longitude: 36.487626),
      MuseumPoint(name: 'Брянский музей истории фотографии', latitude: 53.244344, longitude: 34.359779),
      MuseumPoint(name: 'Литературно-Мемориальный Музей Ф.И. Тютчева', latitude: 53.373080, longitude: 33.878620),
      // Смоленская область
      MuseumPoint(name: 'Музей Великой Отечественной войны', latitude: 54.779374, longitude: 32.047485),
      MuseumPoint(name: 'Музей Смоленская крепость, Башня Громовая', latitude: 54.780070, longitude: 32.043756),
      MuseumPoint(name: 'Художественная галерея', latitude: 54.780461, longitude: 32.046122),
      MuseumPoint(name: 'Музей Первого полёта', latitude: 55.553629, longitude: 35.004712),
      // Тверская область
      MuseumPoint(name: 'Музей козла', latitude:56.853323 , longitude: 35.910438),
      MuseumPoint(name: 'Музей Плюшкина', latitude: 56.855986, longitude: 35.917648),
      MuseumPoint(name: 'Музей тверского быта', latitude: 56.866496, longitude: 35.910294),
      MuseumPoint(name: 'Музей фотографии Искра', latitude: 56.858277, longitude: 35.909846),
      MuseumPoint(name: 'Ретро-техно-музей ИнтернетаНЕТ', latitude: 56.854410, longitude: 35.910437),
      MuseumPoint(name: 'Музей Михаила Круга', latitude: 56.850166, longitude: 35.907613),
      MuseumPoint(name: 'Музей золотного шитья', latitude: 57.031288, longitude: 34.988408),
      MuseumPoint(name: 'Музей стекла завода Красный май', latitude: 57.588388, longitude: 34.557879),
      MuseumPoint(name: 'Вышневолоцкий краеведческий музей имени Г. Г. Монаховой', latitude: 57.584851, longitude: 34.560525),
      MuseumPoint(name: 'Ржевский краеведческий музей', latitude: 56.260367, longitude: 34.330319),
      MuseumPoint(name: 'Кимрский краеведческий музей', latitude: 56.872847, longitude: 37.355604),
      // Ярославская область
      MuseumPoint(name: 'Музыка и время', latitude: 57.630078, longitude: 39.895167),
      MuseumPoint(name: 'Ярославский художественный музей', latitude: 57.628289, longitude: 39.897206),
      MuseumPoint(name: 'Музей истории города Ярославля', latitude: 57.627059, longitude: 39.898601),
      MuseumPoint(name: 'Мультимедийный музей нового взгляда на историю', latitude: 57.632396, longitude: 39.893411),
      MuseumPoint(name: 'Музей боевой славы', latitude: 57.633218, longitude: 39.831700),
      MuseumPoint(name: 'Музей им. В. Ю. Орлова', latitude: 57.626421, longitude: 39.899205),
      MuseumPoint(name: 'Рыбинский музей-заповедник', latitude: 58.049425, longitude: 38.856285),
      MuseumPoint(name: 'Музей Советская эпоха', latitude: 58.073149, longitude: 38.815925),
      MuseumPoint(name: 'Музей Мологского края', latitude: 58.047322, longitude: 38.855442),
      MuseumPoint(name: 'Русская Атлантида', latitude: 58.049220, longitude: 38.855643),
      MuseumPoint(name: 'Музей гидроэнергетики', latitude: 57.524446, longitude: 38.303831),
      MuseumPoint(name: 'Музей тюремного искусства Запретная зона', latitude: 57.529452, longitude: 38.321240),
      MuseumPoint(name: 'Музей Мифы и суеверия русского народа', latitude: 57.523510, longitude: 38.307963),
      MuseumPoint(name: 'Музей истории велосипедов Самокатъ', latitude: 57.529358, longitude: 38.321423),
      MuseumPoint(name: 'Музей кожевенного ремесла', latitude: 57.529793, longitude: 38.321620),
      MuseumPoint(name: 'Музей Царевны-лягушки', latitude: 57.182759, longitude: 39.405209),
      MuseumPoint(name: 'Музей Народного Искусства', latitude: 57.181900, longitude: 39.403927),
      MuseumPoint(name: 'Богатырское подворье Алёши Поповича и мастерская Марьи Искусницы', latitude: 57.183159, longitude: 39.402175),
      MuseumPoint(name: 'Музей Ростовское подворье', latitude: 57.186380, longitude: 39.416443),
      MuseumPoint(name: 'Ростовская пряница', latitude: 57.181641, longitude: 39.400977),
      MuseumPoint(name: 'Музей утюга', latitude: 56.734618, longitude: 38.852470),
      MuseumPoint(name: 'Шоу-макет Золотое кольцо', latitude: 57.626970, longitude: 39.897280),
      MuseumPoint(name: 'Музей мыши', latitude: 57.783786, longitude: 38.450742),
      MuseumPoint(name: 'Музей баклуши и библиотека варенья', latitude: 57.311617, longitude: 39.518694),
      MuseumPoint(name: 'Мышкины палаты', latitude: 57.785626, longitude: 38.453800),
      MuseumPoint(name: 'Музей радио', latitude: 56.722978, longitude: 38.824372),
      MuseumPoint(name: 'Лукова слобода', latitude: 57.194430, longitude: 39.402462),
      // Костромская область
      MuseumPoint(name: 'Музей сыра', latitude: 57.762517, longitude: 40.930541),
      MuseumPoint(name: 'Музей-усадьба льна и бересты', latitude: 57.778283, longitude: 40.912275),
      MuseumPoint(name: 'Дом городского головы Г.Н. Ботникова', latitude: 57.766890, longitude: 40.931561),
      MuseumPoint(name: 'Романовский музей', latitude: 57.769630, longitude: 40.929817),
      MuseumPoint(name: 'Музей народных промыслов Петровская игрушка', latitude: 57.769124, longitude: 40.913451),
      MuseumPoint(name: 'Лес Чудодей', latitude: 57.775469, longitude: 40.903656),
      MuseumPoint(name: 'Терем Снегурочки', latitude: 57.755679, longitude: 40.950939),
      // Ивановская область
      MuseumPoint(name: 'Музей советского автопрома', latitude: 56.996854, longitude: 40.959893),
      MuseumPoint(name: 'Музей Ивановского ситца', latitude: 57.004843, longitude: 40.973890),
      MuseumPoint(name: 'Музей промышленности и искусства', latitude: 57.004354, longitude: 40.974172),
      MuseumPoint(name: 'Ивановский областной художественный музей', latitude: 57.008145, longitude: 40.971791),
      MuseumPoint(name: 'Мемориальный дом-музей И.И. Левитана', latitude: 57.459304, longitude: 41.523661),
      // Владимирская область
      MuseumPoint(name: 'Музей Старый Владимир', latitude: 56.125151, longitude: 40.398685),
      MuseumPoint(name: 'Дом-музей пряника', latitude: 56.128181, longitude: 40.404515),
      MuseumPoint(name: 'Музей ложки', latitude: 56.127450, longitude: 40.403348),
      MuseumPoint(name: 'Кузница-музей Бородиных', latitude:56.126805, longitude: 40.402610),
      MuseumPoint(name: 'Музей-сказка Бабуся-Ягуся', latitude: 56.127675, longitude: 40.402115),
      MuseumPoint(name: 'Музей «Старая аптека»', latitude: 56.127253, longitude: 40.402362),
      MuseumPoint(name: 'Музей хрусталя имени Мальцовых', latitude: 55.619820, longitude: 40.658117),
      MuseumPoint(name: 'Кибер музей. Музей воспоминаний', latitude: 55.580339, longitude: 42.054271),
      MuseumPoint(name: 'Хлебная горница', latitude: 55.569142, longitude: 42.021963),
      MuseumPoint(name: 'Нескучный Mузей Изба Трактир', latitude: 56.417028, longitude: 40.448934),
      MuseumPoint(name: 'Музей восковых фигур', latitude: 56.418694, longitude: 40.448229),
      MuseumPoint(name: 'Музей Огни Владимира', latitude: 56.127620, longitude: 40.399929),
      // СКФО
      // Ставропольский край
      MuseumPoint(name: 'Исторический парк Россия - Моя история', latitude: 45.021690, longitude: 41.895405),
      MuseumPoint(name: 'Ставропольский государственный историко-культурный и природно-ландшафтный музей-заповедник имени Г. Н. Прозрителева и Г. К. Праве', latitude: 45.044704, longitude: 41.968207),
      MuseumPoint(name: 'Пятигорский краеведческий музей', latitude: 44.036116, longitude: 43.079856),
      MuseumPoint(name: 'Музей насекомых Экзотариум', latitude: 44.037612, longitude: 43.083546),
      MuseumPoint(name: 'Домик М. Ю. Лермонтова', latitude: 44.039582, longitude: 43.078808),
      MuseumPoint(name: 'Россия – моя история', latitude: 44.036370, longitude: 43.013081),
      MuseumPoint(name: 'Планетарий', latitude: 44.033742, longitude: 43.065160),
      MuseumPoint(name: 'Зоопарк Берендеево', latitude: 44.033577, longitude: 43.059645),
      MuseumPoint(name: 'Лермонтовская галерея', latitude: 44.036681, longitude: 43.081991),
      MuseumPoint(name: 'музей-усадьба художника Николая Александровича Ярошенко', latitude: 43.892832, longitude: 42.718557),
      MuseumPoint(name: 'Литературно-музыкальный музей Дача Шаляпина', latitude: 43.900877, longitude: 42.722964),
      MuseumPoint(name: 'Кисловодский историко-краеведческий музей Крепость', latitude: 43.894760, longitude: 42.716415),
      MuseumPoint(name: 'Музей истории и природы национального парка Кисловодский', latitude: 43.900446, longitude: 42.717017),
      MuseumPoint(name: 'Информационно-культурный центр Музей А. И. Солженицына', latitude: 43.901304, longitude: 42.724070),
      MuseumPoint(name: 'Театр-музей «Благодать»', latitude: 43.900442, longitude: 42.726733),
      MuseumPoint(name: 'Пушкинская галерея', latitude: 44.135037, longitude: 43.031651),
      MuseumPoint(name: 'Смирновский источник', latitude: 44.137667, longitude: 43.035159),
    ];
  }
  /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  List<ParkPoint> _getMapPointsP() {
    return const [
      // ЦФО
      // Москва
      ParkPoint(
          name: 'Парк Зарядье', latitude: 55.751238, longitude: 37.627762),
      ParkPoint(name: 'Парк Горького', latitude: 55.731474, longitude: 37.603431),
      ParkPoint(name: 'Парк Сокольники', latitude: 55.792648, longitude: 37.677681),
      ParkPoint(name: 'Парк Победы на Поклонной горе', latitude: 55.731233, longitude: 37.506585),
      ParkPoint(name: 'Московский зоопарк', latitude: 55.761092, longitude: 37.578308),
      ParkPoint(name: 'ВДНХ', latitude: 55.826310, longitude: 37.637855),
      ParkPoint(name: 'музей-заповедник Царицыно', latitude: 55.615670, longitude: 37.688789),
      ParkPoint(name: 'Музей-заповедник Коломенское', latitude: 55.667650, longitude: 37.670862),
      ParkPoint(name: 'Музеон', latitude: 55.733055, longitude: 37.604646),
      ParkPoint(name: 'Измайловский парк культуры и отдыха', latitude: 55.772451, longitude: 37.753986),
      ParkPoint(name: 'Лианозовский парк культуры и отдыха', latitude: 55.900325, longitude: 37.567154),
      ParkPoint(name: 'Музейно-парковый комплекс Северное Тушино', latitude: 55.850676, longitude: 37.455103),
      ParkPoint(name: 'Бабушкинский парк', latitude: 55.865978, longitude: 37.680594),
      ParkPoint(name: 'Таганский парк', latitude: 55.737711, longitude: 37.667363),
      ParkPoint(name: 'Сад имени Н. Э. Баумана', latitude: 55.765690, longitude: 37.660774),
      ParkPoint(name: 'Нескучный сад', latitude: 55.718356, longitude: 37.591445),
      ParkPoint(name: 'Парк Фили', latitude: 55.745565, longitude: 37.488091),
      ParkPoint(name: 'Ландшафтный заказник Тёплый Стан', latitude: 55.634939, longitude: 37.489573),
      ParkPoint(name: 'Битцевский лес', latitude: 55.597407, longitude: 37.557439),
      ParkPoint(name: 'Сказка', latitude: 55.772178, longitude: 37.435196),
      
      // Подмосковье
      ParkPoint(name: 'Коломенский кремль', latitude:  55.103325, longitude: 38.752522),
      ParkPoint(name: 'Свято-Троицкая Сергиева лавра', latitude: 56.311120, longitude: 38.130492),
      ParkPoint(name: 'Водопад Гремячий', latitude: 56.270298, longitude: 38.343825),
      ParkPoint(name: 'Келарский пруд', latitude: 56.304835, longitude: 38.126827),
      ParkPoint(name: 'Государственный историко-художественный и литературный музей-заповедник Абрамцево', latitude: 56.234583, longitude: 37.965156),
      ParkPoint(name: 'Этнопарк Кочевник', latitude: 56.241326, longitude: 38.051608),
      ParkPoint(name: 'Скитские Пруды', latitude: 56.301814, longitude: 38.164148),
      ParkPoint(name: 'Саввино-Сторожевский ставропигиальный мужской монастырь', latitude: 55.728306, longitude: 36.816050),
      ParkPoint(name: 'Конное подворье Дютьково', latitude: 55.752661, longitude: 36.808148),
      ParkPoint(name: 'Саввинский мужской скит', latitude: 55.736574, longitude: 36.813358),
      ParkPoint(name: 'Купчий двор', latitude: 55.729467, longitude: 36.856401),
      ParkPoint(name: 'Усадьба Введенское', latitude: 55.707168, longitude: 36.872188),
      ParkPoint(name: 'Городской парк', latitude: 55.731718, longitude: 36.849944),
      ParkPoint(name: 'Чудо-парк', latitude: 55.713540, longitude: 36.938412),
      ParkPoint(name: 'Парк Захарово', latitude: 55.643520, longitude: 36.968306),
      ParkPoint(name: 'Парк Патриот', latitude: 55.563465, longitude: 36.816774),
      ParkPoint(name: 'Парк культуры и отдыха имени Л.Н. Толстого', latitude: 55.894013, longitude: 37.458965),
      ParkPoint(name: 'Киногород Пилигрим Порто', latitude: 55.925659, longitude: 37.232484),
      ParkPoint(name: 'Парк Эко-Берег', latitude: 55.899850, longitude: 37.470783),
      ParkPoint(name: 'Сквер имени Марии Рубцовой', latitude: 55.890316, longitude: 37.431098),
      ParkPoint(name: 'парк Дубки', latitude: 55.893475, longitude: 37.419871),
      ParkPoint(name: 'Зоопарк Горки', latitude: 55.133950, longitude: 39.209149),
      ParkPoint(name: 'Экзотик парк', latitude: 55.414518, longitude: 37.270044),
      ParkPoint(name: 'Парк Мира', latitude: 55.910528, longitude: 37.742207),
      ParkPoint(name: 'Перловский парк', latitude: 55.895942, longitude: 37.733629),
      ParkPoint(name: 'Парк Яуза', latitude: 55.898463, longitude: 37.716329),
      ParkPoint(name: 'Zooландия', latitude: 55.879849, longitude: 36.795201),
      ParkPoint(name: 'Наташинский парк', latitude: 55.695321, longitude: 37.888542),
      ParkPoint(name: 'Парк культуры и отдыха', latitude: 55.677142, longitude: 37.897201),
      ParkPoint(name: 'Свято-Никольский Угрешский мужской ставропигиальный монастырь', latitude: 55.622957, longitude: 37.840008),
      ParkPoint(name: 'Сквер Победы', latitude: 55.625099, longitude: 37.842893),
      ParkPoint(name: 'Усадьба Пущино', latitude: 54.839537, longitude: 37.603550),
      ParkPoint(name: 'парк Зелёная Зона', latitude: 54.831983, longitude: 37.617088),
      ParkPoint(name: 'Пехорка', latitude: 55.801501, longitude: 37.942108),
      ParkPoint(name: 'Усадьба Пехра-Яковлевское', latitude: 55.792378, longitude: 37.953172),
      ParkPoint(name: 'парк Заречная', latitude: 55.821931, longitude: 37.964305),
      ParkPoint(name: 'Городской парк Ёлочки', latitude: 55.420065, longitude: 37.777010),
      ParkPoint(name: 'Музей сказок', latitude: 55.411014, longitude: 37.782155),
      ParkPoint(name: 'Музей-усадьба Архангельское', latitude: 55.784558, longitude: 37.284041),
      ParkPoint(name: 'Городской парк Новые Водники', latitude: 55.964867, longitude: 37.524444),
      ParkPoint(name: 'Красногорский городской парк', latitude: 55.823528, longitude: 37.324320),
      ParkPoint(name: 'Парк культуры и отдыха Ивановские пруды', latitude: 55.819764, longitude: 37.316468),
      ParkPoint(name: 'Сестрорецкий парк', latitude: 56.324999, longitude: 36.736576),
      ParkPoint(name: 'Вальс цветов', latitude: 56.323394, longitude:  36.744152),
      ParkPoint(name: 'Музейно-выставочный комплекс Волоколамский кремль', latitude: 56.037940, longitude: 35.957310),
      ParkPoint(name: 'Парк культуры и отдыха', latitude: 56.030322, longitude: 35.967944),
      ParkPoint(name: 'Серпуховский кремль', latitude: 54.915325, longitude: 37.405279),
      ParkPoint(name: 'Парк Питомник', latitude: 54.927759, longitude: 37.442060),
      ParkPoint(name: 'Парк им. Олега Степанова', latitude: 54.910643, longitude: 37.424258),
      ParkPoint(name: 'Принарский парк', latitude: 54.907583, longitude: 37.413156),
      ParkPoint(name: 'Музей-заповедник Дмитровский кремль', latitude: 56.345018, longitude: 37.520050),
      ParkPoint(name: 'Березовая роща', latitude: 56.333695, longitude: 37.516873),
      ParkPoint(name: 'Парк 30-летия Победы', latitude: 55.802110, longitude: 38.969766),
      ParkPoint(name: 'Парк культуры и отдыха', latitude: 55.801516, longitude: 38.980757),
      ParkPoint(name: 'Государственный музей заповедник Зарайский кремль', latitude: 54.757432, longitude: 38.870865),
      ParkPoint(name: 'Центральный парк культуры и отдыха', latitude: 54.756968, longitude: 38.886056),
      ParkPoint(name: 'Можайский кремль', latitude: 55.509753, longitude: 36.010863),
      ParkPoint(name: 'Парк культуры, отдыха и спорта Ривьера', latitude: 55.519605, longitude: 36.024392),
      ParkPoint(name: 'Музей-Усадьба Мураново', latitude: 56.178288, longitude: 37.902758),
      ParkPoint(name: 'Парк птиц Воробьи', latitude: 55.158957, longitude: 36.778894),
      ParkPoint(name: 'Парк приключений Дикие белки', latitude: 55.156920, longitude: 37.632110),
      ParkPoint(name: 'Парк усадьбы Кривякино', latitude: 55.319883, longitude: 38.672473),
      ParkPoint(name: 'Парк активного отдыха «Раздолье»', latitude: 55.735468, longitude: 37.293059),
      // Рязанская область
      ParkPoint(name: 'Рязанский кремль', latitude: 54.635804, longitude: 39.748336),
      ParkPoint(name: 'Центральный парк культуры и отдыха Рюмина Роща', latitude: 54.611198, longitude: 39.731983),
      ParkPoint(name: 'Бульвар Победы', latitude: 54.644015, longitude: 39.658590),
      ParkPoint(name: 'Прио-Лэнд', latitude: 54.626260, longitude: 39.710340),
      ParkPoint(name: 'Окская жемчужина', latitude: 54.695515, longitude: 39.798664),
      ParkPoint(name: 'Государственный музей-заповедник С. А. Есенина', latitude: 54.863263, longitude: 39.602017),
      // Тамбовская область
      ParkPoint(name: 'парк 50-летия Победы', latitude: 52.750076, longitude: 41.414629),
      ParkPoint(name: 'Лесопарк «Дружба»', latitude: 52.707534, longitude: 41.493820),
      ParkPoint(name: 'Парк аттракционов', latitude: 52.725067, longitude: 41.457751),
      ParkPoint(name: 'ландшафтный парк-набережная Мичуринское подгорье', latitude: 52.893581, longitude: 40.521064),
      ParkPoint(name: 'Парк культуры и отдыха', latitude: 52.887730, longitude: 40.516678),
      // Воронежская область
      ParkPoint(name: 'Интерактивный музей Дом Бобра', latitude: 51.876766, longitude: 39.657800),
      ParkPoint(name: 'Парк Орлёнок', latitude: 51.675241, longitude: 39.208387),
      ParkPoint(name: 'Алые Паруса', latitude: 51.657489, longitude: 39.236773),
      ParkPoint(name: 'Парк Победа', latitude: 51.706358, longitude: 39.161421),
      ParkPoint(name: 'Дельфин', latitude: 51.685853, longitude: 39.253000),
      ParkPoint(name: 'Бульвар Чернавская Дамба', latitude: 51.671717, longitude: 39.235188),
      ParkPoint(name: 'Лесопарк Оптимистов', latitude: 51.650519, longitude: 39.110372),
      ParkPoint(name: 'Дендрарий ВГЛТУ', latitude: 51.717606, longitude: 39.219907),
      ParkPoint(name: 'Городской парк культуры и отдыха Борисоглебского городского округа Воронежской области', latitude: 51.366621, longitude: 42.063238),
      ParkPoint(name: 'Городской парк культуры и отдыха', latitude: 50.993659, longitude: 39.483585),
      ParkPoint(name: 'Музей-заповедник Дивногорье', latitude: 50.963659, longitude: 39.294938),
      // Белгородская область
      ParkPoint(name: 'Парк культуры и отдыха им. В.И. Ленина', latitude: 50.606887, longitude: 36.586744),
      ParkPoint(name: 'парк Котофей', latitude: 50.589664, longitude: 36.584702),
      ParkPoint(name: 'Динопарк', latitude: 50.553126, longitude: 36.643847),
      ParkPoint(name: 'Пикник-Парк', latitude: 50.508072, longitude: 36.648865),
      ParkPoint(name: 'Парк Победы', latitude: 50.591917, longitude: 36.584330),
      ParkPoint(name: 'Парк Зеленый Лог', latitude: 51.318271, longitude: 37.892556),
      ParkPoint(name: 'Комсомольский парк', latitude: 51.280213, longitude: 37.800783),
      ParkPoint(name: 'Старооскольский зоопарк', latitude: 51.322957, longitude: 37.999321),
      // Курская область
      ParkPoint(name: 'Парк Боева дача', latitude: 51.742198, longitude: 36.211259),
      ParkPoint(name: 'Новая Боевка', latitude: 51.743542, longitude: 36.214585),
      ParkPoint(name: 'парк КЗТЗ', latitude: 51.705550, longitude: 36.156164),
      ParkPoint(name: 'Железногорский дендрологический парк', latitude: 52.338536, longitude: 35.339032),
      // Орловская область
      ParkPoint(name: 'Городской парк культуры и отдыха', latitude: 52.973487, longitude: 36.070479),
      ParkPoint(name: 'Детский парк', latitude: 52.968405, longitude: 36.067654),
      ParkPoint(name: 'ландшафтный парк Дворянское Гнездо', latitude: 52.967326, longitude: 36.052006),
      ParkPoint(name: 'музей-заповедник И.С. Тургенева Спасское-Лутовиново', latitude: 53.372268, longitude: 36.631877),
      ParkPoint(name: 'Сквер Танкистов', latitude: 52.968563, longitude: 36.079052),
      // Липецкая область
      ParkPoint(name: 'Парк Победы', latitude: 52.594742, longitude: 39.523285),
      ParkPoint(name: 'Молодёжный парк', latitude: 52.587688, longitude: 39.508325),
      ParkPoint(name: 'Парк Металлургов', latitude: 52.583551, longitude: 39.625548),
      ParkPoint(name: 'Парк аттракционов Жемчужина', latitude: 52.597044, longitude: 39.523606),
      ParkPoint(name: 'Городские парки г. Ельца', latitude: 52.626508, longitude: 38.495667),
      ParkPoint(name: 'Детский парк имени Бориса Григорьевича Лесюка', latitude: 52.624494, longitude: 38.495658),
      ParkPoint(name: 'парк 40-летия Великой Октябрьской Социалистической Революции', latitude: 52.616178, longitude: 38.466862),
      ParkPoint(name: 'Петровский парк', latitude: 52.606753, longitude: 38.506837),
      ParkPoint(name: 'сквер имени А.С. Пушкина', latitude: 52.616591, longitude: 38.510436),
      ParkPoint(name: 'Старая гидромельница купца Талдыкина', latitude: 52.572653, longitude: 38.361530),
      ParkPoint(name: 'Нижний парк', latitude: 52.604964, longitude: 39.603257),
      ParkPoint(name: 'Липецкий зоопарк', latitude: 52.605410, longitude: 39.607101),
      ParkPoint(name: 'парк Быханов сад', latitude: 52.618548, longitude: 39.590318),
      ParkPoint(name: 'Заповедник Галичья Гора', latitude: 52.601510, longitude: 38.928741),
      ParkPoint(name: 'Кудыкина гора', latitude: 52.367879, longitude: 38.769908),
      // Тулькая область
      ParkPoint(name: 'Тульский кремль', latitude: 54.195825, longitude: 37.619855),
      ParkPoint(name: 'Музей Козлова Засека', latitude: 54.096342, longitude: 37.569444),
      ParkPoint(name: 'Центральный парк культуры и отдыха имени П. П. Белоусова', latitude: 54.181642, longitude: 37.588449),
      ParkPoint(name: 'Рогожинский парк', latitude: 54.172101, longitude: 37.616127),
      ParkPoint(name: 'Комсомольский парк', latitude: 54.230559, longitude: 37.622821),
      ParkPoint(name: 'Платоновский парк', latitude: 54.150517, longitude: 37.574402),
      ParkPoint(name: 'Парк Патриот - Тула', latitude: 54.188276, longitude: 37.657889),
      ParkPoint(name: 'Баташевский сад', latitude: 54.221874, longitude: 37.645693),
      ParkPoint(name: 'Кремлёвский сад', latitude: 54.193961, longitude: 37.622706),
      ParkPoint(name: 'Детский парк имени Д.Г. Оники', latitude: 54.015002, longitude: 38.277028),
      ParkPoint(name: 'Городской парк', latitude: 54.017034, longitude: 38.314694),
      ParkPoint(name: 'парк Памяти и Славы', latitude: 54.023101, longitude: 38.310654),
      ParkPoint(name: 'Парк "Жалка"', latitude: 54.516814, longitude: 37.054125),
      ParkPoint(name: 'Музей-усадьба Ясная Поляна', latitude: 54.075501, longitude: 37.526409),
      ParkPoint(name: 'музей усадьба В. Д. Поленова', latitude: 54.748552, longitude: 37.236656),
      ParkPoint(name: 'Богородицкий дворец-музей и парк', latitude: 53.771625, longitude: 38.139179),
      // Калужская область
      ParkPoint(name: 'Центральный городской парк культуры и отдыха', latitude: 54.506944, longitude: 36.248147),
      ParkPoint(name: 'Парк имени Циолковского', latitude: 54.515207, longitude: 36.233873),
      ParkPoint(name: 'Парк Юного зрителя', latitude: 54.513066, longitude: 36.250831),
      ParkPoint(name: 'Парк Усадьбы Яновских', latitude: 54.571482, longitude: 36.263053),
      ParkPoint(name: 'Городской парк', latitude: 55.091113, longitude: 36.605072),
      ParkPoint(name: 'Парк Усадьба Белкино', latitude: 55.126050, longitude: 36.594607),
      ParkPoint(name: 'парк 35-ти летия Победы', latitude: 55.103955, longitude: 36.608231),
      ParkPoint(name: 'Нижний парк', latitude: 55.091463, longitude: 36.581456),
      ParkPoint(name: 'парк Три богатыря', latitude: 54.033479, longitude: 35.794259),
      ParkPoint(name: 'Городской парк', latitude: 54.026194, longitude: 35.794333),
      ParkPoint(name: 'Вихляндия', latitude: 54.039196, longitude: 35.795892),
      ParkPoint(name: 'Арт-парк Никола-Ленивец', latitude: 54.757546, longitude: 35.604235),
      ParkPoint(name: 'Сад и дом-музей Николая Петровича Ракицкого', latitude: 54.719952, longitude: 37.176001),
      ParkPoint(name: 'Музей-заповедник Полотняный Завод', latitude: 54.738235, longitude: 35.995632),
      ParkPoint(name: 'Парк динозавров Эволюция', latitude: 55.245347, longitude: 36.423319),
      ParkPoint(name: 'Лесной лабиринт Дебри', latitude: 55.244514, longitude: 36.423517),
      // Брянская область
      ParkPoint(name: 'Тридевятое Царство', latitude: 53.300842, longitude: 34.236799),
      ParkPoint(name: 'Центральный парк культуры и отдыха им. 1000-летия г. Брянска', latitude: 53.269046, longitude: 34.364993),
      // Смоленская область
      ParkPoint(name: 'Музей-заповедник Гнёздово', latitude: 54.785732, longitude: 31.879890),
      ParkPoint(name: 'Лопатинский сад', latitude: 54.781649, longitude: 32.041711),
      ParkPoint(name: 'парк Соловьиная роща', latitude: 54.759831, longitude: 32.089065),
      ParkPoint(name: 'Реадовский парк', latitude: 54.759805, longitude: 32.020374),
      ParkPoint(name: 'Мемориальный комплекс Катынь', latitude: 54.774122, longitude: 31.789684),
      ParkPoint(name: 'Историко-архитектурный комплекс Теремок', latitude: 54.659180, longitude: 32.209065),
      // Тверская область
      ParkPoint(name: 'Городской сад', latitude: 56.867060, longitude: 35.892022),
      ParkPoint(name: 'Дворцовый сад', latitude: 56.863401, longitude: 35.901760),
      ParkPoint(name: 'Китайский парк', latitude: 56.844248, longitude: 35.819148),
      ParkPoint(name: 'Роща', latitude: 56.837880, longitude: 35.837988),
      ParkPoint(name: 'Новоторжский Кремль', latitude: 57.036734, longitude: 34.955408),
      ParkPoint(name: 'парк Подпольщиков', latitude: 56.258793, longitude: 34.333389),
      ParkPoint(name: 'Архитектурно-этнографический музей Василёво', latitude: 57.097736, longitude: 34.971522),
      // Ярославская область
      ParkPoint(name: 'Ярославский музей-заповедник', latitude: 57.630078, longitude: 39.895167),
      ParkPoint(name: 'Нефтяник', latitude: 57.583245, longitude: 39.848711),
      ParkPoint(name: 'Даманский парк', latitude: 57.618402, longitude: 39.899573),
      ParkPoint(name: 'Парк 1000-летия Ярославля', latitude: 57.617275, longitude: 39.871435),
      ParkPoint(name: 'Парк Стрелка', latitude: 57.618611, longitude: 39.904638),
      ParkPoint(name: 'Набережная р. Волги', latitude: 57.622598, longitude: 39.903585),
      ParkPoint(name: 'Парк динозавров Тайны Мира', latitude: 57.638381, longitude: 39.868857),
      ParkPoint(name: 'Первомайский бульвар', latitude: 57.629644, longitude: 39.886502),
      ParkPoint(name: 'Павловская роща', latitude: 57.693352, longitude: 39.811196),
      ParkPoint(name: 'Петропавловский парк', latitude: 57.602485, longitude: 39.843225),
      ParkPoint(name: 'Карякинский сад', latitude: 58.044912, longitude: 38.836015),
      ParkPoint(name: 'Волжский парк', latitude: 58.054843, longitude: 38.836530),
      ParkPoint(name: 'Городской сквер', latitude: 58.044157, longitude: 38.850728),
      ParkPoint(name: 'Угличский кремль', latitude: 57.528446, longitude: 38.317633),
      ParkPoint(name: 'Парк Победы', latitude: 57.528115, longitude: 38.321159),
      ParkPoint(name: 'Ростовский кремль', latitude: 57.184438, longitude: 39.415193),
      ParkPoint(name: 'Городской сад', latitude: 57.185701, longitude: 39.425190),
      ParkPoint(name: 'Митрополичий сад', latitude: 57.183695, longitude: 39.416635),
      ParkPoint(name: 'Музей Рождение Сказки', latitude: 56.561126, longitude: 38.580521),
      ParkPoint(name: 'Переславский музей-заповедник', latitude: 56.721597, longitude: 38.824697),
      ParkPoint(name: 'Русский парк', latitude: 56.711133, longitude: 38.802436),
      ParkPoint(name: 'литературно-мемориальный музей-заповедник Н.А. Некрасова Карабиха', latitude: 57.509197, longitude: 39.756777),
      ParkPoint(name: 'Историко-культурный комплекс Вятское', latitude: 57.863658, longitude: 40.267809),
      ParkPoint(name: 'Переславский железнодорожный музей', latitude: 56.802627, longitude: 38.647902),
      ParkPoint(name: 'Музей Александра Невского', latitude: 56.720250, longitude: 38.825506),
      ParkPoint(name: 'Центр сохранения и развития народных традиций Дом Берендея', latitude: 56.748718, longitude: 38.860948),
      ParkPoint(name: 'Музей ретро техники Старый гараж', latitude: 57.787020, longitude: 38.452858),
      ParkPoint(name: 'Ярославский зоопарк', latitude: 57.677254, longitude: 39.899863),
      ParkPoint(name: 'Переславский дендрологический сад имени С. Ф. Харитонова', latitude: 56.718205, longitude: 38.829315),
      // Костромская область
      ParkPoint(name: 'Костромская слобода', latitude: 57.775402, longitude: 40.889537),
      ParkPoint(name: 'парк Берендеевка', latitude: 57.792929, longitude: 40.959878),
      ParkPoint(name: 'парк Победы', latitude: 57.732793, longitude: 40.992504),
      ParkPoint(name: 'Парк культуры и отдыха им. В.И. Ленина', latitude: 57.764125, longitude: 40.928335),
      ParkPoint(name: 'Костромской зоопарк', latitude: 57.800316, longitude: 40.953553),
      // Ивановская область
      ParkPoint(name: 'Музей пожарной техники', latitude: 56.964371, longitude: 40.999968),
      ParkPoint(name: 'Парк Харинка', latitude: 56.968981, longitude: 41.058506),
      ParkPoint(name: 'Серебряный парк', latitude: 57.005073, longitude: 40.988532),
      ParkPoint(name: 'Парк культуры и отдыха имени Революции 1905 года', latitude: 57.029602, longitude: 41.003927),
      ParkPoint(name: 'Плёсский государственный историко-архитектурный и художественный музей-заповедник', latitude: 57.458744, longitude: 41.514018),
      ParkPoint(name: 'Парк Плёс', latitude: 57.454599, longitude: 41.502015),
      // Владимирская область
      ParkPoint(name: 'Национальный парк Мещёра', latitude: 55.634348, longitude: 40.689810),
      ParkPoint(name: 'парк имени 50-летия Советской власти', latitude: 55.578096, longitude: 42.022630),
      ParkPoint(name: 'Парк имени В.А. Дегтярёва', latitude: 56.358697, longitude: 41.325848),
      ParkPoint(name: 'Ковровский историко-мемориальный парк Иоанно-Воинский некрополь', latitude: 56.375464, longitude: 41.303430),
      ParkPoint(name: 'Музейный комплекс Спасо-Евфимиев монастырь', latitude: 56.433238, longitude: 40.440025),
      ParkPoint(name: 'Суздальский Кремль', latitude: 56.415948, longitude: 40.442851),
      ParkPoint(name: 'Александровская Слобода', latitude: 56.400607, longitude: 38.740469),
      ParkPoint(name: 'Юрьевский Кремль', latitude: 56.497888, longitude: 39.681595),
      ParkPoint(name: 'Парк Липки', latitude: 56.129431, longitude: 40.408525),
      ParkPoint(name: 'Ильинский луг', latitude: 56.419255, longitude: 40.428260),
      // СКФО
      // Ставропольский край
      ParkPoint(name: 'Археологический природный музей-заповедник Татарское Городище', latitude: 44.979635, longitude: 41.942739),
      ParkPoint(name: 'Парк Культуры и Отдыха Центральный', latitude: 45.043756, longitude: 41.976442),
      ParkPoint(name: 'Парк Победы', latitude: 45.022886, longitude: 41.924389),
      ParkPoint(name: 'парк Патриот', latitude: 45.024806, longitude: 41.896981),
      ParkPoint(name: 'Архиерейский лес', latitude: 45.046647, longitude: 41.955185),
      ParkPoint(name: 'Ставропольский ботанический сад', latitude: 45.036248, longitude: 41.907881),
      ParkPoint(name: 'парк Борцов революции', latitude: 44.782349, longitude: 44.153745),
      ParkPoint(name: 'парк имени Ю.А. Гагарина', latitude: 44.773624, longitude: 44.156694),
      ParkPoint(name: 'Парк Кирова', latitude: 44.033128, longitude: 43.061985),
      ParkPoint(name: 'Парк Победы', latitude: 44.035693, longitude: 43.008685),
      ParkPoint(name: 'Емануелевский парк', latitude: 44.041186, longitude: 43.083070),
      ParkPoint(name: 'Провал', latitude: 44.046672, longitude: 43.098839),
      ParkPoint(name: 'Курортный парк', latitude: 43.894141, longitude: 42.725039),
      ParkPoint(name: 'Нижний парк', latitude: 43.896675, longitude: 42.719176),
      ParkPoint(name: 'Берёзовское ущелье', latitude: 43.884808, longitude: 42.698399),
      ParkPoint(name: 'Долина роз', latitude: 43.895481, longitude: 42.738632),
      ParkPoint(name: 'Фабричный парк', latitude: 44.614376, longitude: 41.920569),
      ParkPoint(name: 'Парк Победы', latitude: 44.622191, longitude: 41.977796),
      ParkPoint(name: 'Каскадная лестница', latitude: 43.898808, longitude: 42.727029),
      ParkPoint(name: 'Красные камни', latitude: 43.897412, longitude: 42.729012),
      ParkPoint(name: 'Национальный парк Кисловодский', latitude: 43.897461, longitude: 42.735017),
      ParkPoint(name: 'Парк Цветник', latitude: 44.036808, longitude: 43.081792),
      ParkPoint(name: 'Ессентукский курортный парк', latitude: 44.046423, longitude: 42.864104),
      ParkPoint(name: 'Курортный парк Железноводска', latitude: 44.140371, longitude: 43.032841),
      ParkPoint(name: 'Пещера летней мерзлоты', latitude: 44.156823, longitude: 43.030464),
      ParkPoint(name: 'Бештаугорский лес', latitude: 44.103568, longitude: 43.040970),
      ParkPoint(name: 'Парк Победы', latitude: 44.056413, longitude: 42.866587),
      ParkPoint(name: 'Бесстыжие Ванны', latitude: 44.040154, longitude: 43.093264),
      ParkPoint(name: 'Холодный родник', latitude: 45.039121, longitude: 41.924626),
      
    ];
  }
  /// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
  List<OutsidePoint> _getMapPointsO() {
    return const [
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

