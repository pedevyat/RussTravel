import 'package:equatable/equatable.dart';

/// Класс для отелей

/// Модель точки на карте
class HotelPoint extends Equatable {
  const HotelPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.url,
    required this.price,
    required this.phone,
    required this.description
  });


  /// Название отеля
  final String name;


  /// Широта
  final double latitude;


  /// Долгота
  final double longitude;

  /// Сайт отеля
  final String url;

  /// Начальная цена
  final String price;

  final String phone;

  final String description;


  @override
  List<Object?> get props => [name, latitude, longitude, url, price, phone, description];

  /// Создание объекта HotelPoint из JSON данных
  factory HotelPoint.fromJson(Map<String, dynamic> json) {
    return HotelPoint(
      name: json['tags']['name'] ?? 'Место проживания',
      latitude: json['lat'].toDouble(),
      longitude: json['lon'].toDouble(),
      phone: json['tags']['phone'] ?? '',
      url: json['tags']['website'] ?? '',
      price: json['tags']['begin_price'] ?? '',
      description: json['tags']['description'] ?? '',
    );
  }
}