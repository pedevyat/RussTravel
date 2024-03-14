import 'dart:convert';
import 'dart:io';
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

  /// Создание объекта OutsidePoint из JSON данных
  factory ParkPoint.fromJson(Map<String, dynamic> json) {
    return ParkPoint(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

