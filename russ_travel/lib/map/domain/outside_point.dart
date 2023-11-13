import 'package:equatable/equatable.dart';

/// Класс для открытых видов

/// Модель точки на карте
class OutsidePoint extends Equatable {
  const OutsidePoint({
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