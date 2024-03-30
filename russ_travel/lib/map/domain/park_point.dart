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
    required this.photoUrl,
  });

  /// Название населенного пункта
  final String name;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  /// Ссылка на фото
  final String photoUrl;

  @override
  List<Object?> get props => [name, latitude, longitude, photoUrl];

  /// Создание объекта OutsidePoint из JSON данных
  factory ParkPoint.fromJson(Map<String, dynamic> json) {
    return ParkPoint(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photoUrl: json['photoUrl'],
    );
  }
}

