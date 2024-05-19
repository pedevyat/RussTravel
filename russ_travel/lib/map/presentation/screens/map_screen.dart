import 'dart:async';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:connectivity/connectivity.dart';
import 'package:latlong2/latlong.dart';
import 'package:latlong2/latlong.dart' as ll;

import 'backend.dart';

import 'package:http/http.dart' as http;
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
import 'package:url_launcher/url_launcher.dart';

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;

  //var stringBox = await Hive.openBox<String>('museum');

  late final MapController _mapController;
  double _mapZoom = 0.0;
  late Future<List<Marker>> _markersFuture;

  @override
  void initState() {
    super.initState();
    _markersFuture = _getMarkers().then((value) => value as List<Marker>);
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: Colors.blue, // Устанавливаем желаемый цвет blue для подложки
            child: CupertinoSegmentedControl(
              selectedColor: Colors.blue,
              // Устанавливаем цвет выделенного сегмента
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
                      _markersFuture = _getMuseumMarkers(context) as Future<List<Marker>>;
                      break;
                    case 1:
                      _markersFuture = _getParkMarkers(context) as Future<List<Marker>>;
                      break;
                    case 2:
                      _markersFuture = _getOutsideMarkers(context) as Future<List<Marker>>;
                      break;
                    case 3:
                      _markersFuture = _getHotelMarkers(context) as Future<List<Marker>>;
                      break;
                  }
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Marker>>(
        future: _markersFuture,
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
            return FlutterMap(
              options: MapOptions(
                center: LatLng(50, 20), // Начальные координаты центра карты
                zoom: 3.0, // Начальный уровень масштабирования карты
                onPositionChanged: (position, _) {
                  setState(() {
                    _mapZoom = position.zoom!;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                SuperclusterLayer.immutable( // Replaces MarkerLayer
                  initialMarkers: snapshot.data!,
                  indexBuilder: IndexBuilders.rootIsolate,
                  builder: (context, position, markerCount, extraClusterData) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.purple,
                        ),
                        child: Center(
                          child: Text(
                            markerCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<dynamic> _getMarkers() async {
    switch (_currentIndex) {
      case 0:
        return _getMuseumMarkers(context);
      case 1:
        return _getParkMarkers(context);
      case 2:
        return _getOutsideMarkers(context);
      case 3:
        return _getHotelMarkers(context);
      default:
        return [];
    }
  }

  /*void _moveCameraToInitialPosition() async {
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
  }*/

  /*ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: placemarks,
      radius: 50,
      minZoom: 15,
      onClusterAdded: (self, cluster) async {
        // Здесь можно определить внешний вид кластера при добавлении на карту
        // Например, можно изменить иконку кластера
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1.0,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                // Ваша кастомная иконка для кластера
                image: BitmapDescriptor.fromBytes(
                  await ClusterPoints(cluster.size).getClusterIconBytes(),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        // Здесь определяется действие при нажатии на кластер
        // Например, можно увеличить масштаб карты и переместиться к центру кластера
        double sumLat = 0;
        double sumLng = 0;

        for (final marker in cluster.markers) {
          sumLat += marker.point!.latitude;
          sumLng += marker.point!.longitude;
        }

        final centerLat = sumLat / cluster.markers.length;
        final centerLng = sumLng / cluster.markers.length;

        await _mapController.move(
          LatLng(centerLat, centerLng),
          _mapController.zoom + 1,
        );
      },
    );
  }*/
}
/*
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

  }*/

Future<List<fm.Marker>> _getMuseumMarkers(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/museum_points.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<Marker> markers = [];
    var musbox = await Hive.openBox('museumBox');

    for (int i = 0; i < pointsData.length; i++) {
      final point = MuseumPoint.fromJson(pointsData[i]);
      point.id = i;
      markers.add(
        fm.Marker(
          anchorPos: fm.AnchorPos.align(fm.AnchorAlign.top),
          width: 30.0,
          height: 30.0,
          point: ll.LatLng(point.latitude, point.longitude),
          builder: (BuildContext context) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _ModalBodyViewM(point: point);
                },
              );
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              child: 
              Opacity(
		  opacity: (musbox.containsKey(point.id)) ? 0.3 : 1,
		  child: Image.asset('assets/museum.png'),
		),
            ),
          ),
        ),
      );
    }

    return markers;
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


Future<List<fm.Marker>> _getParkMarkers(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/park_points.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<fm.Marker> markers = [];
    var parksbox = await Hive.openBox('parkBox');

    for (int i = 0; i < pointsData.length; i++) {
      final point = ParkPoint.fromJson(pointsData[i]);
      point.id = i;
      markers.add(
        fm.Marker(
          anchorPos: fm.AnchorPos.align(fm.AnchorAlign.top),
          width: 30.0,
          height: 30.0,
          point: ll.LatLng(point.latitude, point.longitude),
          builder: (BuildContext context) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _ModalBodyViewP(point: point);
                },
              );
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              child:
              Opacity(
		  opacity: (parksbox.containsKey(point.id)) ? 0.3 : 1,
		  child: Image.asset('assets/trees.png'),
		),
            ),
          ),
        ),
      );
    }

    return markers;
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

Future<List<fm.Marker>> _getOutsideMarkers(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/out_points.json');
    List<dynamic> pointsData = json.decode(jsonString);
    List<fm.Marker> markers = [];
    var outbox = await Hive.openBox('outsideBox');

    for (int i = 0; i < pointsData.length; i++) {
      final point = OutsidePoint.fromJson(pointsData[i]);
      point.id = i;
      markers.add(
        fm.Marker(
          anchorPos: fm.AnchorPos.align(fm.AnchorAlign.top),
          width: 30.0,
          height: 30.0,
          point: ll.LatLng(point.latitude, point.longitude),
          builder: (BuildContext context) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _ModalBodyViewO(point: point);
                },
              );
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              child:
              Opacity(
		  opacity: (outbox.containsKey(point.id)) ? 0.3 : 1,
		  child: Image.asset('assets/binoculars.png'),
		),
            ),
          ),
        ),
      );
    }

    return markers;
  } catch (e) {
    throw Exception('Ошибка при загрузке данных: $e');
  }
}

