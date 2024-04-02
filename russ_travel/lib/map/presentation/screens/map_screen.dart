import 'dart:async';
import 'dart:convert';
import 'backend.dart';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:russ_travel/map/domain/app_latitude_longitude.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/location_service.dart';
import '../../domain/museum_point.dart';
import '../../domain/outside_point.dart';
import '../../domain/park_point.dart';
import '../../domain/hotel_point.dart';
import 'clusters_collection.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
  //var stringBox = await Hive.openBox<String>('museum');
  
  late final YandexMapController _mapController;
  double _mapZoom = 0.0;
  late Future<List<PlacemarkMapObject>> _placemarkObjectsFuture;

  @override
  void initState() {
    super.initState();
    _placemarkObjectsFuture = _museumPlacemarkObjects(context);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      	  title: const Text('Карта открытий'),
      	  bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,  // Устанавливаем желаемый цвет blue для подложки
          child: CupertinoSegmentedControl(
            selectedColor: Colors.blue,  // Устанавливаем цвет выделенного сегмента
            children: {
              0: Text('Музеи'),
              1: Text('Парки'),
              2: Text('Смотровые'),
              3: Text('Отели'),
            },
            onValueChanged: (value) {
              setState(() {
                _currentIndex = value;
                switch (value) {
                  case 0:
                    _placemarkObjectsFuture = _museumPlacemarkObjects(context);
                    break;
                  case 1:
                    _placemarkObjectsFuture = _parksPlacemarkObjects(context);
                    break;
                  case 2:
                    _placemarkObjectsFuture = _outPlacemarkObjects(context);
                    break;
                  case 3:
                    _placemarkObjectsFuture = _hotelsPlacemarkObjects(context);
                    break;
                }
              });
            },
          ),
        ),
      ),
    ),
      body: FutureBuilder<List<PlacemarkMapObject>>(
        future: _placemarkObjectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 50.0,
              ),
            );
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

Future<List<PlacemarkMapObject>> _combinePlacemarkObjects(BuildContext context) async {
  List<PlacemarkMapObject> combinedPlacemarkObjects = [];
  try {
    //List<PlacemarkMapObject> placemarkObjectsM = await _getPlacemarkObjectsM(context);
    //List<PlacemarkMapObject> placemarkObjectsO = await _getPlacemarkObjectsO(context);
    List<PlacemarkMapObject> placemarkObjectsP = await _getPlacemarkObjectsP(context);
    //combinedPlacemarkObjects.addAll(placemarkObjectsM);
    //combinedPlacemarkObjects.addAll(placemarkObjectsO);
    combinedPlacemarkObjects.addAll(placemarkObjectsP);
  } catch (e) {
    throw Exception('Ошибка при объединении данных: $e');
  }
  return combinedPlacemarkObjects;
}

Future<List<PlacemarkMapObject>> _hotelsPlacemarkObjects(BuildContext context) async {
  List<PlacemarkMapObject> combinedPlacemarkObjects = [];
  try {
    List<PlacemarkMapObject> placemarkObjectsH = await _getPlacemarkObjectsH(context);
    combinedPlacemarkObjects.addAll(placemarkObjectsH);
  } catch (e) {
    throw Exception('Ошибка при объединении данных: $e');
  }
  return combinedPlacemarkObjects;
}

Future<List<PlacemarkMapObject>> _museumPlacemarkObjects(BuildContext context) async {
  List<PlacemarkMapObject> combinedPlacemarkObjects = [];
  try {
    List<PlacemarkMapObject> placemarkObjectsM = await _getPlacemarkObjectsM(context);
    combinedPlacemarkObjects.addAll(placemarkObjectsM);
  } catch (e) {
    throw Exception('Ошибка при объединении данных: $e');
  }
  return combinedPlacemarkObjects;
}

