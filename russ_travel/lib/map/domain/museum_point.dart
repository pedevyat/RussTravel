import 'package:equatable/equatable.dart';

/// Класс для музеев

/// Модель точки на карте
class MuseumPoint extends Equatable {
  const MuseumPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });


  /// Название населенного пункта
  final String name;


  /// Широта
  final double latitude;


  /// Долгота
  final double longitude;


  @override
  List<Object?> get props => [name, latitude, longitude];

  /// Создание объекта OutsidePoint из JSON данных
  factory MuseumPoint.fromJson(Map<String, dynamic> json) {
    return MuseumPoint(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}