Future<List<fm.Marker>> _getHotelMarkers(BuildContext context) async {
  try {
    final jsonString = await rootBundle.loadString('assets/hotels.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> pointsData = jsonData['elements'];
    List<fm.Marker> markers = [];

    for (int i = 0; i < pointsData.length; i++) {
      final point = HotelPoint.fromJson(pointsData[i]);
      //point.id = i;
      markers.add(
        fm.Marker(
          anchorPos: fm.AnchorPos.align(fm.AnchorAlign.top),
          width: 30.0,
          height: 30.0,
          point: ll.LatLng(point.latitude, point.longitude),
          builder: (BuildContext context) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _ModalBodyViewH(point: point);
                },
              );
            },
            child: Container(
              width: 20.0,
              height: 20.0,
              child: Image.asset('assets/bed_test.png'),
            ),
          ),
        ),
      );
    }

    return markers;
  } catch (e) {
    throw Exception('Error loading data: $e');
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
    return SingleChildScrollView(
      child: Padding(
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
                  var userData = await Hive.openBox('UserData');
                  bool isConnected = await checkInternetConnectivity();
                  if (userData.isEmpty)
                  {
                  	ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
				  content: Text("Необходимо авторизоваться или зарегистрировать новый аккаунт..."),
			      ),
			    );
                  }
                  else
                  {
		          if (isConnected)
		          {
				  if (box.containsKey(point.id))
				  {
				    final response = await http.post(
				      Uri.parse('https://russ-travel.onrender.com/delete-park?id=${point.id}&user_id=${int.parse(userData.getAt(0))}'),
				      headers: {
			      			'accept': 'application/json',
			    		},
				    );
				    if (response.statusCode == 200) box.delete(point.id);
				    else
				    {
				    	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
					),
				      );
				    }
				    ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Достопримечательность ${point.name} помечена как ещё не посещённая!"),
					),
				      );
				  }
				  else
				  {
				    final response = await http.post(
				      Uri.parse('https://russ-travel.onrender.com/add-park'),
				      headers: {
			      			'accept': 'application/json',
			      			'Content-Type': 'application/json',
			    		},
			    	      body: '{"id": ${point.id}, "user_id": ${int.parse(userData.getAt(0))}, "title": "${point.name}"}',
				    );
				    if (response.statusCode == 200) box.put(point.id, point.id);
				    else
				    {
				    	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
					),
				      );
				    }
				    ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Достопримечательность ${point.name} помечена как посещённая!"),
					),
				      );
				  }
			  }
			  else 
		          {
		          	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
				      ),
				    );
		          }
                  }
		  Navigator.pop(context);
                },
              ),
            ),
            Image.network(
              point.photoUrl,
              width: 200,
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
      ),
    );
  }
}


