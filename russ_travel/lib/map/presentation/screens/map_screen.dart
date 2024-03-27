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
import 'map_point.dart';

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
     appBar: AppBar(title: const Text('Yandex Mapkit Demo')),
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
       mapObjects: _getPlacemarkObjects(context),
     ),
   );
 }
}

/// Метод для генерации точек на карте
List<MapPoint> _getMapPoints() {
 return const [
   MapPoint(name: 'Москва', latitude: 55.755864, longitude: 37.617698),
   MapPoint(name: 'Лондон', latitude: 51.507351, longitude: -0.127696),
   MapPoint(name: 'Рим', latitude: 41.887064, longitude: 12.504809),
   MapPoint(name: 'Париж', latitude: 48.856663, longitude: 2.351556),
   MapPoint(name: 'Стокгольм', latitude: 59.347360, longitude: 18.341573),
 ];
}

/// Метод для генерации объектов маркеров для отображения на карте
List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
	List<MapPoint> listMapPoints = _getMapPoints();
	List<PlacemarkMapObject> listPlacemarkMapObjects = [];
	for (int i = 0; i < listMapPoints.length; i++)
	{
		listPlacemarkMapObjects.add(PlacemarkMapObject(
         mapId: MapObjectId('MapObject $i'),
         point: Point(latitude: listMapPoints[i].latitude, longitude: listMapPoints[i].longitude),
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
           builder: (context) => _ModalBodyView(
             point: listMapPoints[i],
           ),
         ),
       ));
	}
	return listPlacemarkMapObjects;
}

class _ModalBodyView extends StatelessWidget {
 const _ModalBodyView({required this.point});


 final MapPoint point;


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
