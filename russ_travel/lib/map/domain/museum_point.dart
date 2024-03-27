import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Класс для музеев

/// Модель точки на карте
class MuseumPoint extends Equatable {
  const MuseumPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.photoUrl, // Добавлено новое поле для ссылки на фото
  });

  /// Название населенного пункта
  final String name;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  /// Ссылка на фото
  final String photoUrl; // Добавлено новое поле для ссылки на фото

  @override
  List<Object?> get props => [name, latitude, longitude, photoUrl];

  /// Создание объекта MuseumPoint из JSON данных
  factory MuseumPoint.fromJson(Map<String, dynamic> json) {
    return MuseumPoint(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photoUrl: json['photoUrl'], // Получаем ссылку на фото из JSON
    );
  }
}