import 'package:equatable/equatable.dart';

/// Класс для парков

/// Модель точки на карте
class ParkPoint extends Equatable {
  const ParkPoint({
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