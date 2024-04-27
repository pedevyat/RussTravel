import 'package:equatable/equatable.dart';

/// Класс для отелей

/// Модель точки на карте
class HotelPoint extends Equatable {
  const HotelPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.url,
  });


  /// Название отеля
  final String name;


  /// Широта
  final double latitude;


  /// Долгота
  final double longitude;

  /// Сайт отеля
  final String url;


  @override
  List<Object?> get props => [name, latitude, longitude];

  /// Создание объекта HotelPoint из JSON данных
  factory HotelPoint.fromJson(Map<String, dynamic> json) {
    return HotelPoint(
      name: json['tags']['name'] ?? '',
      latitude: json['lat'].toDouble(),
      longitude: json['lon'].toDouble(),
      url: json['tags']['website'] ?? '',
    );
  }
}