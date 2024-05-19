import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';

/// Класс для парков

/// Модель точки на карте
class ParkPoint extends Equatable {
  ParkPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
  });

  int id;
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
      id : 0,
      name: json['name'] ?? json['tags']['name'] ?? 'Место прогулки',
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      photoUrl: json['photoUrl'] ?? 'https://cdn-icons-png.flaticon.com/512/4760/4760417.png',
    );
  }
}

