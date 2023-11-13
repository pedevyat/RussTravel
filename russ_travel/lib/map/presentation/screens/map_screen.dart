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
  List<MuseumPoint> _getMapPointsM() {
    return const [
      MuseumPoint(name: 'Мавзолей В.И. Ленина',
          latitude: 55.753605,
          longitude: 37.619773),
    ];
  }

  List<ParkPoint> _getMapPointsP() {
    return const [
      ParkPoint(
          name: 'Парк Зарядье', latitude: 55.751238, longitude: 37.627762),
    ];
  }

  List<OutsidePoint> _getMapPointsO() {
    return const [
      OutsidePoint(name: 'Останкинская башня',
          latitude: 55.819721,
          longitude: 37.611704),
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

