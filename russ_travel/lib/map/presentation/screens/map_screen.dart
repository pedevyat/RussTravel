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
      // Казань
      MuseumPoint(name: 'Национальный музей Республики Татарстан',
          latitude: 55.795712,
          longitude: 49.109801),
      MuseumPoint(name: 'Музей Социалистического Быта',
          latitude: 55.787088,
          longitude: 49.119781),
      MuseumPoint(name: 'Музей Чак-Чака',
          latitude: 55.782046,
          longitude: 49.112496),
      MuseumPoint(name: 'Музей Константина Васильева',
          latitude: 55.790069,
          longitude: 49.116646),
      MuseumPoint(name: 'Музей иллюзий',
          latitude: 55.791638,
          longitude: 49.113556),
      MuseumPoint(name: 'Дом-Музей Василия Аксенова',
          latitude: 55.795444,
          longitude: 49.135196),
      MuseumPoint(name: 'Литературно-мемориальный музей А.М. Горького',
          latitude: 55.793505,
          longitude: 49.129653),
      MuseumPoint(name: 'Музей чая',
          latitude: 55.781008,
          longitude: 49.115685),
      MuseumPoint(name: 'Музей Е. А. Боратынского, филиал Национального музея Республики Татарстан',
          latitude: 55.79387,
          longitude: 49.135421),
      MuseumPoint(name: 'Музей оружия Дух Воина',
          latitude: 55.798768,
          longitude: 49.106171),
      MuseumPoint(name: 'Музей-квартира Мусы Джалиля',
          latitude: 55.794072,
          longitude: 49.132214),
      MuseumPoint(name: 'Музей "Городская панорама"',
          latitude: 55.796273,
          longitude: 49.114247),
      MuseumPoint(name: 'Дом-музей В.И. Ленина',
          latitude: 55.786915,
          longitude: 49.138807),
      MuseumPoint(name: 'Государственный музей изобразительных искусств Республики Татарстан',
          latitude: 55.794953,
          longitude: 49.134909),
      
      // Самара
      MuseumPoint(name: 'Самарский областной историко-краеведческий музей им. П.В. Алабина',
          latitude: 53.192765,
          longitude: 50.10906),
      MuseumPoint(name: 'Музей модерна',
          latitude: 53.194238,
          longitude: 50.096214),
      MuseumPoint(name: 'Музей-усадьба А. Толстого. Самарский литературно-мемориальный музей им. М. Горького. Музей Буратино',
          latitude: 53.193574,
          longitude: 50.095729),
      MuseumPoint(name: 'Дом-музей В.И.Ленина в г. Самаре',
          latitude: 53.193116,
          longitude: 50.11082),
      MuseumPoint(name: 'Дом-музей М.В. Фрунзе',
          latitude: 53.191546,
          longitude: 50.093752),
      MuseumPoint(name: 'Музей Эльдара Рязанова',
          latitude: 53.192695,
          longitude: 50.094507),
      MuseumPoint(name: 'Поволжский музей железнодорожной техники',
          latitude: 53.222897,
          longitude: 50.293232),
      MuseumPoint(name: 'Музей авиации и космонавтики имени С.П. Королёва Московское ш.',
          latitude: 53.195878,
          longitude: 50.100202),
      MuseumPoint(name: 'Самарский военно-исторический музей',
          latitude: 53.196682,
          longitude: 50.095261),
      MuseumPoint(name: 'Зоологический музей им. В.Н. Темнохолмова СГСПУ Antonova-Ovseyenko',
          latitude: 53.195658629268216,
          longitude: 50.09953186911404),
      MuseumPoint(name: 'Самарский областной художественный музей',
          latitude: 53.189431,
          longitude: 50.089845),  
      MuseumPoint(name: 'Музей лягушки',
          latitude: 53.179799,
          longitude: 50.075166),
      MuseumPoint(name: 'Военно-исторический музей ПУРВО Рабочая',
          latitude: 53.195878,
          longitude: 50.100202),
      MuseumPoint(name: 'Музей истории города Самары им. М.Д. Челышова',
          latitude: 53.18329,
          longitude: 50.088973),
      MuseumPoint(name: 'Самарский епархиальный церковно-исторический музей',
          latitude: 53.205803,
          longitude: 50.141372),
      MuseumPoint(name: 'Музей Археологии Поволжья',
          latitude: 53.192301,
          longitude: 50.110281),

      // Нижний Новгород
      MuseumPoint(name: 'Музей истории художественных промыслов Нижегородской Большая Покровская',
          latitude: 56.326797,
          longitude: 44.006516),
      MuseumPoint(name: 'Музей А.М.Горького',
          latitude: 56.325918,
          longitude: 44.026046),
      MuseumPoint(name: 'Государственный Русский музей фотографии',
          latitude: 56.323897,
          longitude: 44.003139),
      MuseumPoint(name: 'Технический музей Большая Покровская',
          latitude: 56.326797,
          longitude: 44.006516),
      MuseumPoint(name: 'Музей А. Д. Сахарова',
          latitude: 56.232419,
          longitude: 43.95056),
      MuseumPoint(name: 'Нижегородский государственный художественный музей (русская и советская живопись)',
          latitude: 56.329552,
          longitude: 44.0064),
      MuseumPoint(name: 'Музей речного флота',
          latitude: 56.327985,
          longitude: 44.015931),
      MuseumPoint(name: 'Музей старинной техники и инструментов',
          latitude: 56.318136,
          longitude: 43.995234),
      MuseumPoint(name: 'Нижегородский Городской Музей Техники И Оборонной Промышленности',
          latitude: 56.32482,
          longitude: 44.018716),
      MuseumPoint(name: 'Музей истории завода "Красное Сормово"',
          latitude: 56.359813,
          longitude: 43.870026),
      MuseumPoint(name: 'Музей Истории и Трудовой славы ГАЗ',
          latitude: 56.254727,
          longitude: 43.893176),
      
      //Уфа
      MuseumPoint(name: 'Музей истории города Уфы',
          latitude: 54.7336360735005,
          longitude: 55.951346541664044),
      MuseumPoint(name: 'Дом-музей В.И. Ленина',
          latitude: 54.732881,
          longitude: 55.953211),
      MuseumPoint(name: 'Республиканский историко-культурный музей-заповедник Древняя Уфа',
          latitude: 54.733974025182896,
          longitude: 55.9468867281723),
      MuseumPoint(name: 'Музей современного искусства имени Наиля Латфуллина',
          latitude: 54.73289755743139,
          longitude: 55.94484680489321),
      MuseumPoint(name: 'Музей истории Башкирской организации Всероссийского общества слепых городского округа город Уфа РБ',
          latitude: 54.72892141235827,
          longitude: 55.96444884854879),
      MuseumPoint(name: 'Музей истории органов безопасности управления ФСБ',
          latitude: 54.728530260538825,
          longitude: 55.94978438095095),
      MuseumPoint(name: 'Национальный литературный музей Республики Башкортостан',
          latitude: 54.728883,
          longitude: 55.976621),
      MuseumPoint(name: 'Музей Министерства внутренних дел по Республике Башкортостан',
          latitude: 54.726871,
          longitude: 55.950013),
      MuseumPoint(name: 'Музей Почты УФПС РБ, Почта России',
          latitude: 54.726418,
          longitude: 55.947938),
      MuseumPoint(name: 'Музей полярников имени В.И. Альбанова',
          latitude: 54.725758,
          longitude: 55.936853),
      MuseumPoint(name: 'Башкирский государственный художественный музей имени Михаила Васильевича Нестерова',
          latitude: 54.7245174812755,
          longitude: 55.93606949933623),
      MuseumPoint(name: 'Музей развития образования Республики Башкортостан',
          latitude: 54.72396760870022,
          longitude: 55.937245965606685),
      MuseumPoint(name: 'Мемориальный дом-музей Мажита Гафури',
          latitude: 54.722789,
          longitude: 55.936584),
      MuseumPoint(name: 'Музей археологии и этнографии Института этнологических исследований им. Р.Г. Кузеева',
          latitude: 54.721068,
          longitude: 55.939216),
      MuseumPoint(name: 'Зоологический музей Башкирского государственного университета',
          latitude: 54.72013821117435,
          longitude: 55.933894135075825),
      MuseumPoint(name: 'Музей Башкирского государственного театра оперы и балета',
          latitude: 54.722418853265495,
          longitude: 55.9453068657455),
      MuseumPoint(name: 'Национальный музей Республики Башкортостан',
          latitude: 54.72013389739121,
          longitude: 55.946777949073734),
      MuseumPoint(name: 'Дом-музей Ш. Худайбердина',
          latitude: 54.719368,
          longitude: 55.955825),
      MuseumPoint(name: 'Музей истории парламента Республики Башкортостан',
          latitude: 54.717792,
          longitude: 55.946339),
      MuseumPoint(name: 'Мемориальный дом-музей А.Э. Тюлькина',
          latitude: 54.714724,
          longitude: 55.945432),
      MuseumPoint(name: 'Дом-музей С.Т. Аксакова',
          latitude: 54.713455,
          longitude: 55.951603),
      
      // Пермь
      MuseumPoint(name: 'Музей Пермского отделения Свердловской железной дороги',
          latitude: 57.996482,
          longitude: 56.188732),
      MuseumPoint(name: 'Пермская государственная художественная галерея',
          latitude: 58.016414,
          longitude: 56.234689),
      MuseumPoint(name: 'Музей пермских древностей',
          latitude: 58.014126,
          longitude: 56.24546),
      MuseumPoint(name: 'ГБУК Пермского края Мемориальный музей-заповедник истории политических репрессий Пермь-36',
          latitude: 58.020128,
          longitude: 56.270874),
      
      // Саратов
      MuseumPoint(name: 'МУЗЕЙ ИСТОРИИ САРАТОВСКОЙ МИТРОПОЛИИ',
          latitude: 51.525679,
          longitude: 46.027295),
      MuseumPoint(name: 'Музей самоваров',
          latitude: 51.536996,
          longitude: 46.030852),
      MuseumPoint(name: 'Саратовский областной музей краеведения',
          latitude: 51.527567,
          longitude: 46.056023),
      MuseumPoint(name: 'Музей речного флота',
          latitude: 51.521095,
          longitude: 46.006301),
      MuseumPoint(name: 'Музей истории саратовской полиции',
          latitude: 51.5441676271089,
          longitude: 46.00809231349183),
      
      // Тольятти
      MuseumPoint(name: 'Тольяттинский краеведческий музей',
          latitude: 53.501935997704685,
          longitude: 49.42072019577029),
      MuseumPoint(name: 'Музей ОАО "АВТОВАЗ"',
          latitude: 53.552367,
          longitude: 49.272153),
      MuseumPoint(name: 'Тольяттинский художественный музей',
          latitude: 53.50314492328798,
          longitude: 49.420269589627814),
      MuseumPoint(name: 'Музей Тольяттинского Государственного Университета',
          latitude: 53.500665,
          longitude: 49.397908),
      
      // Ижевск
      MuseumPoint(name: 'Национальный Музей Удмуртской Республики',
          latitude: 56.842393,
          longitude: 53.228504),
      MuseumPoint(name: 'Музей Хлеба',
          latitude: 56.872826,
          longitude: 53.260026),
      MuseumPoint(name: 'Музей Ижевского Автомобильного Завода',
          latitude: 56.886263,
          longitude: 53.309631),
      MuseumPoint(name: 'Музей Ижевска',
          latitude: 56.84676,
          longitude: 53.19789),
      MuseumPoint(name: 'Музейно-выставочный комплекс стрелкового оружия им. М.Т. Калашникова',
          latitude: 56.850742,
          longitude: 53.20672),
      
      // Ульяновск
      MuseumPoint(name: 'Ульяновский областной краеведческий музей им. И.А. Гончарова',
          latitude: 54.315363,
          longitude: 48.405557),
      MuseumPoint(name: 'Литературный музей "Дом Языковых" ',
          latitude: 54.318341,
          longitude: 48.403482),
      MuseumPoint(name: 'Симбирская Классическая Гимназия Музей',
          latitude: 54.31609496725722,
          longitude: 48.40299244113913),
      MuseumPoint(name: 'Ульяновский областной художественный музей',
          latitude: 54.315363,
          longitude: 48.405557),
      
      //Набережные Челны
      MuseumPoint(name: 'Музей воды',
          latitude: 55.663116,
          longitude: 52.276326),
      MuseumPoint(name: 'Историко-краеведческий музей города Набережные Челны',
          latitude: 55.685762,
          longitude: 52.295568),
      MuseumPoint(name: 'Музей истории пожарной охраны',
          latitude: 55.75725408838926,
          longitude: 52.451413280426),
      MuseumPoint(name: 'Музей Боевой Славы (ВОВ, Афганистан, Кавказ)',
          latitude: 55.728991,
          longitude: 52.406627),
      
      // Оренбург
      MuseumPoint(name: 'Оренбургский губернаторский историко-краеведческий музей',
          latitude: 51.762057,
          longitude: 55.102219),
      MuseumPoint(name: 'Музей истории Оренбурга',
          latitude: 51.755523,
          longitude: 55.10849),
      MuseumPoint(name: 'Народный музей защитников Отечества',
          latitude: 51.77948103958744,
          longitude: 55.086406881614664),
      MuseumPoint(name: 'Мемориальный музей-гауптвахта Тараса Шевченко',
          latitude: 51.76051735005804,
          longitude: 55.10328859391786),
      MuseumPoint(name: 'Галерея выдающихся оренбуржцев',
          latitude: 51.764453,
          longitude: 55.100108),
      
      // Пенза
      MuseumPoint(name: 'Пензенский государственный краеведческий музей',
          latitude: 53.186361,
          longitude: 45.007545),
      MuseumPoint(name: 'ГБУК Пензенская областная картинная галерея имени К.А. Савицкого',
          latitude: 53.184958,
          longitude: 45.010168),
      MuseumPoint(name: 'ГБУК Объединение государственных литературно-мемориальных музеев Пензенской области',
          latitude: 53.185379,
          longitude: 45.016214),
      MuseumPoint(name: 'Музей народного творчества',
          latitude: 53.175238,
          longitude: 45.005551),
      MuseumPoint(name: 'Дом-музей В. О. Ключевского',
          latitude: 53.191988,
          longitude: 45.007707),
      
      // Чебоксары
      MuseumPoint(name: 'Чувашский государственный художественный музей',
          latitude: 56.141147,
          longitude: 47.261167),
      MuseumPoint(name: 'Центр современного искусства',
          latitude: 56.14565,
          longitude: 47.248168),
      MuseumPoint(name: 'Музей академика-кораблестроителя А.Н. Крылова',
          latitude: 56.131782,
          longitude: 47.24515),
      MuseumPoint(name: 'Археолого-этнографический музей имени профессора Каховского Василия Филипповича',
          latitude: 56.139095,
          longitude: 47.244916),
      MuseumPoint(name: 'Музей В.И. Чапаева',
          latitude: 56.116167,
          longitude: 47.257376),
      
      // Екатеринбург
      MuseumPoint(name: 'Музей истории Екатеринбурга',
          latitude: 56.840779,
          longitude: 60.611506),
      MuseumPoint(name: 'Музей Святой Царской Семьи',
          latitude: 56.843693,
          longitude: 60.60847),
      MuseumPoint(name: 'Екатеринбургский музей изобразительных искусств',
          latitude: 56.835165,
          longitude: 60.603215),
      MuseumPoint(name: 'Сделано в СССР',
          latitude: 56.839922,
          longitude: 60.634844),
      MuseumPoint(name: 'Уральский геологический музей',
          latitude: 56.826511332170824,
          longitude: 60.595503804229715),
      MuseumPoint(name: 'Музей первого президента России Б.Н. Ельцина',
          latitude: 56.844894,
          longitude: 60.591438),
      MuseumPoint(name: 'Музей радио им. А. С. Попова',
          latitude: 56.833476,
          longitude: 60.613006),
      MuseumPoint(name: 'Музей В. С. Высоцкого',
          latitude: 56.844604,
          longitude: 60.7007),
      MuseumPoint(name: 'Музей кукол и детской книги "Страна чудес"',
          latitude: 56.843432,
          longitude: 60.606512),
      
      // Челябинск
      MuseumPoint(name: 'Музей изобразительных искусств',
          latitude: 55.1593,
          longitude: 61.404224),
      MuseumPoint(name: 'Музей леса',
          latitude: 55.141423,
          longitude: 61.367798),
      MuseumPoint(name: 'Музей ЧТЗ',
          latitude: 55.160571,
          longitude: 61.434264),
      MuseumPoint(name: 'Музей истории',
          latitude: 55.168331,
          longitude: 61.397487),
      MuseumPoint(name: 'Музей памяти воинов-интернационалистов',
          latitude: 55.132109,
          longitude: 61.435091),
      
      // Тюмень
      MuseumPoint(name: 'Музей археологии и этнографии',
          latitude: 57.159526,
          longitude: 65.530977),
      MuseumPoint(name: 'Музейный комплекс им. И. Я. Словцова',
          latitude: 57.153776,
          longitude: 65.550453),
      MuseumPoint(name: 'Музей "Царская пристань"',
          latitude: 57.163016,
          longitude: 65.558394),
      MuseumPoint(name: 'Музей тюменских историй',
          latitude: 57.15629,
          longitude: 65.537427),
      MuseumPoint(name: 'Музей современного искусства',
          latitude: 57.152335,
          longitude: 65.550875),
      MuseumPoint(name: 'Музей кузнечного мастерства',
          latitude: 57.177929,
          longitude: 65.47583),
      MuseumPoint(name: 'Музей "Дом Машарова"',
          latitude: 57.158018,
          longitude: 65.526351),
      
      // Магнитогорск
      MuseumPoint(name: 'Музей военной техники',
          latitude: 53.39155,
          longitude: 58.995257),
      MuseumPoint(name: 'Музей ПАО «ММК»',
          latitude: 53.393623,
          longitude: 59.060744),
      MuseumPoint(name: 'Музей Истории Магнитостроя',
          latitude: 53.395996,
          longitude: 58.96369),
      MuseumPoint(name: 'Магнитогорская картинная галерея',
          latitude: 53.408371,
          longitude: 58.981288),
      MuseumPoint(name: 'Музей ветеранов боевых действий',
          latitude: 53.43261,
          longitude: 58.983193),
      
      // Сургут
      MuseumPoint(name: 'Сургутский Художественный Музей',
          latitude: 61.253797,
          longitude: 73.423144),
      MuseumPoint(name: 'Центр патриотического наследия',
          latitude: 61.235085,
          longitude: 73.402582),
      MuseumPoint(name: 'Школа-Музей имени А.С.Знаменского',
          latitude: 61.235843,
          longitude: 73.409508),
      
      // Нижний Тагил
      MuseumPoint(name: 'Музей истории подносного промысла «Дом Худояровых»',
          latitude: 57.908064,
          longitude: 59.938668),
      MuseumPoint(name: 'Мемориально-литературный музей писателя А.П. Бондина',
          latitude: 57.904138,
          longitude: 59.961737),
      MuseumPoint(name: 'Музей "Демидовская Дача"',
          latitude: 57.894314,
          longitude: 60.003104),
      MuseumPoint(name: 'Музей Памяти Воинов-Тагильчан',
          latitude: 57.899528,
          longitude: 59.992333),
      MuseumPoint(name: 'Историко-технический музей «Дом Черепановых»',
          latitude: 57.907562,
          longitude: 59.971474),
      
      // Курган
      MuseumPoint(name: 'Музей военной техники',
          latitude: 55.455698,
          longitude: 65.321759),
      MuseumPoint(name: 'Музей трудовой и боевой славы Курганского завода химического машиностроения',
          latitude: 55.463779,
          longitude: 65.347092),
      MuseumPoint(name: 'Музей боевой славы 165-й Седлецкой Краснознаменной ордена Кутузова II степени стрелковой дивизии',
          latitude: 55.45046,
          longitude: 65.365489),
      MuseumPoint(name: 'Курганский областной краеведческий музей',
          latitude: 55.440493,
          longitude: 65.33739),
      MuseumPoint(name: 'Музей истории города',
          latitude: 55.434727,
          longitude: 65.348664),
      MuseumPoint(name: 'Дом-музей В. К. Кюхельбекера',
          latitude: 55.430988,
          longitude: 65.340849),
      MuseumPoint(name: 'Экспозиционно-выставочный отдел Народная галерея',
          latitude: 55.437848,
          longitude: 65.35232),
      MuseumPoint(name: 'Музей колледжа',
          latitude: 55.431208,
          longitude: 65.306246),
      
      // Нижевартовск
      MuseumPoint(name: 'Музей истории русского быта',
          latitude: 60.906834,
          longitude: 76.619188),
      MuseumPoint(name: 'Краеведческий музей имени Т.Д. Шуваева',
          latitude: 60.940249,
          longitude: 76.561426),
      
      
      // Каменск-Уральский
      MuseumPoint(name: 'Каменск-Уральский Краеведческий Музей им. И.Я.Стяжкина',
          latitude: 56.418826,
          longitude: 61.892144),
      
      // Златоуст
      MuseumPoint(name: 'Металург',
          latitude: 55.17987028417672,
          longitude: 59.65483132717419),
      
      // Миасс
      MuseumPoint(name: 'Ильменский Государственный заповедник',
          latitude: 55.133236,
          longitude: 60.247275),
      
    ];
  }
  /// Популярные, знаменитые парки, музеи под открытым небом (икзампел: парк Галицкого (Краснодар), Самбекские высоты, парк Зарядье)
  List<ParkPoint> _getMapPointsP() {
    return const [
      ParkPoint(
          name: 'Парк Зарядье', latitude: 56.326797, longitude: 44.006516),
      
      
      // Казань
      ParkPoint(
          name: 'Парк Тысячелетия Казани', latitude: 55.783094, longitude: 49.126446),
      ParkPoint(
          name: 'Парк Победы', latitude: 55.829309210570905, longitude: 49.108129074096674),
      ParkPoint(
          name: 'Центральный парк культуры и отдыха имени Горького', latitude: 55.793414, longitude: 49.167023),
      
      // Самара
      ParkPoint(
          name: 'Парк Юрия Гагарина (детский парк культуры и отдыха)', latitude:53.229557133967695, longitude: 50.20058978592961),
      ParkPoint(
          name: 'Парк Победы', latitude: 53.192646, longitude: 50.200787),
      ParkPoint(
          name: 'Парк Дружбы', latitude: 53.203769524388285, longitude: 50.21815191284176),
      
      // Нижний Новгород
      ParkPoint(
          name: 'Парк "Швейцария" ', latitude: 56.28031539677496, longitude: 43.97497322064267),
      ParkPoint(
          name: 'Парк им. А. С. Пушкина', latitude: 56.30836253698265, longitude: 43.99708115249622),
      ParkPoint(
          name: 'Автозаводский парк', latitude: 56.235851, longitude: 43.855986),
      ParkPoint(
          name: 'Парк Победы', latitude: 56.32776344392905, longitude: 44.03511141454527),
      
      // Уфа
      ParkPoint(
          name: 'Сквер имени Мидхата Закировича Шакирова', latitude: 54.725034290461515, longitude: 55.95708130125798),
      ParkPoint(
          name: 'Театральный сквер', latitude: 54.72573335200597, longitude: 55.946387571505134),
      ParkPoint(
          name: 'Сквер Ленина', latitude: 54.72573945293541, longitude: 55.94639159614707),
      ParkPoint(
          name: 'Аллея современной городской скульптуры ArtTerria', latitude: 54.72058152767348, longitude: 55.9448115553253),
      ParkPoint(
          name: 'Парк имени Ленина', latitude: 54.718078, longitude: 55.943231),
      ParkPoint(
          name: 'Сквер им. Зии Нуриева', latitude: 54.715976328703334, longitude: 55.94415207011409),
      ParkPoint(
          name: 'Сад Салавата Юлаева', latitude: 54.71222766045911, longitude: 55.952360950401285),
      
      // Пермь
      ParkPoint(
          name: 'Особо охраняемая природная территория местного значения – охраняемый природный ландшафт Черняевский лес', latitude: 57.983754, longitude: 56.153778),
      ParkPoint(
          name: 'Сад имени В. Л. Миндовского', latitude: 57.982495980767176, longitude: 56.20489978339288),
      ParkPoint(
          name: 'Слудская горка', latitude: 58.009997, longitude: 56.218798),
      ParkPoint(
          name: 'Сад имени Гоголя', latitude: 58.014965, longitude: 56.220936),
      ParkPoint(
          name: 'Театральный сад', latitude: 58.015018, longitude: 56.246763),
      ParkPoint(
          name: 'Сад Декабристов', latitude: 58.013435, longitude: 56.260543),
      
      // Самара
      ParkPoint(
          name: 'Детский парк', latitude: 51.53173866070316, longitude: 46.00755361143541),
      ParkPoint(
          name: 'сквер им. О. И. Янковского', latitude: 51.532377893910734, longitude: 46.03449699755856),
      ParkPoint(
          name: 'Городской парк культуры и отдыха', latitude: 51.52003, longitude: 45.997399),
      ParkPoint(
          name: 'Сквер Имени 1905 Года', latitude: 51.533562, longitude: 46.034266),
      
      // Тольятти
      ParkPoint(
          name: 'Центральный парк культуры и отдыха', latitude: 53.50983118817226, longitude: 49.41875647148436),
      ParkPoint(
          name: 'ФАННИ Парк', latitude: 53.517501, longitude: 49.266467),
      ParkPoint(
          name: 'Дендропарк', latitude: 53.540618, longitude: 49.370941),
      ParkPoint(
          name: 'Сквер "32 квартал"', latitude: 53.574606569327216, longitude: 49.07816719279854),
      
      // Ижевск
      ParkPoint(
          name: 'парк имени Горького', latitude: 56.846981, longitude: 53.198528),
      ParkPoint(
          name: 'Козий парк', latitude: 56.858587, longitude: 53.233391),
      ParkPoint(
          name: 'Сквер им. Татьяны Барамзиной', latitude: 56.86258773286028, longitude: 53.27932299964397),
      
      // Ульяновск
      ParkPoint(
          name: 'Сквер Ивана Яковлева', latitude: 54.309744785613546, longitude:48.37957619957372),
      ParkPoint(
          name: 'Сквер Строителей', latitude: 54.30548518073345, longitude: 48.38218070240778),
      ParkPoint(
          name: 'Парк Газовиков и Нефтяков', latitude: 54.339829451150635, longitude: 48.37591619999099),
      
      //Набережные Челны
      ParkPoint(
          name: 'Парк Культуры И Отдыха', latitude: 55.682869, longitude: 52.28477),
      ParkPoint(
          name: 'Парк Гренада', latitude: 55.73320327385288, longitude: 52.41746245401297),
      ParkPoint(
          name: 'Парк Прибрежный ', latitude: 55.75782, longitude: 52.384537),
      
      // Оренбург
      ParkPoint(
          name: 'Парк "Тополя"', latitude: 51.769702089470414, longitude: 55.092514966903636),
      ParkPoint(
          name: 'Железнодорожный парк имени В.И. Ленина', latitude: 51.77175782876066, longitude: 55.08496659790034),
      ParkPoint(
          name: 'Сквер у Дома Советов', latitude: 51.767473594252415, longitude: 55.09761894893012),
      
      // Пенза
      ParkPoint(
          name: 'Парк Союз', latitude: 53.18406092970557, longitude: 44.97629661932136),
      ParkPoint(
          name: 'Аллея 70-летия Великой Победы', latitude: 53.165587, longitude: 44.999694),
      ParkPoint(
          name: 'Пионерский сквер', latitude: 53.211897,longitude: 44.990495 ),
      ParkPoint(
          name: 'Сквер имени М. Ю. Лермонтова', latitude: 53.18289315407612, longitude: 45.0124893134918),
      
      // Чебоксары
      ParkPoint(
          name: 'Парк Роща Гузовского', latitude: 56.136983, longitude: 47.176976),
      ParkPoint(
          name: 'Центральный парк культуры и отдыха Лакреевский лес', latitude: 56.117321, longitude: 47.24117),
      ParkPoint(
          name: 'Мемориальный Парк Победы', latitude: 56.14742850642577, longitude: 47.26801031877135),
      ParkPoint(
          name: 'сквер имени Н.И. Пирогова', latitude: 56.141578, longitude: 47.21829),
      
      // Екатеринбург
      ParkPoint(
          name: 'Зелёная роща', latitude: 56.82109788581832, longitude: 60.59482023320735),
      ParkPoint(
          name: 'ЦПКиО им. В. В. Маяковского', latitude: 56.81471, longitude: 60.645274),
      ParkPoint(
          name: 'сквер имени Н.И. Пирогова', latitude: 56.826587, longitude: 60.620265),
      ParkPoint(
          name: 'Парк Им. 50 - летия Советской Власти', latitude: 56.826138, longitude: 60.615117),
      ParkPoint(
          name: 'Дендрологический парк-выставка', latitude: 56.829547, longitude: 60.604383),
      
      // Челябинск
      ParkPoint(
          name: 'Кленовая роща', latitude: 55.164053, longitude: 61.407135),
      ParkPoint(
          name: 'Парк Гагарина', latitude: 55.158169, longitude: 61.363405),
      ParkPoint(
          name: 'Детский парк им. В.В. Терешковой', latitude: 55.159393, longitude: 61.443175),
      ParkPoint(
          name: 'Парк имени А. С. Пушкина', latitude: 55.152526, longitude: 61.403578),
      ParkPoint(
          name: 'Сквер им. Колющенко', latitude: 55.139905, longitude: 61.392501),
      
      // Тюмень
      ParkPoint(
          name: 'Городской парк культуры и отдыха г. Тюмени', latitude: 57.152223,longitude: 65.532675 ),
      ParkPoint(
          name: 'Александровский Сад', latitude: 57.157676, longitude: 65.568796),
      ParkPoint(
          name: 'Сквер Петра Потапова', latitude: 57.158506, longitude: 65.574599),
      ParkPoint(
          name: 'Экопарк "Затюменский"', latitude: 57.163426, longitude: 65.460118),
      ParkPoint(
          name: 'Сквер Авиаторов', latitude: 57.143439, longitude: 65.497551),
      
      // Магнитогорск
      ParkPoint(
          name: 'Парк у Вечного огня', latitude: 53.402729, longitude: 58.987622),
      ParkPoint(
          name: 'Парк Магниткиул', latitude: 53.402299, longitude: 58.952803),
      ParkPoint(
          name: 'Сквер "Магнит"', latitude: 53.37742, longitude: 58.974803),
      ParkPoint(
          name: 'Экологический парк', latitude: 53.402299, longitude: 58.952803),
      ParkPoint(
          name: 'Парк Культуры и Отдыха Ветеранов', latitude: 53.428463, longitude: 59.000306),
      
      // Сургут
      ParkPoint(
          name: 'Парк Газпром', latitude: 61.244977, longitude: 73.403812),
      ParkPoint(
          name: 'Сургутский Ботанический Сад', latitude: 61.248175, longitude: 73.432181),
      ParkPoint(
          name: 'Кедровый Лог', latitude: 61.262635, longitude: 73.356139),
      ParkPoint(
          name: 'Парк Нефтяник', latitude: 61.259770019847515, longitude: 73.35610012530165),
      ParkPoint(
          name: 'Парк Энергетиков имени БСФ', latitude: 61.248292, longitude: 73.391281),
      
      // Нижний Тагил
      ParkPoint(
          name: 'Лагуна-2', latitude: 57.899614, longitude: 59.991273),
      ParkPoint(
          name: 'Театральный сквер', latitude: 57.906381,longitude: 59.97231),
      ParkPoint(
          name: 'Нижнетагильский городской парк культуры и отдыха', latitude: 57.907562, longitude: 59.971474),
      ParkPoint(
          name: 'Парк им. М. Горького', latitude: 57.920083, longitude: 59.937608),
      
      // Курган
      ParkPoint(
          name: 'Курган-Парк Ландшафтный парк', latitude: 55.458613, longitude: 65.282755),
      ParkPoint(
          name: 'Курган-Парк', latitude: 55.437659, longitude: 65.341226),
      ParkPoint(
          name: 'Центральный парк культуры и отдыха', latitude: 55.430845, longitude: 65.326952),
      

      // Нижневартовск
      ParkPoint(
          name: 'Парк победы', latitude: 60.932465, longitude: 76.564822),
      
      
      // Каменск-Уральский
      ParkPoint(
          name: 'ПКиО', latitude: 56.38328505809856, longitude: 61.97519984788508),
      ParkPoint(
          name: 'Разгуляевский лесопарк', latitude: 56.40626238246093, longitude: 61.91753674063027),
      
      
      // Златоуст 
      ParkPoint(
          name: 'Крылатко', latitude: 55.14792389476495, longitude: 59.67162652472473),
      
      // Миасс
      ParkPoint(
          name: 'Крылатко', latitude: 55.05069855594692, longitude: 60.10626176602715),
      
    ];
  }
  /// Открытые виды, пространства (икзампел: гора Машук, колесо обозрения в парке Революции, Лахта-центр)
  List<OutsidePoint> _getMapPointsO() {
    return const [
      OutsidePoint(name: 'Останкинская башня',
          latitude: 55.795712,
          longitude: 37.611704),
      
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
      
      // Екатеринбург
      OutsidePoint(name: 'Колесо обозрения',
          latitude: 56.817183,
          longitude: 60.538536),
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 56.864772,
          longitude: 60.545776),
      OutsidePoint(name: 'Башня Исеть',
          latitude: 56.843526,
          longitude: 60.590539),
      OutsidePoint(name: 'Смотровая площадка',
          latitude: 56.836106,
          longitude: 60.61465),
      
      // Челябинск
      OutsidePoint(name: 'Колесо Обозрения "Горки"',
          latitude: 55.163513,
          longitude: 61.430931),
      OutsidePoint(name: 'Колесо обозрения 360',
          latitude: 55.169961,
          longitude: 61.3911),
      OutsidePoint(name: 'Челябинская Телебашня',
          latitude: 55.152835,
          longitude: 61.405302),
      
      // Тюмень
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 57.152985,
          longitude: 65.541227),
      OutsidePoint(name: 'Водонапорная Башня',
          latitude: 57.150563,
          longitude: 65.542835),
      
      // Магнитогорск
      OutsidePoint(name: 'Город веселых коротышек',
          latitude: 53.398369,
          longitude: 58.989625),
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 53.41362,
          longitude: 58.972692),
      
      // Сургут
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 61.259802,
          longitude: 73.356076),
      
      // Нижний Тагил
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 55.430845,
          longitude: 65.326952),
      
      // Каменск-Уральский
      OutsidePoint(name: 'Колесо Обозрения',
          latitude: 55.430845,
          longitude: 65.326952),
      

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

