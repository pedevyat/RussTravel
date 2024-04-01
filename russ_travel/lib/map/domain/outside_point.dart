import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';

/// Класс для открытых видов

/// Модель точки на карте
class OutsidePoint extends Equatable {
  const OutsidePoint({
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
  factory OutsidePoint.fromJson(Map<String, dynamic> json) {
    return OutsidePoint(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      photoUrl: json['photoUrl'],
    );
  }
}