Future<List<PlacemarkMapObject>> _outPlacemarkObjects(BuildContext context) async {
  List<PlacemarkMapObject> combinedPlacemarkObjects = [];
  try {
    List<PlacemarkMapObject> placemarkObjectsO = await _getPlacemarkObjectsO(context);
    combinedPlacemarkObjects.addAll(placemarkObjectsO);
  } catch (e) {
    throw Exception('Ошибка при объединении данных: $e');
  }
  return combinedPlacemarkObjects;
}

Future<List<PlacemarkMapObject>> _parksPlacemarkObjects(BuildContext context) async {
  List<PlacemarkMapObject> combinedPlacemarkObjects = [];
  try {
    List<PlacemarkMapObject> placemarkObjectsP = await _getPlacemarkObjectsP(context);
    combinedPlacemarkObjects.addAll(placemarkObjectsP);
    //Navigator.of(context).pop();
    return combinedPlacemarkObjects;
  } catch (e) {
    //Navigator.of(context).pop();
    throw Exception('Ошибка при объединении данных: $e');
  }

  }

Future<List<PlacemarkMapObject>> _getPlacemarkObjectsM(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/museum_points_test.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<PlacemarkMapObject> listPlacemarkMapObject = [];
    var box = await Hive.openBox('museumBox');
    
    for (int i = 0; i < pointsData.length; i++)
    {
    	final point = MuseumPoint.fromJson(pointsData[i]);
    	point.id = i;
    	listPlacemarkMapObject.add(
	    PlacemarkMapObject(
		mapId: MapObjectId('MuseumObject $i'),
		point: Point(latitude: point.latitude, longitude: point.longitude),
		opacity: !box.containsKey(i) ? 1 : 0.25,
		icon: PlacemarkIcon.single(
		  PlacemarkIconStyle(
		    image: BitmapDescriptor.fromAssetImage('assets/museum.png'),
		    scale: 0.15,
		  ),
		),
		onTap: (_, __) => showModalBottomSheet(
		  context: context,
		  builder: (context) => _ModalBodyViewM(
		    point: point,
		  ),
		),
	      )
        );
    }
    
    return listPlacemarkMapObject;
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

/*
Future<List<PlacemarkMapObject>> _getPlacemarkObjectsM(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/museum_points.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<PlacemarkMapObject> listPlacemarkMapObject = [];
    
    for (int i = 0; i < pointsData.length; i++)
    {
    	final point = MuseumPoint.fromJson(pointsData[i]);
    	listPlacemarkMapObject.add(
	    	PlacemarkMapObject(
		mapId: MapObjectId('MuseumObject $i'),
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
		  builder: (context) => _ModalBodyViewM(
		    point: point,
		  ),
		),
	      )
      );    
    }
    
    return listPlacemarkMapObject;
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}
*/


Future<List<PlacemarkMapObject>> _getPlacemarkObjectsO(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/out_points_test.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<PlacemarkMapObject> listPlacemarkMapObject = [];
    var box = await Hive.openBox('outsideBox');
    
    for (int i = 0; i < pointsData.length; i++)
    {
    	final point = OutsidePoint.fromJson(pointsData[i]);
    	point.id = i;
    	listPlacemarkMapObject.add(
	    PlacemarkMapObject(
		mapId: MapObjectId('OutsideObject $i'),
		point: Point(latitude: point.latitude, longitude: point.longitude),
		opacity: !box.containsKey(i) ? 1 : 0.25,
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
	      )
        );
    }
    
    return listPlacemarkMapObject;
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

Future<List<PlacemarkMapObject>> _getPlacemarkObjectsP(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/park_points_test.json');
    final List<dynamic> pointsData = json.decode(jsonString);
    List<PlacemarkMapObject> listPlacemarkMapObject = [];
    var box = await Hive.openBox('parkBox');
    
    for (int i = 0; i < pointsData.length; i++)
    {
    	final point = ParkPoint.fromJson(pointsData[i]);
    	point.id = i;
    	listPlacemarkMapObject.add(
	    	PlacemarkMapObject(
		mapId: MapObjectId('ParkObject $i'),
		point: Point(latitude: point.latitude, longitude: point.longitude),
		opacity: !box.containsKey(i) ? 1 : 0.25,
		icon: PlacemarkIcon.single(
		  PlacemarkIconStyle(
		    image: BitmapDescriptor.fromAssetImage('assets/trees.png'),
		    scale: 0.15,
		  ),
		),
		onTap: (_, __) => showModalBottomSheet(
		  context: context,
		  builder: (context) => _ModalBodyViewP(
		    point: point,
		  ),
		),
	      )
    	);
    }
    return listPlacemarkMapObject;
  }
  catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

Future<List<PlacemarkMapObject>> _getPlacemarkObjectsH(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/hotels.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> pointsData = jsonData['elements'];
    List<PlacemarkMapObject> listPlacemarkMapObject = [];
    
    for (int i = 0; i < pointsData.length; i++)
    {
    	final point = HotelPoint.fromJson(pointsData[i]);
    	listPlacemarkMapObject.add(PlacemarkMapObject(
        mapId: MapObjectId('HotelPoint $i'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/bed_test.png'),
            scale: 0.15,
          ),
        ),
        onTap: (_, __) => showModalBottomSheet(
          context: context,
          builder: (context) => _ModalBodyViewH(
            point: point,
          ),
        ),
      )
      );
      
    }
    
    return listPlacemarkMapObject;
    
    return pointsData.map((data) {
      final point = HotelPoint.fromJson(data);
      return PlacemarkMapObject(
        mapId: MapObjectId('MapObject $point'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/bed_test.png'),
            scale: 0.15,
          ),
        ),
        onTap: (_, __) => showModalBottomSheet(
          context: context,
          builder: (context) => _ModalBodyViewH(
            point: point,
          ),
        ),
      );
    }).toList();
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}


