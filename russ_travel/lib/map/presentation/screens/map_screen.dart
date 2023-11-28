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
      MuseumPoint(name: 'Мавзолей В.И. Ленина', // Название точки
          latitude: 55.753605, // Координаты
          longitude: 37.619773),
      MuseumPoint(name: 'Ростовский музей космонавтики', // Название точки
          latitude: 47.211245, // Координаты
          longitude: 39.619703),
      MuseumPoint(name: 'Ростовский областной музей изобразительных искусств', // Название точки
          latitude: 47.225709, // Координаты
          longitude: 39.715807),
      MuseumPoint(name: 'Музей железнодорожной техники Северо-Кавказской железной дороги', // Название точки
          latitude: 47.190481, // Координаты
          longitude: 39.636225),
      MuseumPoint(name: 'Археологический музей-заповедник «Танаис»', // Название точки
          latitude: 47.269111, // Координаты
          longitude: 39.334555),
      MuseumPoint(name: 'Новочеркасский музей истории Донского казачества', // Название точки
          latitude: 47.412306, // Координаты
          longitude: 40.104314),
      MuseumPoint(name: 'Аксайский военно-исторический музей', // Название точки
          latitude: 47.271300, // Координаты
          longitude: 39.891289),
      MuseumPoint(name: 'Волгодонский музей истории донской народной культуры «Казачий курень»', // Название точки
          latitude: 47.496935, // Координаты
          longitude: 42.185392),
      MuseumPoint(name: 'Усадьба-музей М. А. Шолохова в станице Вёшенской', // Название точки
          latitude: 49.626463, // Координаты
          longitude: 41.728758),
      MuseumPoint(name: 'Азовский историко-археологический и палеонтологический музей-заповедник', // Название точки
          latitude: 47.111707, // Координаты
          longitude: 39.423549),
      MuseumPoint(name: 'Музей «Лавка Чеховых» в Таганроге', // Название точки
          latitude: 47.215958, // Координаты
          longitude: 38.918060),
      MuseumPoint(name: 'Новочеркасский Атаманский дворец-музей', // Название точки
          latitude: 47.409413, // Координаты
          longitude: 40.101561),
      MuseumPoint(name: 'Старочеркасский музей-заповедник', // Название точки
          latitude: 47.237337, // Координаты
          longitude: 40.039041),
      MuseumPoint(name: 'Донская государственная публичная библиотека', // Название точки
          latitude: 47.228934, // Координаты
          longitude: 39.726761),
      MuseumPoint(name: 'Ливенцовская крепость', // Название точки
          latitude: 47.223240, // Координаты
          longitude: 39.559134),
      MuseumPoint(name: 'Домик Чехова в Таганроге', // Название точки
          latitude: 47.206864, // Координаты
          longitude: 38.931255),
      MuseumPoint(name: 'Парамоновские склады', // Название точки
          latitude: 47.218429, // Координаты
          longitude: 39.727050),
    ];
  }
  /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  List<ParkPoint> _getMapPointsP() {
    return const [
      ParkPoint(
          name: 'Парк Зарядье', latitude: 55.751238, longitude: 37.627762),
      ParkPoint(
          name: 'Гинкго Парк', latitude: 47.401337, longitude: 40.071135),
      ParkPoint(
          name: 'Парк «Малинки»', latitude: 47.745672, longitude: 40.088963),
      ParkPoint(
          name: 'Этно-археологический комплекс «Затерянный Мир»', latitude: 47.518159, longitude: 40.610807),
      ParkPoint(
          name: 'Парк Лога в хуторе Старая Станица', latitude: 48.351304, longitude: 40.295224),
      ParkPoint(
          name: 'Самбекские высоты', latitude: 47.317856, longitude: 39.012731),
      ParkPoint(
          name: 'Набережная Ростова-на-Дону', latitude: 47.217242, longitude: 39.726807),
      ParkPoint(
          name: 'Ботанический сад ЮФУ', latitude: 47.231051, longitude: 39.659632),
      ParkPoint(
          name: 'Мемориальный комплекс «Кумженская роща»', latitude: 47.185104, longitude: 39.618411),
      ParkPoint(
          name: 'Заповедник «Золотые горки»', latitude: 47.441969, longitude: 40.390649),
      ParkPoint(
          name: 'Природный парк Цимлянские пески', latitude: 48.169465, longitude: 42.676384),
    ];
  }
  /// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
  List<OutsidePoint> _getMapPointsO() {
    return const [
      OutsidePoint(
          name: 'Останкинская башня', latitude: 55.819721,  longitude: 37.611704),
      OutsidePoint(
          name: 'Маяк в Мержаново', latitude: 47.287558,  longitude: 39.155729),
      OutsidePoint(
          name: 'Длинный Каньон или озеро Эльдорадо', latitude: 48.229026,  longitude: 40.349915),
      OutsidePoint(
          name: 'Колесо обозрения «Одно небо»', latitude: 47.229193,  longitude: 39.743147),
      OutsidePoint(
          name: 'Горы Две Сестры в Белой Калитве', latitude: 48.120806,  longitude: 39.743147),
      OutsidePoint(
          name: 'Озеро Маныч-Гудило', latitude: 46.297787,  longitude: 42.840934),
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