class _ModalBodyViewM extends StatelessWidget {
  const _ModalBodyViewM({required this.point});

  final MuseumPoint point;

  //final BuildContext context;

  @override
  Widget build(BuildContext context) {
    // Запретить переворот экрана
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.star),
                onPressed: () async {
                  var box = await Hive.openBox('museumBox');
                  var userData = await Hive.openBox('UserData');
                  bool isConnected = await checkInternetConnectivity();
                  if (userData.isEmpty)
                  {
                  	ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
				  content: Text("Необходимо авторизоваться или зарегистрировать новый аккаунт..."),
			      ),
			    );
                  }
                  else
                  {
		          if (isConnected)
		          {
				  if (box.containsKey(point.id))
				  {
				    final response = await http.post(
				      Uri.parse('https://russ-travel.onrender.com/delete-museum?id=${point.id}&user_id=${int.parse(userData.getAt(0))}'),
				      headers: {
			      			'accept': 'application/json',
			    		},
				    );
				    if (response.statusCode == 200) box.delete(point.id);
				    else
				    {
				    	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
					),
				      );
				    }
				    ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Достопримечательность ${point.name} помечена как ещё не посещённая!"),
					),
				      );
				  }
				  else
				  {
				    final response = await http.post(
				      Uri.parse('https://russ-travel.onrender.com/add-museum'),
				      headers: {
			      			'accept': 'application/json',
			      			'Content-Type': 'application/json',
			    		},
			    	      body: '{"id": ${point.id}, "user_id": ${int.parse(userData.getAt(0))}, "title": "${point.name}"}',
				    );
				    if (response.statusCode == 200) box.put(point.id, point.id);
				    else
				    {
				    	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
					),
				      );
				    }
				    ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Достопримечательность ${point.name} помечена как посещённая!"),
				      ),
				    );
				  }
		          }
		          else 
		          {
		          	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
				      ),
				    );
		          }
		}
                  Navigator.pop(context);
                },
              ),
            ),
            Image.network(
              point.photoUrl,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
    
    //print("Point ID : " + point.id);

    return SingleChildScrollView(
      child: Padding(
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
                  var userData = await Hive.openBox('UserData');
                  bool isConnected = await checkInternetConnectivity();
                  if (userData.isEmpty)
                  {
                  	ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
				  content: Text("Необходимо авторизоваться или зарегистрировать новый аккаунт..."),
			      ),
			    );
                  }
                  else
                  {
		          if (isConnected)
		          {
				  if (box.containsKey(point.id))
				  {
				    final response = await http.post(
				      Uri.parse('https://russ-travel.onrender.com/delete-out?id=${point.id}&user_id=${int.parse(userData.getAt(0))}'),
				      headers: {
			      			'accept': 'application/json',
			    		},
				    );
				    if (response.statusCode == 200) box.delete(point.id);
				    else
				    {
				    	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
					),
				      );
				    }
				    ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Достопримечательность ${point.name} помечена как ещё не посещённая!"),
					),
				      );
		          }
		          else
		          {
		            final response = await http.post(
			      Uri.parse('https://russ-travel.onrender.com/add-out'),
			      headers: {
		      			'accept': 'application/json',
		      			'Content-Type': 'application/json',
		    		},
		    	      body: '{"id": ${point.id}, "user_id": ${int.parse(userData.getAt(0))}, "title": "${point.name}"}',
			    );
			    if (response.statusCode == 200) box.put(point.id, point.id);
			    else
			    {
			    	ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
				  content: Text("Проблемы с подключением к сети..."),
				),
			      );
			    }
		            ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
				  content: Text("Достопримечательность ${point.name} помечена как посещённая!"),
				),
			      );
		          }
		          }
			  else 
		          {
		          	ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
					  content: Text("Проблемы с подключением к сети..."),
				      ),
				    );
		          }
		}
                  Navigator.pop(context);
                },
              ),
            ),
            Image.network(
              point.photoUrl,
              width: 200,
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
            'Цена за сутки: от ${point.price} руб.',
            style: const TextStyle(
              fontSize: 16,
            )
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            _launchURL(point.url);
          },
          child: Text(
            '${point.url}',
            style: TextStyle(
              color: Colors.blue, // Цвет ссылки
              decoration: TextDecoration.underline, // Подчеркивание ссылки
            ),
          ),
        ),

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

  // Функция для открытия ссылки
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
