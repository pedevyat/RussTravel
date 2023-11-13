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
}