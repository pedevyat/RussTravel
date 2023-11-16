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

