import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/hotel_point.dart';
import 'clusters_collection.dart';

class HotelMapScreen extends StatefulWidget {
  const HotelMapScreen({Key? key}) : super(key: key);

  @override
  State<HotelMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<HotelMapScreen> {
  late final YandexMapController _mapController;
  double _mapZoom = 0.0;
  late Future<List<PlacemarkMapObject>> _placemarkObjectsFuture;

  @override
  void initState() {
    super.initState();
    _placemarkObjectsFuture = _combinePlacemarkObjects(context);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта отелей')),
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

Future<List<PlacemarkMapObject>> _combinePlacemarkObjects(BuildContext context) {
  return _getPlacemarkObjects(context).catchError((e) {
    throw Exception('Ошибка при объединении данных: $e');
  });
}

Future<List<PlacemarkMapObject>> _getPlacemarkObjects(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/hotels.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> pointsData = jsonData['elements'];
    return pointsData.map((data) {
      final point = HotelPoint.fromJson(data);
      return PlacemarkMapObject(
        mapId: MapObjectId('MapObject $point'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/museum.png'),
            scale: 0.15,
          ),
        ),
        onTap: (_, __) => showModalBottomSheet(
          context: context,
          builder: (context) => _ModalBodyView(
            point: point,
          ),
        ),
      );
    }).toList();
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}


class _ModalBodyView extends StatelessWidget {
  const _ModalBodyView({required this.point});


  final HotelPoint point;


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

