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