/// Содержимое модального окна с информацией о точке на карте
class _ModalBodyViewP extends StatelessWidget {
  const _ModalBodyViewP({required this.point});


  final ParkPoint point;


  @override
  Widget build(BuildContext context) {
    // Запретить переворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        	Align(
		  alignment: Alignment.topRight,
		  child: IconButton(
		    icon: Icon(Icons.star),
		    onPressed: () async {
		      var box = await Hive.openBox('parkBox');
		      if (box.containsKey(point.id))
		        box.delete(point.id);
		      else
		        box.put(point.id, point.id);
		      //point.isVisited = !point.isVisited;
		    },
		  ),
		),
          Image.network(
            point.photoUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover, // Режим заполнения изображения
          ),
          const SizedBox(height: 20),
          Text(point.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            '${point.latitude}, ${point.longitude}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalBodyViewM extends StatelessWidget {
  const _ModalBodyViewM({required this.point});

  final MuseumPoint point;

  @override
  Widget build(BuildContext context) {
    // Запретить переворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.star),
              onPressed: () async {
                var box = await Hive.openBox('museumBox');
                if (box.containsKey(point.id))
                  box.delete(point.id);
                else
                  box.put(point.id, point.id);
                //point.isVisited = !point.isVisited;
              },
            ),
          ),
          Image.network(
            point.photoUrl,
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(point.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            '${point.latitude}, ${point.longitude}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalBodyViewO extends StatelessWidget {
  const _ModalBodyViewO({required this.point});


  final OutsidePoint point;
  @override
  Widget build(BuildContext context) {
    // Запретить переворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
		  alignment: Alignment.topRight,
		  child: IconButton(
		    icon: Icon(Icons.star),
		    onPressed: () async {
		      var box = await Hive.openBox('outsideBox');
		      if (box.containsKey(point.id))
		        box.delete(point.id);
		      else
		        box.put(point.id, point.id);
		      //point.isVisited = !point.isVisited;
		    },
		  ),
		),
          Image.network(
            point.photoUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover, // Режим заполнения изображения
          ),
          const SizedBox(height: 20),
          Text(point.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            '${point.latitude}, ${point.longitude}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalBodyViewH extends StatelessWidget {
  const _ModalBodyViewH({required this.point});


  final HotelPoint point;


  @override
  Widget build(BuildContext context) {
    // Запретить переворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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

